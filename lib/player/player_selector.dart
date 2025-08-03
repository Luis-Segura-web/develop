import 'package:video_player/video_player.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import '../models/service_profile.dart';
import '../models/stream_item.dart';
import '../services/stream_url_builder.dart';
import '../storage/profile_repository.dart';
import '../analytics/playback_logger.dart';

/// Selector de reproductor con soporte dual de motores
class PlayerSelector {
  static PlayerSelector? _instance;
  
  VideoPlayerController? _videoPlayerController;
  VlcPlayerController? _vlcPlayerController;
  
  PlayerEngine _currentEngine = PlayerEngine.media3;
  String? _currentUrl;
  ServiceProfile? _currentProfile;
  StreamItem? _currentItem;
  
  final ProfileRepository _profileRepository = ProfileRepository();
  final PlaybackLogger _playbackLogger = PlaybackLogger();
  
  PlayerSelector._internal();
  
  static PlayerSelector get instance {
    _instance ??= PlayerSelector._internal();
    return _instance!;
  }

  /// Obtener controlador activo según el motor actual
  dynamic get activeController {
    switch (_currentEngine) {
      case PlayerEngine.media3:
        return _videoPlayerController;
      case PlayerEngine.vlc:
        return _vlcPlayerController;
    }
  }

  /// Verificar si hay un reproductor activo
  bool get hasActivePlayer {
    return _videoPlayerController != null || _vlcPlayerController != null;
  }

  /// Obtener motor de reproducción actual
  PlayerEngine get currentEngine => _currentEngine;

  /// Obtener URL actual en reproducción
  String? get currentUrl => _currentUrl;

  /// Reproducir stream con el motor preferido
  Future<void> play(String url, ServiceProfile serviceProfile, StreamItem item) async {
    try {
      _currentProfile = serviceProfile;
      _currentItem = item;
      _currentUrl = url;
      _currentEngine = serviceProfile.preferredEngine;
      
      // Log inicio de reproducción
      _playbackLogger.logPlayStarted(
        url: url,
        engine: _currentEngine,
        streamType: _getStreamType(item),
        streamId: item.streamId,
      );
      
      // Detener reproducción actual si existe
      await stop();
      
      // Intentar reproducir con motor preferido
      final success = await _playWithEngine(_currentEngine, url);
      
      if (!success) {
        // Fallback al otro motor
        final fallbackEngine = _currentEngine == PlayerEngine.media3 
            ? PlayerEngine.vlc 
            : PlayerEngine.media3;
        
        final fallbackSuccess = await _playWithEngine(fallbackEngine, url);
        
        if (fallbackSuccess) {
          _currentEngine = fallbackEngine;
          // Actualizar preferencia del perfil para futuras reproducciones
          await _updateProfileEngine(serviceProfile, fallbackEngine);
        } else {
          // Si ambos motores fallan, intentar con URLs alternativas
          await _tryFallbackUrls(serviceProfile, item);
        }
      }
      
    } catch (e) {
      _playbackLogger.logPlayFailed(
        url: url,
        engine: _currentEngine,
        error: e.toString(),
        streamId: item.streamId,
      );
      rethrow;
    }
  }

  /// Reproducir con motor específico
  Future<bool> _playWithEngine(PlayerEngine engine, String url) async {
    try {
      switch (engine) {
        case PlayerEngine.media3:
          return await _playWithMedia3(url);
        case PlayerEngine.vlc:
          return await _playWithVLC(url);
      }
    } catch (e) {
      return false;
    }
  }

