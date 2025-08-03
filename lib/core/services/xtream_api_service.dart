
import 'package:dio/dio.dart';
import '../models/category.dart';
import '../models/stream_item.dart';
import '../models/epg_entry.dart';

/// Excepción genérica para errores de API Xtream Codes
class XtreamApiException implements Exception {
  final String message;
  XtreamApiException(this.message);

  @override
  String toString() => 'XtreamApiException: $message';
}

/// Servicio para interactuar con API Xtream Codes V2
class XtreamApiService {
  final String baseUrl;
  final String username;
  final String password;
  final Dio _dio;

  XtreamApiService({
    required this.baseUrl,
    required this.username,
    required this.password,
  }) : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: const Duration(seconds: 5),
            receiveTimeout: const Duration(seconds: 5),
            responseType: ResponseType.json,
          ),
        );

  Future<List<Category>> getLiveCategories() async {
    try {
      final response = await _dio.get('/player_api.php',
          queryParameters: {
            'username': username,
            'password': password,
            'action': 'get_live_categories',
          });
      return _parseList<Category>(response.data, (e) => Category.fromJson(e));
    } on DioError catch (e) {
      throw XtreamApiException('Error al obtener categorías en vivo: ${e.message}');
    } on FormatException {
      throw XtreamApiException('Respuesta JSON inválido en getLiveCategories');
    }
  }

  Future<List<StreamItem>> getLiveStreams(String categoryId) async {
    try {
      final response = await _dio.get('/player_api.php',
          queryParameters: {
            'username': username,
            'password': password,
            'action': 'get_live_streams',
          });
      // Filtrar por categoría si es necesario
      final list = _parseList<StreamItem>(response.data, (e) => StreamItem.fromJson(e));
      if (categoryId.isNotEmpty) {
        return list.where((s) => s.streamId == categoryId).toList();
      }
      return list;
    } on DioError catch (e) {
      throw XtreamApiException('Error al obtener streams en vivo: ${e.message}');
    } on FormatException {
      throw XtreamApiException('Respuesta JSON inválido en getLiveStreams');
    }
  }

  Future<List<Category>> getVodCategories() async {
    try {
      final response = await _dio.get('/player_api.php',
          queryParameters: {
            'username': username,
            'password': password,
            'action': 'get_vod_categories',
          });
      return _parseList<Category>(response.data, (e) => Category.fromJson(e));
    } catch (e) {
      throw XtreamApiException('Error al obtener categorías VOD: $e');
    }
  }

  Future<List<StreamItem>> getVodStreams(String categoryId) async {
    try {
      final response = await _dio.get('/player_api.php',
          queryParameters: {
            'username': username,
            'password': password,
            'action': 'get_vod_streams',
            'category_id': categoryId,
          });
      return _parseList<StreamItem>(response.data, (e) => StreamItem.fromJson(e));
    } catch (e) {
      throw XtreamApiException('Error al obtener streams VOD: $e');
    }
  }

  Future<List<Category>> getSeriesCategories() async {
    try {
      final response = await _dio.get('/player_api.php',
          queryParameters: {
            'username': username,
            'password': password,
            'action': 'get_series_categories',
          });
      return _parseList<Category>(response.data, (e) => Category.fromJson(e));
    } catch (e) {
      throw XtreamApiException('Error al obtener categorías de series: $e');
    }
  }

  Future<List<StreamItem>> getSeries(String categoryId) async {
    try {
      final response = await _dio.get('/player_api.php',
          queryParameters: {
            'username': username,
            'password': password,
            'action': 'get_series',
            'series_id': categoryId,
          });
      return _parseList<StreamItem>(response.data, (e) => StreamItem.fromJson(e));
    } catch (e) {
      throw XtreamApiException('Error al obtener series: $e');
    }
  }

  Future<Map<String, dynamic>> getSeriesInfo(String seriesId) async {
    try {
      final response = await _dio.get('/player_api.php',
          queryParameters: {
            'username': username,
            'password': password,
            'action': 'get_series_info',
            'series_id': seriesId,
          });
      return Map<String, dynamic>.from(response.data);
    } catch (e) {
      throw XtreamApiException('Error al obtener info de serie: $e');
    }
  }

  Future<List<EpgEntry>> getShortEpg(String channelId) async {
    try {
      final response = await _dio.get('/player_api.php',
          queryParameters: {
            'username': username,
            'password': password,
            'action': 'get_short_epg',
            'stream_id': channelId,
          });
      return _parseList<EpgEntry>(response.data, (e) => EpgEntry.fromJson(e));
    } catch (e) {
      throw XtreamApiException('Error al obtener EPG corto: $e');
    }
  }

  /// Helper para parsear listas de JSON a modelos
  List<T> _parseList<T>(dynamic data, T Function(Map<String, dynamic>) parser) {
    if (data is List) {
      return data.map<T>((e) => parser(Map<String, dynamic>.from(e))).toList();
    }
    throw FormatException('Formato de datos inesperado');
  }
}
