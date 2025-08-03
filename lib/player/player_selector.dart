import 'package:video_player/video_player.dart';
import '../models/service_profile.dart';
import '../models/stream_item.dart';
import '../core/constants.dart';

/// Selector de motor de reproducción para streams IPTV
class PlayerSelector {
  static PlayerSelector? _instance;
  
  VideoPlayerController? _videoPlayerController;
  // VlcPlayerController? _vlcPlayerController; // Disabled due to SDK compatibility
  
  PlayerEngine _currentEngine = PlayerEngine.media3;
  String? _currentUrl;
  ServiceProfile? _currentProfile;
  StreamItem? _currentItem;
  
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
        // return _vlcPlayerController; // Disabled
        return null;
    }
  }

  /// Verificar si hay un reproductor activo
  bool get hasActivePlayer {
    return _videoPlayerController != null; // || _vlcPlayerController != null;
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
      
      // Determinar motor preferido del perfil
      final preferredEngine = serviceProfile.preferredEngine == 'vlc' 
          ? PlayerEngine.vlc 
          : PlayerEngine.media3;
      
      _currentEngine = preferredEngine;
      
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
        } else {
          throw Exception('No se pudo reproducir el stream con ningún motor');
        }
      }
      
    } catch (e) {
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

  /// Reproducir con VLC (disabled)
  Future<bool> _playWithVLC(String url) async {
    // VLC player disabled due to SDK compatibility
    return false;
  }

  /// Cambiar motor de reproducción
  Future<void> switchEngine() async {
    if (_currentUrl == null || _currentProfile == null || _currentItem == null) {
      throw Exception('No hay stream activo para cambiar motor');
    }
    
    final newEngine = _currentEngine == PlayerEngine.media3 
        ? PlayerEngine.vlc 
        : PlayerEngine.media3;
    
    await _playWithEngine(newEngine, _currentUrl!);
    _currentEngine = newEngine;
  }

  /// Detener reproducción
  Future<void> stop() async {
    if (_videoPlayerController != null) {
      await _videoPlayerController!.dispose();
      _videoPlayerController = null;
    }
    
    // if (_vlcPlayerController != null) {
    //   await _vlcPlayerController!.dispose();
    //   _vlcPlayerController = null;
    // }
  }

  /// Obtener estado del reproductor
  Map<String, dynamic> getPlayerState() {
    return {
      'hasActivePlayer': hasActivePlayer,
      'currentEngine': _currentEngine.name,
      'currentUrl': _currentUrl,
      'isPlaying': _videoPlayerController?.value.isPlaying ?? false,
      'position': _videoPlayerController?.value.position.inSeconds ?? 0,
      'duration': _videoPlayerController?.value.duration.inSeconds ?? 0,
    };
  }

  /// Limpiar recursos
  void dispose() {
    stop();
    _currentProfile = null;
    _currentItem = null;
    _currentUrl = null;
  }
}
