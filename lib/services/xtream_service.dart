import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xtream_code_client/xtream_code_client.dart';
import '../models/service_profile.dart';
import '../models/channel.dart' as app;
import '../models/vod_item.dart';
import '../models/series_item.dart';
import '../models/epg_entry.dart';

/// Servicio para conectividad con APIs Xtream Codes
class XtreamService {
  XtreamCodeClient? _client;
  ServiceProfile? _currentProfile;
  
  static const int _maxRetries = 3;
  static const Duration _retryDelay = Duration(seconds: 2);

  /// Inicializar cliente con perfil de servicio
  Future<void> initialize(ServiceProfile profile) async {
    _currentProfile = profile;
    
    // Extraer puerto del baseUrl si está presente
    final uri = Uri.parse(profile.baseUrl);
    final port = uri.port != 0 ? uri.port.toString() : '8080';
    final baseUrl = '${uri.scheme}://${uri.host}';
    
    // Inicializar la instancia singleton con los parámetros del perfil
    await XtreamCode.initialize(
      url: baseUrl,
      port: port,
      username: profile.username,
      password: profile.password,
    );
    
    // Obtener el cliente inicializado
    _client = XtreamCode.instance.client;
  }

  /// Obtener categorías de canales en vivo con reintentos
  Future<List<Map<String, dynamic>>> fetchLiveCategories() async {
    return await _executeWithRetry(() async {
      if (_currentProfile == null || _client == null) {
        throw Exception('Servicio no inicializado. Llame a initialize() primero.');
      }
      
      try {
        final response = await _client!.liveStreamCategories();
        return response.map((category) => {
          'category_id': category.categoryId,
          'category_name': category.categoryName,
          'parent_id': category.parentId,
        }).toList();
      } catch (e) {
        throw Exception('Error al obtener categorías de canales: $e');
      }
    });
  }

  /// Obtener canales en vivo con reintentos
  Future<List<app.Channel>> fetchLiveStreams({int? categoryId}) async {
    return await _executeWithRetry(() async {
      if (_currentProfile == null || _client == null) {
        throw Exception('Servicio no inicializado. Llame a initialize() primero.');
      }
      
      try {
        XTremeCodeCategory? category;
        if (categoryId != null) {
          // Obtener la categoría por ID
          final categories = await _client!.liveStreamCategories();
          category = categories.cast<XTremeCodeCategory?>().firstWhere(
            (cat) => cat?.categoryId == categoryId,
            orElse: () => null,
          );
        }
        
        final response = await _client!.livestreamItems(category: category);
        return response.map((item) => app.Channel(
          streamId: item.streamId ?? 0,
          name: item.name ?? '',
          streamIcon: item.streamIcon ?? '',
          categoryId: item.categoryId ?? 0,
          streamType: item.streamType ?? 'live',
          hasArchive: (item.tvArchive ?? 0) > 0,
          created: item.added,
          addedOn: item.added,
          cacheExpiry: DateTime.now().add(const Duration(hours: 6)),
        )).toList();
      } catch (e) {
        throw Exception('Error al obtener canales en vivo: $e');
      }
    });
  }

  /// Obtener categorías de VOD con reintentos
  Future<List<Map<String, dynamic>>> fetchVodCategories() async {
    return await _executeWithRetry(() async {
      if (_currentProfile == null || _client == null) {
        throw Exception('Servicio no inicializado. Llame a initialize() primero.');
      }
      
      try {
        final response = await _client!.vodCategories();
        return response.map((category) => {
          'category_id': category.categoryId,
          'category_name': category.categoryName,
          'parent_id': category.parentId,
        }).toList();
      } catch (e) {
        throw Exception('Error al obtener categorías de VOD: $e');
      }
    });
  }

  /// Obtener streams de VOD con reintentos
  Future<List<VodItem>> fetchVodStreams({int? categoryId}) async {
    return await _executeWithRetry(() async {
      if (_currentProfile == null || _client == null) {
        throw Exception('Servicio no inicializado. Llame a initialize() primero.');
      }
      
      try {
        XTremeCodeCategory? category;
        if (categoryId != null) {
          final categories = await _client!.vodCategories();
          category = categories.cast<XTremeCodeCategory?>().firstWhere(
            (cat) => cat?.categoryId == categoryId,
            orElse: () => null,
          );
        }
        
        final response = await _client!.vodItems(category: category);
        return response.map((item) => VodItem(
          streamId: item.streamId ?? 0,
          name: item.name ?? '',
          streamIcon: item.streamIcon ?? '',
          plot: '',
          director: '',
          cast: '',
          genre: '',
          releaseDate: item.added,
          rating: item.rating ?? 0.0,
          categoryId: item.categoryId ?? 0,
          containerExtension: item.containerExtension ?? 'mp4',
          cacheExpiry: DateTime.now().add(const Duration(hours: 6)),
        )).toList();
      } catch (e) {
        throw Exception('Error al obtener streams de VOD: $e');
      }
    });
  }

