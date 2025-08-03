import 'dart:collection';
import 'package:isar/isar.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import '../models/channel.dart';
import '../models/vod_item.dart';
import '../models/series_item.dart';
import '../models/epg_entry.dart';

/// Gestor de cache multinivel para la aplicación IPTV
class CacheManager {
  static CacheManager? _instance;
  static Isar? _isar;
  
  // Cache LRU en memoria
  final _memoryCache = LRUMap<String, dynamic>(maximumSize: 1000);
  
  // Gestores de cache especializados
  late final DefaultCacheManager _imageCacheManager;
  late final DefaultCacheManager _videoCacheManager;
  
  CacheManager._internal();
  
  static CacheManager get instance {
    _instance ??= CacheManager._internal();
    return _instance!;
  }

  /// Inicializar gestores de cache
  Future<void> initialize() async {
    await _initializeIsar();
    await _initializeCacheManagers();
  }

  /// Inicializar base de datos Isar para cache persistente
  Future<void> _initializeIsar() async {
    if (_isar != null) return;
    
    final dir = await getApplicationDocumentsDirectory();
    
    _isar = await Isar.open(
      [ChannelSchema, VodItemSchema, SeriesItemSchema, EpgEntrySchema],
      directory: dir.path,
      name: 'cache_db',
    );
  }

  /// Inicializar gestores de cache para imágenes y video
  Future<void> _initializeCacheManagers() async {
    _imageCacheManager = DefaultCacheManager();
    
    _videoCacheManager = DefaultCacheManager();
  }

  /// Obtener instancia de Isar
  Isar get _isarInstance {
    if (_isar == null) {
      throw Exception('CacheManager no inicializado. Llame a initialize() primero.');
    }
    return _isar!;
  }

  // ============ CACHE DE MEMORIA ============

  /// Guardar en cache de memoria
  void putMemory(String key, dynamic value) {
    _memoryCache[key] = value;
  }

  /// Obtener desde cache de memoria
  T? getMemory<T>(String key) {
    return _memoryCache[key] as T?;
  }

  /// Verificar si existe en cache de memoria
  bool hasMemory(String key) {
    return _memoryCache.containsKey(key);
  }

  /// Limpiar cache de memoria
  void clearMemory() {
    _memoryCache.clear();
  }

  // ============ CACHE DE CANALES ============

  /// Guardar canales en cache persistente
  Future<void> putChannels(List<Channel> channels) async {
    try {
      await _isarInstance.writeTxn(() async {
        await _isarInstance.channels.putAll(channels);
      });
      
      // También guardar en memoria
      for (final channel in channels) {
        _memoryCache['channel_${channel.streamId}'] = channel;
      }
    } catch (e) {
      throw Exception('Error al guardar canales en cache: $e');
    }
  }

  /// Obtener canales desde cache
  Future<List<Channel>> getChannels({int? categoryId}) async {
    try {
      // Intentar desde memoria primero
      if (categoryId != null) {
        final memoryKey = 'channels_category_$categoryId';
        final cached = getMemory<List<Channel>>(memoryKey);
        if (cached != null) return cached;
      }
      
      // Buscar en base de datos
      final allChannels = await _isarInstance.channels.where().findAll();
      final now = DateTime.now();
      
      // Filtrar por cache válido y categoría
      final channels = allChannels.where((channel) {
        final isNotExpired = channel.cacheExpiry.isAfter(now);
        final matchesCategory = categoryId == null || channel.categoryId == categoryId;
        return isNotExpired && matchesCategory;
      }).toList();
      
      // Guardar en memoria
      if (categoryId != null) {
        putMemory('channels_category_$categoryId', channels);
      }
      
      return channels;
    } catch (e) {
      throw Exception('Error al obtener canales desde cache: $e');
    }
  }

  /// Obtener canal por ID
  Future<Channel?> getChannel(int streamId) async {
    try {
      // Intentar desde memoria
      final memoryChannel = getMemory<Channel>('channel_$streamId');
      if (memoryChannel != null) return memoryChannel;
      
      // Buscar en base de datos
      final allChannels = await _isarInstance.channels.where().findAll();
      final now = DateTime.now();
      
      final channel = allChannels.where((ch) =>
          ch.streamId == streamId && ch.cacheExpiry.isAfter(now)
      ).firstOrNull;
      
      if (channel != null) {
        putMemory('channel_$streamId', channel);
      }
      
      return channel;
    } catch (e) {
      throw Exception('Error al obtener canal desde cache: $e');
    }
  }

