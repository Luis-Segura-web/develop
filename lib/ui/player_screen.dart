import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
// import 'package:flutter_vlc_player/flutter_vlc_player.dart'; // Disabled due to SDK compatibility
import '../models/service_profile.dart';
import '../models/stream_item.dart';
import '../player/player_selector.dart';
import '../services/stream_url_builder.dart';
import '../core/constants.dart';

/// Pantalla principal del reproductor con UI en español latino
class PlayerScreen extends StatefulWidget {
  final ServiceProfile serviceProfile;
  final StreamItem streamItem;

  const PlayerScreen({
    super.key,
    required this.serviceProfile,
    required this.streamItem,
  });

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final PlayerSelector _playerSelector = PlayerSelector.instance;
  bool _isLoading = true;
  bool _hasError = false;
  String? _errorMessage;
  bool _showControls = true;
  bool _isFullscreen = false;
  
  // Información del stream
  String? _currentBitrate;
  String? _currentResolution;
  String? _currentCodec;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
    _setupControlsTimer();
  }

  /// Inicializar reproductor
  Future<void> _initializePlayer() async {
    try {
      setState(() {
        _isLoading = true;
        _hasError = false;
        _errorMessage = null;
      });

      final streamUrl = StreamUrlBuilder.buildRecommendedUrl(
        widget.serviceProfile,
        widget.streamItem,
      );

      await _playerSelector.play(streamUrl, widget.serviceProfile, widget.streamItem);

      setState(() {
        _isLoading = false;
      });

      _updateStreamInfo();
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
        _errorMessage = e.toString();
      });
    }
  }

  /// Configurar timer para ocultar controles automáticamente
  void _setupControlsTimer() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showControls = false;
        });
      }
    });
  }

  /// Actualizar información del stream
  void _updateStreamInfo() {
    final playerState = _playerSelector.getPlayerState();
    
    // Extraer información real del stream según el motor activo
    setState(() {
      switch (_playerSelector.currentEngine) {
        case PlayerEngine.media3:
          final controller = _playerSelector.activeController as VideoPlayerController?;
          if (controller != null && controller.value.isInitialized) {
            final videoSize = controller.value.size;
            _currentResolution = '${videoSize.width.round()}x${videoSize.height.round()}';
            
            // Determinar calidad basada en resolución
            if (videoSize.height >= 1080) {
              _currentBitrate = '1080p';
            } else if (videoSize.height >= 720) {
              _currentBitrate = '720p';
            } else if (videoSize.height >= 480) {
              _currentBitrate = '480p';
            } else {
              _currentBitrate = '360p';
            }
            
            _currentCodec = 'H.264'; // Media3 principalmente usa H.264
          } else {
            _currentBitrate = 'Cargando...';
            _currentResolution = 'Detectando...';
            _currentCodec = 'N/A';
          }
          break;
          
        case PlayerEngine.vlc:
          // VLC player disabled due to SDK compatibility
          /*
          final controller = _playerSelector.activeController as VlcPlayerController?;
          if (controller != null && controller.value.isInitialized) {
            // VLC puede proporcionar información más detallada del stream
            _currentBitrate = 'Auto';
            _currentResolution = 'Adaptativa';
            _currentCodec = 'Multi';
          } else {
            _currentBitrate = 'Conectando...';
            _currentResolution = 'Detectando...';
            _currentCodec = 'N/A';
          }
          */
          _currentBitrate = 'N/A';
          _currentResolution = 'N/A';
          _currentCodec = 'N/A';
          break;
      }
    });
  }

  /// Cambiar motor de reproducción
  Future<void> _switchEngine() async {
    try {
      setState(() {
        _isLoading = true;
      });

      await _playerSelector.switchEngine();

      setState(() {
        _isLoading = false;
      });

      _updateStreamInfo();

      _showSnackBar('Motor cambiado a ${_playerSelector.currentEngine.name}');
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showErrorDialog('Error al cambiar motor', e.toString());
    }
  }

  /// Alternar pantalla completa
  void _toggleFullscreen() {
    setState(() {
      _isFullscreen = !_isFullscreen;
    });

    if (_isFullscreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    }
  }

  /// Mostrar/ocultar controles
  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });

    if (_showControls) {
      _setupControlsTimer();
    }
  }

  /// Reproducir/pausar
  Future<void> _togglePlayPause() async {
    try {
      final playerState = _playerSelector.getPlayerState();
      final isPlaying = playerState['isPlaying'] ?? false;

      if (isPlaying) {
        await _playerSelector.pause();
      } else {
        await _playerSelector.resume();
      }
    } catch (e) {
      _showErrorDialog('Error de reproducción', e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _isFullscreen ? null : _buildAppBar(),
      body: _buildPlayerBody(),
    );
  }

  /// Construir barra de aplicación
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.black87,
      foregroundColor: Colors.white,
      title: Text(
        widget.streamItem.name,
        style: const TextStyle(fontSize: 16),
        overflow: TextOverflow.ellipsis,
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.switch_video),
          onPressed: _switchEngine,
          tooltip: 'Cambiar motor de reproducción',
        ),
        IconButton(
          icon: const Icon(Icons.fullscreen),
          onPressed: _toggleFullscreen,
          tooltip: 'Pantalla completa',
        ),
      ],
    );
  }

  /// Construir cuerpo del reproductor
  Widget _buildPlayerBody() {
    return GestureDetector(
      onTap: _toggleControls,
      child: Stack(
        children: [
          // Reproductor de video
          _buildVideoPlayer(),
          
          // Controles superpuestos
          if (_showControls) _buildOverlayControls(),
          
          // Indicador de carga
          if (_isLoading) _buildLoadingIndicator(),
          
          // Pantalla de error
          if (_hasError) _buildErrorScreen(),
          
          // Información del stream
          if (_showControls && !_hasError) _buildStreamInfo(),
        ],
      ),
    );
  }

  /// Construir reproductor de video según motor activo
  Widget _buildVideoPlayer() {
    if (_hasError) {
      return const SizedBox.expand();
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _buildPlayerForCurrentEngine(),
    );
  }

  /// Construir reproductor según motor actual
  Widget _buildPlayerForCurrentEngine() {
    switch (_playerSelector.currentEngine) {
      case PlayerEngine.media3:
        return _buildMedia3Player();
      case PlayerEngine.vlc:
        return _buildVLCPlayer();
    }
  }

  /// Construir reproductor Media3
  Widget _buildMedia3Player() {
    final controller = _playerSelector.activeController as VideoPlayerController?;
    
    if (controller == null || !controller.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    return Center(
      child: AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: VideoPlayer(controller),
      ),
    );
  }

  /// Construir reproductor VLC
  Widget _buildVLCPlayer() {
    // VLC player disabled due to SDK compatibility
    return const Center(
      child: Text(
        'Reproductor VLC no disponible\n(Incompatibilidad de SDK)',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  /// Construir controles superpuestos
  Widget _buildOverlayControls() {
    return Container(
      color: Colors.black26,
      child: Column(
        children: [
          // Controles superiores
          _buildTopControls(),
          const Spacer(),
          // Controles centrales
          _buildCenterControls(),
          const Spacer(),
          // Controles inferiores
          _buildBottomControls(),
        ],
      ),
    );
  }

  /// Controles superiores
  Widget _buildTopControls() {
    if (_isFullscreen) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
              Expanded(
                child: Text(
                  widget.streamItem.name,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.switch_video, color: Colors.white),
                onPressed: _switchEngine,
              ),
            ],
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  /// Controles centrales
  Widget _buildCenterControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: const Icon(Icons.replay_10, color: Colors.white, size: 40),
          onPressed: () async {
            try {
              await _playerSelector.seekBackward(const Duration(seconds: 10));
              _showSnackBar('Retrocedido 10 segundos');
            } catch (e) {
              _showSnackBar('Error al retroceder: ${e.toString()}');
            }
          },
        ),
        IconButton(
          icon: Icon(
            _isPlayerPlaying() ? Icons.pause : Icons.play_arrow,
            color: Colors.white,
            size: 60,
          ),
          onPressed: _togglePlayPause,
        ),
        IconButton(
          icon: const Icon(Icons.forward_10, color: Colors.white, size: 40),
          onPressed: () async {
            try {
              await _playerSelector.seekForward(const Duration(seconds: 10));
              _showSnackBar('Avanzado 10 segundos');
            } catch (e) {
              _showSnackBar('Error al avanzar: ${e.toString()}');
            }
          },
        ),
      ],
    );
  }

  /// Controles inferiores
  Widget _buildBottomControls() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              _playerSelector.currentEngine == PlayerEngine.media3
                  ? Icons.video_library
                  : Icons.play_circle,
              color: Colors.white,
            ),
            onPressed: _switchEngine,
            tooltip: 'Motor: ${_playerSelector.currentEngine.name}',
          ),
          const Spacer(),
          if (!_isFullscreen)
            IconButton(
              icon: const Icon(Icons.fullscreen, color: Colors.white),
              onPressed: _toggleFullscreen,
            ),
        ],
      ),
    );
  }

  /// Información del stream
  Widget _buildStreamInfo() {
    return Positioned(
      top: _isFullscreen ? 80 : 16,
      right: 16,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Motor: ${_playerSelector.currentEngine.name.toUpperCase()}',
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
            if (_currentBitrate != null)
              Text(
                'Calidad: $_currentBitrate',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            if (_currentCodec != null)
              Text(
                'Códec: $_currentCodec',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
          ],
        ),
      ),
    );
  }

  /// Indicador de carga
  Widget _buildLoadingIndicator() {
    return Container(
      color: Colors.black54,
      child: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: Colors.white),
            SizedBox(height: 16),
            Text(
              'Cargando stream...',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  /// Pantalla de error
  Widget _buildErrorScreen() {
    return Container(
      color: Colors.black87,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 64,
              ),
              const SizedBox(height: 16),
              const Text(
                'Error al reproducir stream',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                _errorMessage ?? 'Error desconocido',
                style: const TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: _initializePlayer,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reintentar'),
                  ),
                  ElevatedButton.icon(
                    onPressed: _switchEngine,
                    icon: const Icon(Icons.switch_video),
                    label: const Text('Cambiar motor'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Verificar si el reproductor está reproduciendo
  bool _isPlayerPlaying() {
    final playerState = _playerSelector.getPlayerState();
    return playerState['isPlaying'] ?? false;
  }

  /// Mostrar mensaje en SnackBar
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.blue,
      ),
    );
  }

  /// Mostrar diálogo de error
  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Restaurar orientación al salir
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    
    super.dispose();
  }
}