import 'package:flutter/material.dart';

class ChannelHeaderImage extends StatelessWidget {
  final Map<String, dynamic>? selectedChannel;
  final VoidCallback? onPlayPressed;

  const ChannelHeaderImage({
    super.key,
    this.selectedChannel,
    this.onPlayPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedChannel == null) {
      return Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey[900]!,
              Colors.black,
            ],
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.tv,
                size: 64,
                color: Colors.grey,
              ),
              SizedBox(height: 8),
              Text(
                'Selecciona un canal',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.grey[900]!,
            Colors.black,
          ],
        ),
      ),
      child: Stack(
        children: [
          // Imagen de fondo del canal
          Positioned.fill(
            child: selectedChannel!['stream_icon'] != null
                ? Image.network(
                    selectedChannel!['stream_icon'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[800],
                      child: const Icon(
                        Icons.tv,
                        size: 64,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : Container(
                    color: Colors.grey[800],
                    child: const Icon(
                      Icons.tv,
                      size: 64,
                      color: Colors.grey,
                    ),
                  ),
          ),

          // Overlay con gradiente
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
          ),

          // Información del canal
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Logo del canal
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black54,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: selectedChannel!['stream_icon'] != null
                          ? Image.network(
                              selectedChannel!['stream_icon'],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => const Icon(
                                Icons.tv,
                                color: Colors.white,
                                size: 24,
                              ),
                            )
                          : const Icon(
                              Icons.tv,
                              color: Colors.white,
                              size: 24,
                            ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Información del canal
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          selectedChannel!['name'] ?? 'Canal sin nombre',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Ahora: Programación en vivo',
                          style: TextStyle(
                            color: Colors.grey[300],
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
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

                  // Botón de reproducir
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF1E88E5),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: onPlayPressed,
                      icon: const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
