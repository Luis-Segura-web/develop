import 'package:flutter/material.dart';
import '../../auth/services/xtream_auth_service.dart';
import '../widgets/channel_search_bar.dart';
import '../widgets/category_list.dart';
import '../../video_player/screens/video_player_screen.dart';
import '../../video_player/widgets/mini_video_player.dart';
import '../../../services/favorites_service.dart';

class LiveChannelsScreen extends StatefulWidget {
  const LiveChannelsScreen({super.key});

  @override
  State<LiveChannelsScreen> createState() => _LiveChannelsScreenState();
}

class _LiveChannelsScreenState extends State<LiveChannelsScreen> {
  final _authService = XtreamAuthService();
  final _searchController = TextEditingController();
  final _favoritesService = FavoritesService.instance;

  // Estados
  bool _isLoading = false;
  bool _isConnected = false;
  String? _errorMessage;
  bool _showMiniPlayer = false;

  // Datos
  List<Map<String, dynamic>> _categories = [];
  final Map<String, List<Map<String, dynamic>>> _channelsByCategory = {};
  Map<String, dynamic>? _selectedChannel;
  String? _expandedCategoryId;
  List<Map<String, dynamic>> _filteredChannels = [];
  final Set<String> _favoriteChannels = <String>{};
  final Map<String, String> _epgData = <String, String>{};