  // ============ CACHE DE VOD ============

  /// Guardar elementos VOD en cache
  Future<void> putVodItems(List<VodItem> items) async {
    try {
      await _isarInstance.writeTxn(() async {
        await _isarInstance.vodItems.putAll(items);
      });
      
      for (final item in items) {
        putMemory('vod_${item.streamId}', item);
      }
    } catch (e) {
      throw Exception('Error al guardar VOD en cache: $e');
    }
  }

  /// Obtener elementos VOD desde cache
  Future<List<VodItem>> getVodItems({int? categoryId}) async {
    try {
      final allItems = await _isarInstance.vodItems.where().findAll();
      final now = DateTime.now();
      
      return allItems.where((item) {
        final isNotExpired = item.cacheExpiry.isAfter(now);
        final matchesCategory = categoryId == null || item.categoryId == categoryId;
        return isNotExpired && matchesCategory;
      }).toList();
    } catch (e) {
      throw Exception('Error al obtener VOD desde cache: $e');
    }
  }

  // ============ CACHE DE SERIES ============

  /// Guardar series en cache
  Future<void> putSeriesItems(List<SeriesItem> items) async {
    try {
      await _isarInstance.writeTxn(() async {
        await _isarInstance.seriesItems.putAll(items);
      });
      
      for (final item in items) {
        putMemory('series_${item.seriesId}', item);
      }
    } catch (e) {
      throw Exception('Error al guardar series en cache: $e');
    }
  }

  /// Obtener series desde cache
  Future<List<SeriesItem>> getSeriesItems({int? categoryId}) async {
    try {
      final allItems = await _isarInstance.seriesItems.where().findAll();
      final now = DateTime.now();
      
      return allItems.where((item) {
        final isNotExpired = item.cacheExpiry.isAfter(now);
        final matchesCategory = categoryId == null || item.categoryId == categoryId;
        return isNotExpired && matchesCategory;
      }).toList();
    } catch (e) {
      throw Exception('Error al obtener series desde cache: $e');
    }
  }

  // ============ CACHE DE EPG ============

  /// Guardar entradas EPG en cache
  Future<void> putEpgEntries(List<EpgEntry> entries) async {
    try {
      await _isarInstance.writeTxn(() async {
        await _isarInstance.epgEntrys.putAll(entries);
      });
    } catch (e) {
      throw Exception('Error al guardar EPG en cache: $e');
    }
  }

  /// Obtener entradas EPG desde cache
  Future<List<EpgEntry>> getEpgEntries(int channelId) async {
    try {
      final allEntries = await _isarInstance.epgEntrys.where().findAll();
      final now = DateTime.now();
      
      return allEntries.where((entry) {
        final isNotExpired = entry.cacheExpiry.isAfter(now);
        final matchesChannel = entry.channelId == channelId;
        return isNotExpired && matchesChannel;
      }).toList()..sort((a, b) => a.startTime.compareTo(b.startTime));
    } catch (e) {
      throw Exception('Error al obtener EPG desde cache: $e');
    }
  }

  // ============ CACHE DE IMÁGENES ============

  /// Obtener imagen desde cache
  Future<FileInfo?> getCachedImage(String url) async {
    try {
      return await _imageCacheManager.getFileFromCache(url);
    } catch (e) {
      return null;
    }
  }

  /// Descargar y cachear imagen
  Future<FileInfo> downloadAndCacheImage(String url) async {
    try {
      return await _imageCacheManager.downloadFile(url);
    } catch (e) {
      throw Exception('Error al descargar imagen: $e');
    }
  }

  // ============ CACHE DE VIDEO ============

  /// Obtener video desde cache
  Future<FileInfo?> getCachedVideo(String url) async {
    try {
      return await _videoCacheManager.getFileFromCache(url);
    } catch (e) {
      return null;
    }
  }

