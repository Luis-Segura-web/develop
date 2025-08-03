import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPlayerScreen extends StatefulWidget {
  final Map<String, dynamic> channel;
  final String streamUrl;

  const VideoPlayerScreen({
    super.key,
    required this.channel,
    required this.streamUrl,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _isFullscreen = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  void _initializePlayer() {
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.streamUrl),
    );

    _videoPlayerController.initialize().then((_) {
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        looping: false,
        allowFullScreen: true,
        allowMuting: true,
        showControls: true,
        materialProgressColors: ChewieProgressColors(
          playedColor: const Color(0xFF1E88E5),
          handleColor: const Color(0xFF1E88E5),
          backgroundColor: Colors.grey,
          bufferedColor: Colors.lightBlue,
        ),
        autoInitialize: true,
      );

      setState(() {});

      // Configurar para pantalla completa automáticamente
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _enterFullscreen();
      });
    }).catchError((error) {
      print('Error inicializando reproductor: $error');
    });
  }

  void _enterFullscreen() {
    setState(() {
      _isFullscreen = true;
    });

    // Ocultar barra de estado y botones de navegación
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
    );

    // Orientación horizontal
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  void _exitFullscreen() {
    setState(() {
      _isFullscreen = false;
    });

    // Restaurar barra de estado y botones
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
    );

    // Orientación vertical
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    // Volver a la pantalla anterior
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    
    // Restaurar configuración del sistema al salir
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        if (!didPop) {
          _exitFullscreen();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            // Reproductor de video
            Center(
              child: _chewieController != null
                  ? Chewie(controller: _chewieController!)
                  : const CircularProgressIndicator(
                      color: Color(0xFF1E88E5),
                    ),
            ),

            // Información del canal en la esquina superior
            if (_isFullscreen)
              Positioned(
                top: 40,
                left: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo del canal (si existe)
                      if (widget.channel['stream_icon'] != null) ...[
                        Image.network(
                          widget.channel['stream_icon'],
                          width: 32,
                          height: 32,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                            Icons.tv,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                      
                      // Nombre del canal
                      Text(
                        widget.channel['name'] ?? 'Canal desconocido',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                      const SizedBox(width: 8),
                      
                      // Indicador EN VIVO
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'EN VIVO',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // Botón de salida
            if (_isFullscreen)
              Positioned(
                top: 40,
                right: 16,
                child: IconButton(
                  onPressed: _exitFullscreen,
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 32,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.black.withOpacity(0.7),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