  /// Obtener categorías de series con reintentos
  Future<List<Map<String, dynamic>>> fetchSeriesCategories() async {
    return await _executeWithRetry(() async {
      if (_currentProfile == null || _client == null) {
        throw Exception('Servicio no inicializado. Llame a initialize() primero.');
      }
      
      try {
        final response = await _client!.seriesCategories();
        return response.map((category) => {
          'category_id': category.categoryId,
          'category_name': category.categoryName,
          'parent_id': category.parentId,
        }).toList();
      } catch (e) {
        throw Exception('Error al obtener categorías de series: $e');
      }
    });
  }

  /// Obtener información de series con reintentos
  Future<List<SeriesItem>> fetchSeries({int? categoryId}) async {
    return await _executeWithRetry(() async {
      if (_currentProfile == null || _client == null) {
        throw Exception('Servicio no inicializado. Llame a initialize() primero.');
      }
      
      try {
        XTremeCodeCategory? category;
        if (categoryId != null) {
          final categories = await _client!.seriesCategories();
          category = categories.cast<XTremeCodeCategory?>().firstWhere(
            (cat) => cat?.categoryId == categoryId,
            orElse: () => null,
          );
        }
        
        final response = await _client!.seriesItems(category: category);
        return response.map((item) => SeriesItem(
          seriesId: item.seriesId ?? 0,
          name: item.name ?? '',
          cover: item.cover ?? '',
          plot: '',
          cast: '',
          director: '',
          genre: '',
          releaseDate: item.releaseDate != null ? DateTime.tryParse(item.releaseDate!) : null,
          rating: item.rating ?? 0.0,
          categoryId: item.categoryId ?? 0,
          episodeRunTime: item.episodeRunTime ?? 0,
          cacheExpiry: DateTime.now().add(const Duration(hours: 6)),
        )).toList();
      } catch (e) {
        throw Exception('Error al obtener información de series: $e');
      }
    });
  }

  /// Obtener EPG corto con reintentos
  Future<List<EpgEntry>> fetchShortEpg(int streamId) async {
    return await _executeWithRetry(() async {
      if (_currentProfile == null || _client == null) {
        throw Exception('Servicio no inicializado. Llame a initialize() primero.');
      }
      
      try {
        final response = await _client!.channelEpgViaStreamId(streamId, 10);
        return (response.epgListings ?? []).map((entry) => EpgEntry(
          channelId: streamId,
          title: entry.title ?? '',
          description: entry.description ?? '',
          startTime: entry.start ?? DateTime.now(),
          endTime: entry.stop ?? DateTime.now().add(const Duration(hours: 1)),
          cacheExpiry: DateTime.now().add(const Duration(hours: 1)),
        )).toList();
      } catch (e) {
        throw Exception('Error al obtener EPG corto: $e');
      }
    });
  }

  /// Obtener información de autenticación
  Future<Map<String, dynamic>> getAccountInfo() async {
    return await _executeWithRetry(() async {
      if (_currentProfile == null || _client == null) {
        throw Exception('Servicio no inicializado. Llame a initialize() primero.');
      }
      
      try {
        final response = await _client!.serverInformation();
        return {
          'username': response.userInfo.username ?? '',
          'status': response.userInfo.status ?? '',
          'exp_date': response.userInfo.expDate?.toIso8601String() ?? '',
          'is_trial': response.userInfo.isTrial ?? false,
          'active_cons': response.userInfo.activeCons ?? 0,
          'max_connections': response.userInfo.maxConnections ?? 0,
        };
      } catch (e) {
        throw Exception('Error al obtener información de cuenta: $e');
      }
    });
  }

  /// Ejecutar operación con reintentos automáticos
  Future<T> _executeWithRetry<T>(Future<T> Function() operation) async {
    Exception? lastException;
    
    for (int attempt = 1; attempt <= _maxRetries; attempt++) {
      try {
        return await operation();
      } on SocketException catch (e) {
        lastException = Exception('Error de conexión: ${e.message}');
        if (attempt == _maxRetries) break;
        await Future.delayed(_retryDelay * attempt);
      } on http.ClientException catch (e) {
        lastException = Exception('Error del cliente HTTP: $e');
        if (attempt == _maxRetries) break;
        await Future.delayed(_retryDelay * attempt);
      } on FormatException catch (e) {
        lastException = Exception('Error de formato de respuesta: $e');
        if (attempt == _maxRetries) break;
        await Future.delayed(_retryDelay * attempt);
      } catch (e) {
        lastException = Exception('Error inesperado: $e');
        if (attempt == _maxRetries) break;
        await Future.delayed(_retryDelay * attempt);
      }
    }
    
    throw lastException ?? Exception('Error desconocido después de $_maxRetries intentos');
  }

  /// Verificar conectividad con el servidor
  Future<bool> testConnection() async {
    try {
      await getAccountInfo();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Limpiar recursos
  void dispose() {
    _currentProfile = null;
  }
}
