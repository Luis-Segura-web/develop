import '../services/xtream_service.dart';
import '../storage/cache_manager.dart';
import '../models/service_profile.dart';
import '../models/channel.dart' as app;
import '../models/vod_item.dart';
import '../models/series_item.dart';
import '../models/epg_entry.dart';

/// Repositorio que coordina la carga y caché de contenido desde APIs Xtream Codes
class ContentRepository {
  static ContentRepository? _instance;
  static ContentRepository get instance {
    _instance ??= ContentRepository._internal();
    return _instance!;
  }
  
  ContentRepository._internal();

  final XtreamService _xtreamService = XtreamService();
  final CacheManager _cacheManager = CacheManager.instance;

  /// Inicializar repositorio con perfil activo
  Future<void> initialize(ServiceProfile profile) async {
    await _xtreamService.initialize(profile);
    await _cacheManager.initialize();
  }

  /// Cargar todo el contenido inicial después del login
  Future<void> loadInitialContent() async {
    try {
      // Cargar en paralelo para mejor rendimiento
      await Future.wait([
        _loadChannelsContent(),
        _loadVodContent(),
        _loadSeriesContent(),
      ]);
    } catch (e) {
      throw Exception('Error al cargar contenido inicial: $e');
    }
  }

  /// Cargar contenido de canales y categorías
  Future<void> _loadChannelsContent() async {
    try {
      // Obtener categorías de canales
      final categories = await _xtreamService.fetchLiveCategories();
      
      // Guardar categorías en cache de memoria
      _cacheManager.putMemory('live_categories', categories);
      
      // Obtener todos los canales (sin filtro de categoría para carga inicial)
      final channels = await _xtreamService.fetchLiveStreams();
      
      // Guardar en cache persistente
      await _cacheManager.putChannels(channels);

      // Cargar EPG para los primeros 50 canales (para no sobrecargar)
      final priorityChannels = channels.take(50).toList();
      await _loadEpgForChannels(priorityChannels);
      
    } catch (e) {
      throw Exception('Error al cargar canales: $e');
    }
  }

  /// Cargar contenido VOD
  Future<void> _loadVodContent() async {
    try {
      // Obtener categorías VOD
      final categories = await _xtreamService.fetchVodCategories();
      _cacheManager.putMemory('vod_categories', categories);
      
      // Obtener películas de todas las categorías
      final vodItems = await _xtreamService.fetchVodStreams();
      
      // Actualizar timestamps de cache
      final now = DateTime.now();
      final cachedItems = vodItems.map((item) {
        return item.copyWith(
          cacheExpiry: now.add(const Duration(hours: 12)), // Cache por 12 horas
        );
      }).toList();
      
      // Guardar en cache
      await _cacheManager.putVodItems(cachedItems);
      
    } catch (e) {
      throw Exception('Error al cargar VOD: $e');
    }
  }

  /// Cargar contenido de series
  Future<void> _loadSeriesContent() async {
    try {
      // Obtener categorías de series
      final categories = await _xtreamService.fetchSeriesCategories();
      _cacheManager.putMemory('series_categories', categories);
      
      // Obtener series
      final seriesItems = await _xtreamService.fetchSeries();
      
      // Actualizar timestamps de cache
      final now = DateTime.now();
      final cachedItems = seriesItems.map((item) {
        return item.copyWith(
          cacheExpiry: now.add(const Duration(hours: 12)), // Cache por 12 horas
        );
      }).toList();
      
      // Guardar en cache
      await _cacheManager.putSeriesItems(cachedItems);
      
    } catch (e) {
      throw Exception('Error al cargar series: $e');
    }
  }

  /// Cargar EPG para una lista de canales
  Future<void> _loadEpgForChannels(List<app.Channel> channels) async {
    final List<EpgEntry> allEpgEntries = [];
    
    // Cargar EPG en lotes para evitar sobrecarga
    for (int i = 0; i < channels.length; i += 10) {
      final batch = channels.skip(i).take(10);
      
      try {
        final epgFutures = batch.map((channel) async {
          try {
            final epgEntries = await _xtreamService.fetchShortEpg(channel.streamId);
            return epgEntries.map((entry) {
              return entry.copyWith(
                channelId: channel.streamId,
                cacheExpiry: DateTime.now().add(const Duration(hours: 2)),
              );
            }).toList();
          } catch (e) {
            // Ignorar errores de EPG individuales
            return <EpgEntry>[];
          }
        });
        
        final batchResults = await Future.wait(epgFutures);
        
        for (final entries in batchResults) {
          allEpgEntries.addAll(entries);
        }
        
        // Pequeña pausa entre lotes
        await Future.delayed(const Duration(milliseconds: 500));
      } catch (e) {
        // Continuar con el siguiente lote si falla
        continue;
      }
    }
    
    // Guardar todo el EPG cargado
    if (allEpgEntries.isNotEmpty) {
      await _cacheManager.putEpgEntries(allEpgEntries);
    }
  }

  // ============ MÉTODOS DE ACCESO A DATOS ============

  /// Obtener canales desde cache
  Future<List<app.Channel>> getChannels({int? categoryId}) async {
    try {
      return await _cacheManager.getChannels(categoryId: categoryId);
    } catch (e) {
      // Si falla el cache, intentar cargar desde API
      return await _xtreamService.fetchLiveStreams(categoryId: categoryId);
    }
  }

  /// Obtener categorías de canales
  List<Map<String, dynamic>> getLiveCategories() {
    return _cacheManager.getMemory<List<Map<String, dynamic>>>('live_categories') ?? [];
  }

  /// Obtener elementos VOD desde cache
  Future<List<VodItem>> getVodItems({int? categoryId}) async {
    try {
      return await _cacheManager.getVodItems(categoryId: categoryId);
    } catch (e) {
      return await _xtreamService.fetchVodStreams(categoryId: categoryId);
    }
  }

  /// Obtener categorías VOD
  List<Map<String, dynamic>> getVodCategories() {
    return _cacheManager.getMemory<List<Map<String, dynamic>>>('vod_categories') ?? [];
  }

  /// Obtener series desde cache
  Future<List<SeriesItem>> getSeriesItems({int? categoryId}) async {
    try {
      return await _cacheManager.getSeriesItems(categoryId: categoryId);
    } catch (e) {
      return await _xtreamService.fetchSeries(categoryId: categoryId);
    }
  }

  /// Obtener categorías de series
  List<Map<String, dynamic>> getSeriesCategories() {
    return _cacheManager.getMemory<List<Map<String, dynamic>>>('series_categories') ?? [];
  }

  /// Obtener EPG para un canal
  Future<List<EpgEntry>> getEpgForChannel(int channelId) async {
    try {
      return await _cacheManager.getEpgEntries(channelId);
    } catch (e) {
      return await _xtreamService.fetchShortEpg(channelId);
    }
  }

  /// Obtener canal por ID
  Future<app.Channel?> getChannel(int streamId) async {
    return await _cacheManager.getChannel(streamId);
  }

  /// Refrescar contenido específico
  Future<void> refreshChannels() async {
    await _loadChannelsContent();
  }

  Future<void> refreshVod() async {
    await _loadVodContent();
  }

  Future<void> refreshSeries() async {
    await _loadSeriesContent();
  }

  /// Limpiar todo el cache
  Future<void> clearCache() async {
    await _cacheManager.clearAll();
  }

  /// Obtener estadísticas del cache
  Future<Map<String, int>> getCacheStats() async {
    return await _cacheManager.getCacheStats();
  }

  /// Cerrar repositorio
  void dispose() {
    _xtreamService.dispose();
  }
}