  /// Reproducir con Media3 (video_player)
  Future<bool> _playWithMedia3(String url) async {
    try {
      _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url));
      await _videoPlayerController!.initialize();
      await _videoPlayerController!.play();
      return true;
    } catch (e) {
      await _videoPlayerController?.dispose();
      _videoPlayerController = null;
      return false;
    }
  }

  /// Reproducir con VLC
  Future<bool> _playWithVLC(String url) async {
    try {
      _vlcPlayerController = VlcPlayerController.network(
        url,
        hwAcc: HwAcc.full,
        autoPlay: true,
        options: VlcPlayerOptions(
          advanced: VlcAdvancedOptions([
            VlcAdvancedOptions.networkCaching(2000),
            VlcAdvancedOptions.clockJitter(0),
            VlcAdvancedOptions.clockSynchro(0),
          ]),
          http: VlcHttpOptions([
            VlcHttpOptions.httpReconnect(true),
          ]),
          rtp: VlcRtpOptions([
            VlcRtpOptions.rtpOverRtsp(true),
          ]),
        ),
      );
      
      await _vlcPlayerController!.initialize();
      return true;
    } catch (e) {
      await _vlcPlayerController?.dispose();
      _vlcPlayerController = null;
      return false;
    }
  }

  /// Intentar reproducir con URLs alternativas
  Future<void> _tryFallbackUrls(ServiceProfile serviceProfile, StreamItem item) async {
    final fallbackUrls = StreamUrlBuilder.buildFallbackUrls(serviceProfile, item);
    
    for (final url in fallbackUrls) {
      if (url == _currentUrl) continue; // Saltar URL original que ya falló
      
      final success = await _playWithEngine(_currentEngine, url);
      if (success) {
        _currentUrl = url;
        return;
      }
    }
    
    throw Exception('No se pudo reproducir el stream con ninguna URL alternativa');
  }

  /// Cambiar motor de reproducción
  Future<void> switchEngine() async {
    if (!hasActivePlayer || _currentProfile == null || _currentItem == null) {
      throw Exception('No hay reproducción activa para cambiar motor');
    }
    
    final newEngine = _currentEngine == PlayerEngine.media3 
        ? PlayerEngine.vlc 
        : PlayerEngine.media3;
    
    // Guardar posición actual si es posible
    Duration? currentPosition;
    if (_videoPlayerController != null && _videoPlayerController!.value.isInitialized) {
      currentPosition = _videoPlayerController!.value.position;
    }
    
    // Detener reproducción actual
    await stop();
    
    // Cambiar motor y reproducir
    _currentEngine = newEngine;
    final success = await _playWithEngine(newEngine, _currentUrl!);
    
    if (success) {
      // Intentar restaurar posición si se obtuvo
      if (currentPosition != null) {
        await _seekTo(currentPosition);
      }
      
      // Actualizar preferencia en el perfil
      await _updateProfileEngine(_currentProfile!, newEngine);
      
      _playbackLogger.logEngineSwitch(
        fromEngine: _currentEngine == PlayerEngine.media3 ? PlayerEngine.vlc : PlayerEngine.media3,
        toEngine: newEngine,
        url: _currentUrl!,
        streamId: _currentItem!.streamId,
      );
    } else {
      throw Exception('No se pudo cambiar al motor ${newEngine.name}');
    }
  }

  /// Buscar posición específica
  Future<void> _seekTo(Duration position) async {
    switch (_currentEngine) {
      case PlayerEngine.media3:
        if (_videoPlayerController != null && _videoPlayerController!.value.isInitialized) {
          await _videoPlayerController!.seekTo(position);
        }
        break;
      case PlayerEngine.vlc:
        if (_vlcPlayerController != null) {
          await _vlcPlayerController!.seekTo(position);
        }
        break;
    }
  }

  /// Pausar reproducción
  Future<void> pause() async {
    switch (_currentEngine) {
      case PlayerEngine.media3:
        if (_videoPlayerController != null && _videoPlayerController!.value.isInitialized) {
          await _videoPlayerController!.pause();
        }
        break;
      case PlayerEngine.vlc:
        if (_vlcPlayerController != null) {
          await _vlcPlayerController!.pause();
        }
        break;
    }
  }

  /// Reanudar reproducción
  Future<void> resume() async {
    switch (_currentEngine) {
      case PlayerEngine.media3:
        if (_videoPlayerController != null && _videoPlayerController!.value.isInitialized) {
          await _videoPlayerController!.play();
        }
        break;
      case PlayerEngine.vlc:
        if (_vlcPlayerController != null) {
          await _vlcPlayerController!.play();
        }
        break;
    }
  }

  /// Detener reproducción
  Future<void> stop() async {
    if (_videoPlayerController != null) {
      await _videoPlayerController!.dispose();
      _videoPlayerController = null;
    }
    
    if (_vlcPlayerController != null) {
      await _vlcPlayerController!.dispose();
      _vlcPlayerController = null;
    }
    
    _currentUrl = null;
  }

  /// Actualizar motor preferido en el perfil
  Future<void> _updateProfileEngine(ServiceProfile profile, PlayerEngine engine) async {
    try {
      await _profileRepository.setPreferredEngine(profile.id, engine);
    } catch (e) {
      // Log error pero no fallar la reproducción
      print('Error al actualizar motor preferido: $e');
    }
  }

  /// Obtener tipo de stream para logging
  String _getStreamType(StreamItem item) {
    if (item is LiveStreamItem) return 'live';
    if (item is VodStreamItem) return 'vod';
    if (item is SeriesStreamItem) return 'series';
    return 'unknown';
  }

  /// Obtener información del estado actual
  Map<String, dynamic> getPlayerState() {
    final state = <String, dynamic>{
      'hasActivePlayer': hasActivePlayer,
      'currentEngine': _currentEngine.name,
      'currentUrl': _currentUrl,
    };
    
    switch (_currentEngine) {
      case PlayerEngine.media3:
        if (_videoPlayerController != null) {
          final value = _videoPlayerController!.value;
          state['isInitialized'] = value.isInitialized;
          state['isPlaying'] = value.isPlaying;
          state['position'] = value.position.inMilliseconds;
          state['duration'] = value.duration.inMilliseconds;
          state['buffered'] = value.buffered.isNotEmpty 
              ? value.buffered.last.end.inMilliseconds 
              : 0;
        }
        break;
      case PlayerEngine.vlc:
        if (_vlcPlayerController != null) {
          state['isInitialized'] = _vlcPlayerController!.value.isInitialized;
          state['isPlaying'] = _vlcPlayerController!.value.isPlaying;
          state['position'] = _vlcPlayerController!.value.position.inMilliseconds;
          state['duration'] = _vlcPlayerController!.value.duration.inMilliseconds;
        }
        break;
    }
    
    return state;
  }

  /// Liberar recursos
  void dispose() {
    stop();
    _instance = null;
  }
}