  /// Pre-cachear segmento de video
  Future<void> precacheVideoSegment(String url) async {
    try {
      await _videoCacheManager.downloadFile(url);
    } catch (e) {
      // Ignorar errores de pre-cache
    }
  }

  // ============ MANTENIMIENTO ============

  /// Limpiar cache expirado
  Future<void> purgeExpiredCache() async {
    try {
      final now = DateTime.now();
      
      await _isarInstance.writeTxn(() async {
        // Obtener todos los elementos y filtrar los expirados
        final expiredChannels = await _isarInstance.channels.where().findAll();
        final expiredChannelIds = expiredChannels
            .where((ch) => ch.cacheExpiry.isBefore(now))
            .map((ch) => ch.id)
            .toList();
        
        final expiredVodItems = await _isarInstance.vodItems.where().findAll();
        final expiredVodIds = expiredVodItems
            .where((item) => item.cacheExpiry.isBefore(now))
            .map((item) => item.id)
            .toList();
        
        final expiredSeriesItems = await _isarInstance.seriesItems.where().findAll();
        final expiredSeriesIds = expiredSeriesItems
            .where((item) => item.cacheExpiry.isBefore(now))
            .map((item) => item.id)
            .toList();
        
        final expiredEpgEntries = await _isarInstance.epgEntrys.where().findAll();
        final expiredEpgIds = expiredEpgEntries
            .where((entry) => entry.cacheExpiry.isBefore(now))
            .map((entry) => entry.id)
            .toList();
        
        // Eliminar elementos expirados
        await _isarInstance.channels.deleteAll(expiredChannelIds);
        await _isarInstance.vodItems.deleteAll(expiredVodIds);
        await _isarInstance.seriesItems.deleteAll(expiredSeriesIds);
        await _isarInstance.epgEntrys.deleteAll(expiredEpgIds);
      });
      
      // Limpiar cache de imágenes
      await _imageCacheManager.emptyCache();
      
      // Limpiar cache de video
      await _videoCacheManager.emptyCache();
      
    } catch (e) {
      throw Exception('Error al limpiar cache expirado: $e');
    }
  }

  /// Obtener estadísticas de cache
  Future<Map<String, int>> getCacheStats() async {
    try {
      final stats = <String, int>{};
      
      stats['memory_items'] = _memoryCache.length;
      stats['channels'] = await _isarInstance.channels.count();
      stats['vod_items'] = await _isarInstance.vodItems.count();
      stats['series_items'] = await _isarInstance.seriesItems.count();
      stats['epg_entries'] = await _isarInstance.epgEntrys.count();
      
      return stats;
    } catch (e) {
      throw Exception('Error al obtener estadísticas de cache: $e');
    }
  }

  /// Limpiar todo el cache
  Future<void> clearAll() async {
    try {
      clearMemory();
      
      await _isarInstance.writeTxn(() async {
        await _isarInstance.clear();
      });
      
      await _imageCacheManager.emptyCache();
      await _videoCacheManager.emptyCache();
    } catch (e) {
      throw Exception('Error al limpiar todo el cache: $e');
    }
  }

  /// Cerrar gestores de cache
  static Future<void> close() async {
    await _isar?.close();
    _isar = null;
    _instance = null;
  }
}

/// Implementación de LRU Map
class LRUMap<K, V> {
  final int maximumSize;
  final LinkedHashMap<K, V> _map = LinkedHashMap<K, V>();

  LRUMap({required this.maximumSize});

  V? operator [](Object? key) {
    final value = _map.remove(key);
    if (value != null && key != null) {
      _map[key as K] = value; // Move to end for LRU
    }
    return value;
  }

  void operator []=(K key, V value) {
    _map.remove(key);
    _map[key] = value;
    
    // Remove oldest entries if exceeding maximum size
    while (_map.length > maximumSize) {
      _map.remove(_map.keys.first);
    }
  }

  bool containsKey(Object? key) => _map.containsKey(key);
  
  V? remove(Object? key) => _map.remove(key);
  
  void clear() => _map.clear();
  
  int get length => _map.length;
  
  bool get isEmpty => _map.isEmpty;
  
  bool get isNotEmpty => _map.isNotEmpty;
}