import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xtream_code_client/xtream_code_client.dart';
import '../models/service_profile.dart';
import '../models/channel.dart';
import '../models/vod_item.dart';
import '../models/series_item.dart';
import '../models/epg_entry.dart';

/// Servicio para conectividad con APIs Xtream Codes
class XtreamService {
  late XtreamCodeClient _client;
  ServiceProfile? _currentProfile;
  
  static const int _maxRetries = 3;
  static const Duration _retryDelay = Duration(seconds: 2);

  /// Inicializar cliente con perfil de servicio
  Future<void> initialize(ServiceProfile profile) async {
    _currentProfile = profile;
    _client = XtreamCodeClient(
      serverUrl: profile.baseUrl,
      username: profile.username,
      password: profile.password,
    );
  }

  /// Obtener categorías de canales en vivo con reintentos
  Future<List<Map<String, dynamic>>> fetchLiveCategories() async {
    return await _executeWithRetry(() async {
      if (_currentProfile == null) {
        throw Exception('Servicio no inicializado. Llame a initialize() primero.');
      }
      
      try {
        final response = await _client.getLiveCategories();
        return List<Map<String, dynamic>>.from(response.categories);
      } catch (e) {
        throw Exception('Error al obtener categorías de canales: $e');
      }
    });
  }

  /// Obtener canales en vivo con reintentos
  Future<List<Channel>> fetchLiveStreams({int? categoryId}) async {
    return await _executeWithRetry(() async {
      if (_currentProfile == null) {
        throw Exception('Servicio no inicializado. Llame a initialize() primero.');
      }
      
      try {
        final response = await _client.getLiveStreams(categoryId: categoryId);
        return response.streams.map((stream) {
          return Channel.fromJson(stream);
        }).toList();
      } catch (e) {
        throw Exception('Error al obtener canales en vivo: $e');
      }
    });
  }

  /// Obtener categorías de VOD con reintentos
  Future<List<Map<String, dynamic>>> fetchVodCategories() async {
    return await _executeWithRetry(() async {
      if (_currentProfile == null) {
        throw Exception('Servicio no inicializado. Llame a initialize() primero.');
      }
      
      try {
        final response = await _client.getVodCategories();
        return List<Map<String, dynamic>>.from(response.categories);
      } catch (e) {
        throw Exception('Error al obtener categorías de VOD: $e');
      }
    });
  }

  /// Obtener streams de VOD con reintentos
  Future<List<VodItem>> fetchVodStreams({int? categoryId}) async {
    return await _executeWithRetry(() async {
      if (_currentProfile == null) {
        throw Exception('Servicio no inicializado. Llame a initialize() primero.');
      }
      
      try {
        final response = await _client.getVodStreams(categoryId: categoryId);
        return response.streams.map((stream) {
          return VodItem.fromJson(stream);
        }).toList();
      } catch (e) {
        throw Exception('Error al obtener streams de VOD: $e');
      }
    });
  }

  /// Obtener categorías de series con reintentos
  Future<List<Map<String, dynamic>>> fetchSeriesCategories() async {
    return await _executeWithRetry(() async {
      if (_currentProfile == null) {
        throw Exception('Servicio no inicializado. Llame a initialize() primero.');
      }
      
      try {
        final response = await _client.getSeriesCategories();
        return List<Map<String, dynamic>>.from(response.categories);
      } catch (e) {
        throw Exception('Error al obtener categorías de series: $e');
      }
    });
  }

  /// Obtener información de series con reintentos
  Future<List<SeriesItem>> fetchSeriesInfo({int? categoryId}) async {
    return await _executeWithRetry(() async {
      if (_currentProfile == null) {
        throw Exception('Servicio no inicializado. Llame a initialize() primero.');
      }
      
      try {
        final response = await _client.getSeries(categoryId: categoryId);
        return response.series.map((series) {
          return SeriesItem.fromJson(series);
        }).toList();
      } catch (e) {
        throw Exception('Error al obtener información de series: $e');
      }
    });
  }

  /// Obtener EPG corto con reintentos
  Future<List<EpgEntry>> fetchShortEpg(int streamId) async {
    return await _executeWithRetry(() async {
      if (_currentProfile == null) {
        throw Exception('Servicio no inicializado. Llame a initialize() primero.');
      }
      
      try {
        final response = await _client.getShortEpg(streamId: streamId);
        return response.entries.map((entry) {
          return EpgEntry.fromJson(entry);
        }).toList();
      } catch (e) {
        throw Exception('Error al obtener EPG corto: $e');
      }
    });
  }

  /// Obtener información de autenticación
  Future<Map<String, dynamic>> getAccountInfo() async {
    return await _executeWithRetry(() async {
      if (_currentProfile == null) {
        throw Exception('Servicio no inicializado. Llame a initialize() primero.');
      }
      
      try {
        final response = await _client.getAccountInfo();
        return response.userInfo;
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