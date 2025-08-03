import 'package:flutter/material.dart';
import '../../auth/services/xtream_auth_service.dart';
import '../widgets/channel_search_bar.dart';
import '../widgets/category_list.dart';
import '../../video_player/screens/video_player_screen.dart';
import '../../video_player/widgets/mini_video_player.dart';

class LiveChannelsScreen extends StatefulWidget {
  const LiveChannelsScreen({super.key});

  @override
  State<LiveChannelsScreen> createState() => _LiveChannelsScreenState();
}

class _LiveChannelsScreenState extends State<LiveChannelsScreen> {
  final _authService = XtreamAuthService();
  final _searchController = TextEditingController();

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

  @override
  void initState() {
    super.initState();
    _connectAndLoadData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
      appBar: _showMiniPlayer ? null : AppBar(
        title: const Text(
          'Canales en Vivo',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1E88E5),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _isLoading ? null : _refreshData,
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              // TODO: Ir a configuración
            },
          ),
        ],
      ),
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
              'Ahora: Programación en vivo', // TODO: Implementar EPG
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
          icon: const Icon(Icons.favorite_border, color: Colors.white),
          onPressed: () {
            // TODO: Implementar favoritos
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Canal ${channel['name']} agregado a favoritos'),
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 1),
              ),
            );
          },
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
}