  @override
  void initState() {
    super.initState();
    _loadFavorites(); // Cargar favoritos al inicializar
    // NO conectar automáticamente - usar la conexión existente
    _loadChannelsFromExistingConnection();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadChannelsFromExistingConnection() async {
    // Verificar si ya hay una conexión activa desde el login
    if (_authService.isConnected) {
      setState(() {
        _isConnected = true;
      });
      await _loadCategories();
    } else {
      // Si no hay conexión, mostrar mensaje para conectar
      setState(() {
        _errorMessage = 'Debe iniciar sesión primero para ver los canales';
      });
    }
  }

  Future<void> _connectAndLoadData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Conectar con datos demo
      final success = await _authService.connect(
        url: 'http://gzytv.vip',
        port: '8880',
        username: 'DMWyCAxket',
        password: 'kfvRWYajJJ',
      );

      if (success) {
        setState(() {
          _isConnected = true;
        });

        // Cargar categorías
        await _loadCategories();
      } else {
        setState(() {
          _errorMessage = 'No se pudo conectar al servidor IPTV';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error de conexión: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadCategories() async {
    try {
      final categories = await _authService.getLiveCategories();
      
      setState(() {
        _categories = categories.cast<Map<String, dynamic>>();
      });

      // Cargar canales para cada categoría
      for (final category in _categories) {
        final categoryId = category['category_id']?.toString();
        if (categoryId != null) {
          final channels = await _authService.getLiveStreams(categoryId: categoryId);
          _channelsByCategory[categoryId] = channels.cast<Map<String, dynamic>>();
        }
      }

      // Seleccionar primer canal por defecto
      if (_channelsByCategory.isNotEmpty) {
        final firstCategoryChannels = _channelsByCategory.values.first;
        if (firstCategoryChannels.isNotEmpty) {
          setState(() {
            _selectedChannel = firstCategoryChannels.first;
          });
        }
      }

      setState(() {});
    } catch (e) {
      setState(() {
        _errorMessage = 'Error cargando categorías: $e';
      });
    }
  }

  void _onChannelSelected(Map<String, dynamic> channel) {
    setState(() {
      _selectedChannel = channel;
      _showMiniPlayer = true;
    });
  }

  void _onCategoryExpanded(String? categoryId) {
    setState(() {
      _expandedCategoryId = _expandedCategoryId == categoryId ? null : categoryId;
    });
  }

  void _onSearchChanged(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredChannels = [];
      });
      return;
    }

    final filtered = <Map<String, dynamic>>[];
    for (final channels in _channelsByCategory.values) {
      for (final channel in channels) {
        final name = channel['name']?.toString().toLowerCase() ?? '';
        if (name.contains(query.toLowerCase())) {
          filtered.add(channel);
        }
      }
    }

    setState(() {
      _filteredChannels = filtered;
    });
  }

  Future<void> _refreshData() async {
    await _connectAndLoadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // Eliminar AppBar porque ya lo tiene TabHomeScreen
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Color(0xFF1E88E5)),
            SizedBox(height: 16),
            Text(
              'Cargando canales...',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              _errorMessage!,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _refreshData,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E88E5),
                foregroundColor: Colors.white,
              ),
              child: const Text('Reintentar'),
            ),
          ],
        ),
      );
    }

    if (!_isConnected || _categories.isEmpty) {
      return const Center(
        child: Text(
          'No hay canales disponibles',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      );
    }

    return Column(
      children: [
        // Mini reproductor de video (cuando hay canal seleccionado)
        if (_showMiniPlayer && _selectedChannel != null)
          MiniVideoPlayer(
            channel: _selectedChannel!,
            streamUrl: _authService.getStreamUrl(_selectedChannel!['stream_id']?.toString() ?? ''),
            onClose: () {
              setState(() {
                _showMiniPlayer = false;
                _selectedChannel = null;
              });
            },
            onExpand: () {
              _playChannelFullscreen(_selectedChannel!);
            },
          ),

        // Buscador de canales
        ChannelSearchBar(
          controller: _searchController,
          onSearchChanged: _onSearchChanged,
        ),

        // Lista de categorías o resultados de búsqueda
        Expanded(
          child: _filteredChannels.isNotEmpty
              ? _buildSearchResults()
              : CategoryList(
                  categories: _categories,
                  channelsByCategory: _channelsByCategory,
                  expandedCategoryId: _expandedCategoryId,
                  selectedChannel: _selectedChannel,
                  onCategoryExpanded: _onCategoryExpanded,
                  onChannelSelected: _onChannelSelected,
                ),
        ),
      ],
    );
  }

  Widget _buildSearchResults() {
    return Container(
      color: Colors.grey[900],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Resultados de búsqueda (${_filteredChannels.length})',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredChannels.length,
              itemBuilder: (context, index) {
                final channel = _filteredChannels[index];
                return _buildChannelTile(channel);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChannelTile(Map<String, dynamic> channel) {
    final isSelected = _selectedChannel?['stream_id'] == channel['stream_id'];
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF1E88E5).withOpacity(0.3) : Colors.grey[850],
        borderRadius: BorderRadius.circular(8),
        border: isSelected ? Border.all(color: const Color(0xFF1E88E5), width: 2) : null,
      ),
      child: ListTile(
        leading: Container(
          width: 60,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.grey[700],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(
              channel['stream_icon'] ?? '',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.tv,
                color: Colors.white,
              ),
            ),
          ),
        ),
        title: Text(
          channel['name'] ?? 'Canal sin nombre',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              _getEpgInfo(channel), // Implementar EPG
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 12,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.8),
                borderRadius: BorderRadius.circular(4),
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
        trailing: IconButton(
          icon: Icon(
            _favoriteChannels.contains(channel['stream_id']?.toString())
                ? Icons.favorite
                : Icons.favorite_border,
            color: _favoriteChannels.contains(channel['stream_id']?.toString())
                ? Colors.red
                : Colors.white,
          ),
          onPressed: () => _toggleChannelFavorite(channel),
        ),
        onTap: () => _onChannelSelected(channel),
      ),
    );
  }

  void _playChannelFullscreen(Map<String, dynamic> channel) {
    final streamId = channel['stream_id']?.toString();
    if (streamId != null) {
      final streamUrl = _authService.getStreamUrl(streamId);
      
      // Navegar al reproductor de video en pantalla completa
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoPlayerScreen(
            channel: channel,
            streamUrl: streamUrl,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error: No se pudo obtener la URL del canal'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  /// Obtener información de EPG para un canal
  String _getEpgInfo(Map<String, dynamic> channel) {
    final streamId = channel['stream_id']?.toString() ?? '';
    final epgChannelId = channel['epg_channel_id']?.toString();
    
    // Simulación de datos EPG - en implementación real vendría del servidor
    if (epgChannelId != null && _epgData.containsKey(epgChannelId)) {
      return _epgData[epgChannelId]!;
    }
    
    // Generar información EPG simulada basada en la hora actual
    final now = DateTime.now();
    final hour = now.hour;
    
    if (hour >= 6 && hour < 12) {
      return 'Ahora: Programación Matutina';
    } else if (hour >= 12 && hour < 18) {
      return 'Ahora: Programación Vespertina';
    } else if (hour >= 18 && hour < 22) {
      return 'Ahora: Programación Prime Time';
    } else {
      return 'Ahora: Programación Nocturna';
    }
  }

  /// Alternar favorito de canal
  Future<void> _toggleChannelFavorite(Map<String, dynamic> channel) async {
    try {
      final streamId = channel['stream_id']?.toString() ?? '';
      final channelName = channel['name'] ?? 'Canal sin nombre';
      
      if (streamId.isEmpty) {
        _showMessage('Error: ID de canal inválido', isError: true);
        return;
      }

      final wasToggled = await _favoritesService.toggleFavorite(channel);
      
      if (wasToggled) {
        await _loadFavorites(); // Recargar favoritos
        
        final isFavorite = _favoriteChannels.contains(streamId);
        _showMessage(
          isFavorite 
              ? 'Canal "$channelName" agregado a favoritos'
              : 'Canal "$channelName" removido de favoritos',
        );
      } else {
        _showMessage('Error al actualizar favoritos', isError: true);
      }
    } catch (e) {
      _showMessage('Error: ${e.toString()}', isError: true);
    }
  }

  /// Cargar favoritos del almacenamiento
  Future<void> _loadFavorites() async {
    try {
      final favorites = await _favoritesService.getFavorites();
      if (mounted) {
        setState(() {
          _favoriteChannels.clear();
          _favoriteChannels.addAll(favorites);
        });
      }
    } catch (e) {
      print('Error al cargar favoritos: $e');
    }
  }

  /// Mostrar gestión de favoritos
  void _showFavoritesManagement() async {
    try {
      final favoriteChannels = await _favoritesService.getFavoriteChannels();
      final stats = await _favoritesService.getFavoritesStats();
      
      if (!mounted) return;
      
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Gestión de Favoritos'),
            content: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Total de favoritos: ${stats['total_favorites']}'),
                  const SizedBox(height: 16),
                  if (favoriteChannels.isEmpty)
                    const Text('No hay canales favoritos')
                  else
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        itemCount: favoriteChannels.length,
                        itemBuilder: (context, index) {
                          final channel = favoriteChannels[index];
                          return ListTile(
                            dense: true,
                            title: Text(channel['name'] ?? 'Sin nombre'),
                            subtitle: Text('ID: ${channel['stream_id']}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                final removed = await _favoritesService.removeFromFavorites(
                                  channel['stream_id']?.toString() ?? '',
                                );
                                if (removed) {
                                  Navigator.of(context).pop();
                                  _showMessage('Canal removido de favoritos');
                                  _loadFavorites();
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
            actions: [
              if (favoriteChannels.isNotEmpty)
                TextButton(
                  onPressed: () async {
                    await _favoritesService.clearFavorites();
                    Navigator.of(context).pop();
                    _showMessage('Todos los favoritos han sido eliminados');
                    _loadFavorites();
                  },
                  child: const Text('Limpiar Todo', style: TextStyle(color: Colors.red)),
                ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cerrar'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      _showMessage('Error al cargar favoritos: ${e.toString()}', isError: true);
    }
  }

  /// Mostrar mensaje al usuario
  void _showMessage(String message, {bool isError = false}) {
    if (!mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
