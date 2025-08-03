import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

class MiniVideoPlayer extends StatefulWidget {
  final String streamUrl;
  final Map<String, dynamic> channel;
  final VoidCallback onClose;
  final VoidCallback onExpand;

  const MiniVideoPlayer({
    super.key,
    required this.streamUrl,
    required this.channel,
    required this.onClose,
    required this.onExpand,
  });

  @override
  State<MiniVideoPlayer> createState() => _MiniVideoPlayerState();
}

class _MiniVideoPlayerState extends State<MiniVideoPlayer> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;
  bool _hasError = false;
  bool _showControls = true;
  Timer? _hideControlsTimer;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
    _startHideControlsTimer();
  }
  
  @override
  void didUpdateWidget(covariant MiniVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Si cambia la URL de stream, reinicializar el reproductor
    if (widget.streamUrl != oldWidget.streamUrl) {
      _hideControlsTimer?.cancel();
      _controller?.pause();
      _controller?.dispose();
      setState(() {
        _isInitialized = false;
        _hasError = false;
        _showControls = true;
      });
      _initializePlayer();
      _startHideControlsTimer();
    }
  }

  void _initializePlayer() {
    try {
      _controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.streamUrl),
      );

      _controller!.initialize().then((_) {
        if (mounted) {
          setState(() {
            _isInitialized = true;
          });
          _controller!.play();
        }
      }).catchError((error) {
        print('Error inicializando mini reproductor: $error');
        if (mounted) {
          setState(() {
            _hasError = true;
          });
        }
      });
    } catch (e) {
      print('Error creando controlador: $e');
      setState(() {
        _hasError = true;
      });
    }
  }

  void _startHideControlsTimer() {
    _hideControlsTimer?.cancel();
    _hideControlsTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showControls = false;
        });
      }
    });
  }

  void _showControlsTemporarily() {
    setState(() {
      _showControls = true;
    });
    _startHideControlsTimer();
  }

  @override
  void dispose() {
    _hideControlsTimer?.cancel();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Calcula la altura manteniendo relación 16:9
    final screenWidth = MediaQuery.of(context).size.width;
    final playerHeight = screenWidth * (9 / 16);
    
    return SafeArea(
      top: true,
      bottom: true,
      child: GestureDetector(
        onTap: _showControlsTemporarily,
        child: Container(
          height: playerHeight,
          width: double.infinity,
          color: Colors.black,
          child: Stack(
            children: [
              // Video player
              if (_isInitialized && _controller != null)
                Positioned.fill(
                  child: FittedBox(
                    fit: BoxFit.contain, // Cambiado de cover a contain para mantener proporción
                    child: SizedBox(
                      width: _controller!.value.size.width,
                      height: _controller!.value.size.height,
                      child: VideoPlayer(_controller!),
                    ),
                  ),
                )
              else if (_hasError)
                const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 48,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Error al cargar el stream',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                )
              else
                const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF1E88E5),
                  ),
                ),

              // Overlay con controles
              if (_showControls)
                Positioned.fill(
                  child: AnimatedOpacity(
                    opacity: _showControls ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.5),
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

              // Información del canal (parte superior izquierda)
              if (_showControls)
                Positioned(
                  top: 8,
                  left: 8,
                  right: 80, // Deja espacio para los botones de control
                  child: AnimatedOpacity(
                    opacity: _showControls ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Row(
                      children: [
                        // Logo del canal
                        if (widget.channel['stream_icon'] != null)
                          Container(
                            width: 32,
                            height: 32,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.grey[800],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.network(
                                widget.channel['stream_icon'],
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.tv, color: Colors.white, size: 16),
                              ),
                            ),
                          ),

                        // Información del canal
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                widget.channel['name'] ?? 'Canal desconocido',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black,
                                      offset: Offset(1, 1),
                                      blurRadius: 2,
                                    ),
                                  ],
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 1,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: const Text(
                                  'EN VIVO',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // Botones de control (parte superior derecha)
              if (_showControls)
                Positioned(
                  top: 8,
                  right: 8,
                  child: AnimatedOpacity(
                    opacity: _showControls ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Botón expandir a pantalla completa
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: IconButton(
                            onPressed: widget.onExpand,
                            icon: const Icon(
                              Icons.fullscreen,
                              color: Colors.white,
                              size: 18,
                            ),
                            padding: EdgeInsets.zero,
                          ),
                        ),
                        const SizedBox(width: 4),
                        // Botón cerrar
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: IconButton(
                            onPressed: widget.onClose,
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 18,
                            ),
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),          // Controles de reproducción (centro)
          if (_showControls)
            Positioned.fill(
              child: AnimatedOpacity(
                opacity: _showControls ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_isInitialized && _controller != null)
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                if (_controller!.value.isPlaying) {
                                  _controller!.pause();
                                } else {
                                  _controller!.play();
                                }
                              });
                              _showControlsTemporarily();
                            },
                            icon: Icon(
                              _controller!.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: Colors.white,
                              size: 32,
                            ),
                            padding: EdgeInsets.zero,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),

          // Indicador de volumen (parte inferior derecha)
          if (_isInitialized && _controller != null && _showControls)
            Positioned(
              bottom: 8,
              right: 8,
              child: AnimatedOpacity(
                opacity: _showControls ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _controller!.value.volume > 0
                            ? Icons.volume_up
                            : Icons.volume_off,
                        color: Colors.white,
                        size: 14,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '${(_controller!.value.volume * 100).round()}%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      ),  // Cierra GestureDetector
    );
  }
}
