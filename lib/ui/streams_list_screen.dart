import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/service_profile.dart';
import '../models/stream_item.dart';
import '../models/channel.dart';
import '../models/vod_item.dart';
import '../models/series_item.dart';
import '../services/xtream_service.dart';
import 'app_router.dart';

/// Pantalla de lista de streams
class StreamsListScreen extends StatefulWidget {
  final ServiceProfile serviceProfile;
  final int categoryId;
  final String categoryName;
  final String streamType;

  const StreamsListScreen({
    super.key,
    required this.serviceProfile,
    required this.categoryId,
    required this.categoryName,
    required this.streamType,
  });

  @override
  State<StreamsListScreen> createState() => _StreamsListScreenState();
}

class _StreamsListScreenState extends State<StreamsListScreen> {
  final XtreamService _xtreamService = XtreamService();
  final TextEditingController _searchController = TextEditingController();
  
  List<StreamItem> _allStreams = [];
  List<StreamItem> _filteredStreams = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeAndLoadStreams();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _xtreamService.dispose();
    super.dispose();
  }

  /// Inicializar servicio y cargar streams
  Future<void> _initializeAndLoadStreams() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      await _xtreamService.initialize(widget.serviceProfile);
      await _loadStreams();

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
    }
  }

  /// Cargar streams según el tipo
  Future<void> _loadStreams() async {
    List<StreamItem> streams = [];

    switch (widget.streamType) {
      case 'live':
        final channels = await _xtreamService.fetchLiveStreams(
          categoryId: widget.categoryId,
        );
        streams = channels.map((channel) => _channelToStreamItem(channel)).toList();
        break;
      case 'vod':
        final vodItems = await _xtreamService.fetchVodStreams(
          categoryId: widget.categoryId,
        );
        streams = vodItems.map((vod) => _vodToStreamItem(vod)).toList();
        break;
      case 'series':
        final seriesItems = await _xtreamService.fetchSeriesInfo(
          categoryId: widget.categoryId,
        );
        streams = seriesItems.map((series) => _seriesToStreamItem(series)).toList();
        break;
    }

    setState(() {
      _allStreams = streams;
      _filteredStreams = streams;
    });
  }

  /// Convertir Channel a StreamItem
  LiveStreamItem _channelToStreamItem(Channel channel) {
    return LiveStreamItem(
      streamId: channel.streamId,
      name: channel.name,
      streamIcon: channel.streamIcon,
      categoryId: channel.categoryId,
      streamType: channel.streamType,
      hasArchive: channel.hasArchive,
    );
  }

  /// Convertir VodItem a StreamItem
  VodStreamItem _vodToStreamItem(VodItem vod) {
    return VodStreamItem(
      streamId: vod.streamId,
      name: vod.name,
      streamIcon: vod.streamIcon,
      categoryId: vod.categoryId,
      containerExtension: vod.containerExtension,
      plot: vod.plot,
    );
  }

  /// Convertir SeriesItem a StreamItem
  SeriesStreamItem _seriesToStreamItem(SeriesItem series) {
    return SeriesStreamItem(
      streamId: series.seriesId,
      name: series.name,
      streamIcon: series.cover,
      categoryId: series.categoryId,
      seriesId: series.seriesId,
      plot: series.plot,
    );
  }

  /// Filtrar streams por búsqueda
  void _filterStreams(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredStreams = _allStreams;
      } else {
        _filteredStreams = _allStreams.where((stream) {
          return stream.name.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: _isLoading ? _buildLoadingScreen() : _buildStreamsList(),
          ),
        ],
      ),
    );
  }

  /// Construir barra de aplicación
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF161B22),
      foregroundColor: Colors.white,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.categoryName,
            style: const TextStyle(fontSize: 16),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '${_filteredStreams.length} elementos',
            style: const TextStyle(fontSize: 12, color: Colors.white70),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: _initializeAndLoadStreams,
          tooltip: 'Actualizar',
        ),
      ],
    );
  }

  /// Barra de búsqueda
  Widget _buildSearchBar() {
    return Container(
      color: const Color(0xFF161B22),
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _searchController,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Buscar contenido...',
          hintStyle: const TextStyle(color: Colors.white54),
          prefixIcon: const Icon(Icons.search, color: Colors.white54),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.white54),
                  onPressed: () {
                    _searchController.clear();
                    _filterStreams('');
                  },
                )
              : null,
          filled: true,
          fillColor: const Color(0xFF21262D),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: _filterStreams,
      ),
    );
  }

  /// Pantalla de carga
  Widget _buildLoadingScreen() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Colors.blue),
          SizedBox(height: 16),
          Text(
            'Cargando contenido...',
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  /// Lista de streams
  Widget _buildStreamsList() {
    if (_errorMessage != null) {
      return _buildErrorScreen();
    }

    if (_filteredStreams.isEmpty) {
      return _buildEmptyState();
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: _filteredStreams.length,
      itemBuilder: (context, index) {
        final stream = _filteredStreams[index];
        return _buildStreamCard(stream);
      },
    );
  }

  /// Tarjeta de stream
  Widget _buildStreamCard(StreamItem stream) {
    return Card(
      color: const Color(0xFF161B22),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => _playStream(stream),
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Imagen del stream
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: _buildStreamImage(stream),
              ),
            ),
            
            // Información del stream
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stream.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    _buildStreamTypeIndicator(stream),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Imagen del stream
  Widget _buildStreamImage(StreamItem stream) {
    if (stream.streamIcon.isEmpty) {
      return Container(
        color: const Color(0xFF21262D),
        child: Icon(
          _getStreamTypeIcon(),
          color: Colors.white54,
          size: 48,
        ),
      );
    }

    return CachedNetworkImage(
      imageUrl: stream.streamIcon,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        color: const Color(0xFF21262D),
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.blue,
            strokeWidth: 2,
          ),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        color: const Color(0xFF21262D),
        child: Icon(
          _getStreamTypeIcon(),
          color: Colors.white54,
          size: 48,
        ),
      ),
    );
  }

  /// Indicador de tipo de stream
  Widget _buildStreamTypeIndicator(StreamItem stream) {
    IconData icon;
    Color color;
    String label;

    if (stream is LiveStreamItem) {
      icon = Icons.live_tv;
      color = Colors.red.shade400;
      label = stream.hasArchive ? 'EN VIVO + ARCHIVO' : 'EN VIVO';
    } else if (stream is VodStreamItem) {
      icon = Icons.movie;
      color = Colors.blue.shade400;
      label = 'PELÍCULA';
    } else if (stream is SeriesStreamItem) {
      icon = Icons.tv;
      color = Colors.green.shade400;
      label = 'SERIE';
    } else {
      icon = Icons.play_circle;
      color = Colors.grey.shade400;
      label = 'CONTENIDO';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 14),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  /// Obtener icono según tipo de stream
  IconData _getStreamTypeIcon() {
    switch (widget.streamType) {
      case 'live':
        return Icons.live_tv;
      case 'vod':
        return Icons.movie;
      case 'series':
        return Icons.tv;
      default:
        return Icons.play_circle;
    }
  }

  /// Estado vacío
  Widget _buildEmptyState() {
    final isSearching = _searchController.text.isNotEmpty;
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isSearching ? Icons.search_off : _getStreamTypeIcon(),
            size: 64,
            color: Colors.white30,
          ),
          const SizedBox(height: 16),
          Text(
            isSearching
                ? 'No se encontraron resultados'
                : 'No hay contenido en esta categoría',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isSearching
                ? 'Intente con otros términos de búsqueda'
                : 'Esta categoría está vacía o no se pudo cargar',
            style: const TextStyle(color: Colors.white70),
            textAlign: TextAlign.center,
          ),
          if (isSearching) ...[
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                _searchController.clear();
                _filterStreams('');
              },
              icon: const Icon(Icons.clear),
              label: const Text('Limpiar búsqueda'),
            ),
          ],
        ],
      ),
    );
  }

  /// Pantalla de error
  Widget _buildErrorScreen() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            const Text(
              'Error al cargar contenido',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _errorMessage!,
              style: const TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _initializeAndLoadStreams,
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade600,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Reproducir stream
  void _playStream(StreamItem stream) {
    AppRouter.navigateToPlayer(
      context,
      profile: widget.serviceProfile,
      streamItem: stream,
    );
  }
}