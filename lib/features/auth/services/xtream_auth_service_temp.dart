import 'package:xtream_code_client/xtream_code_client.dart';
import '../../../shared/models/server_model.dart';
import '../../../core/constants.dart';

class XtreamAuthService {
  XtreamCodeClient? _client;
  ServerModel? _currentServer;

  ServerModel? get currentServer => _currentServer;
  bool get isConnected => _client != null && _currentServer != null;

  /// Probar conexión con servidor Xtream Codes
  Future<bool> testConnection({
    required String url,
    required String port,
    required String username,
    required String password,
  }) async {
    try {
      // Limpiar conexión anterior
      await disconnect();

      // Crear cliente Xtream Code con credenciales correctas
      _client = XtreamCodeClient(
        baseUrl: url.contains('://') ? url : 'http://$url',
        port: int.tryParse(port) ?? 8080,
        username: username,
        password: password,
      );

      // Probar obtener información del servidor
      final serverInfo = await _client!.serverInformation();
      
      print('✅ Conexión exitosa: ${serverInfo.serverProtocol}');
      return true;
        } catch (e) {
      print('❌ Error de conexión: $e');
      return false;
    }
  }

  /// Conectar y autenticar con servidor Xtream Codes
  Future<bool> connect(ServerModel server) async {
    try {
      final success = await testConnection(
        url: server.url,
        port: server.port,
        username: server.username,
        password: server.password,
      );

      if (success) {
        _currentServer = server;
        print('🔌 Conectado al servidor: ${server.name}');
        return true;
      } else {
        print('❌ No se pudo conectar al servidor: ${server.name}');
        return false;
      }
    } catch (e) {
      print('❌ Error al conectar: $e');
      return false;
    }
  }

  /// Desconectar del servidor actual
  Future<void> disconnect() async {
    _client = null;
    _currentServer = null;
    print('🔌 Desconectado del servidor');
  }

  /// Obtener categorías de canales en vivo
  Future<List<dynamic>> getLiveCategories() async {
    if (!isConnected) throw Exception('No hay conexión activa');
    
    try {
      final categories = await _client!.liveStreamCategories();
      return categories.map((cat) => {
        'category_id': cat.categoryId,
        'category_name': cat.categoryName,
        'parent_id': cat.parentId,
      }).toList() ?? [];
    } catch (e) {
      print('❌ Error obteniendo categorías live: $e');
      return [];
    }
  }

  /// Obtener canales en vivo por categoría
  Future<List<dynamic>> getLiveStreams({String? categoryId}) async {
    if (!isConnected) throw Exception('No hay conexión activa');
    
    try {
      final streams = await _client!.livestreamItems(
        categoryId: categoryId,
      );
      return streams.map((stream) => {
        'stream_id': stream.streamId,
        'name': stream.streamName,
        'stream_icon': stream.streamIcon,
        'epg_channel_id': stream.epgChannelId,
        'category_id': stream.categoryId,
        'tv_archive': stream.tvArchive,
        'tvg_name': stream.tvgName,
        'tvg_logo': stream.tvgLogo,
        'stream_type': stream.streamType,
      }).toList() ?? [];
    } catch (e) {
      print('❌ Error obteniendo streams live: $e');
      return [];
    }
  }

  /// Obtener categorías de VOD
  Future<List<dynamic>> getVodCategories() async {
    if (!isConnected) throw Exception('No hay conexión activa');
    
    try {
      final categories = await _client!.vodStreamCategories();
      return categories?.map((cat) => {
        'category_id': cat.categoryId,
        'category_name': cat.categoryName,
        'parent_id': cat.parentId,
      }).toList() ?? [];
    } catch (e) {
      print('❌ Error obteniendo categorías VOD: $e');
      return [];
    }
  }

  /// Obtener películas VOD por categoría
  Future<List<dynamic>> getVodStreams({String? categoryId}) async {
    if (!isConnected) throw Exception('No hay conexión activa');
    
    try {
      final streams = await _client!.vodItems(
        categoryId: categoryId,
      );
      return streams.map((stream) => {
        'stream_id': stream.streamId,
        'name': stream.streamName,
        'stream_icon': stream.streamIcon,
        'category_id': stream.categoryId,
        'container_extension': stream.containerExtension,
        'added': stream.added,
      }).toList() ?? [];
    } catch (e) {
      print('❌ Error obteniendo streams VOD: $e');
      return [];
    }
  }

  /// Obtener categorías de series
  Future<List<dynamic>> getSeriesCategories() async {
    if (!isConnected) throw Exception('No hay conexión activa');
    
    try {
      final categories = await _client!.seriesCategories();
      return categories.map((cat) => {
        'category_id': cat.categoryId,
        'category_name': cat.categoryName,
        'parent_id': cat.parentId,
      }).toList() ?? [];
    } catch (e) {
      print('❌ Error obteniendo categorías series: $e');
      return [];
    }
  }

  /// Obtener series por categoría
  Future<List<dynamic>> getSeries({String? categoryId}) async {
    if (!isConnected) throw Exception('No hay conexión activa');
    
    try {
      final series = await _client!.seriesItems(
        categoryId: categoryId,
      );
      return series.map((serie) => {
        'series_id': serie.seriesId,
        'name': serie.name,
        'cover': serie.cover,
        'plot': serie.plot,
        'cast': serie.cast,
        'director': serie.director,
        'genre': serie.genre,
        'category_id': serie.categoryId,
      }).toList() ?? [];
    } catch (e) {
      print('❌ Error obteniendo series: $e');
      return [];
    }
  }

  /// Obtener URL de stream para un canal
  String getStreamUrl(String streamId, {String format = 'ts'}) {
    if (!isConnected) throw Exception('No hay conexión activa');
    
    final server = _currentServer!;
    final baseUrl = server.fullUrl;
    
    // Formato de URL para stream en vivo
    // http://server:port/live/username/password/streamid.ts
    // http://server:port/live/username/password/streamid.m3u8
    
    return '$baseUrl/live/${server.username}/${server.password}/$streamId.$format';
  }

  /// Obtener URL de stream VOD
  String getVodStreamUrl(String streamId, {String format = 'mp4'}) {
    if (!isConnected) throw Exception('No hay conexión activa');
    
    final server = _currentServer!;
    final baseUrl = server.fullUrl;
    
    // Formato de URL para VOD
    // http://server:port/movie/username/password/streamid.ext
    
    return '$baseUrl/movie/${server.username}/${server.password}/$streamId.$format';
  }

  /// Obtener información detallada de una película
  Future<Map<String, dynamic>?> getVodInfo(String streamId) async {
    if (!isConnected) throw Exception('No hay conexión activa');
    
    try {
      final info = await _client!.vodInfo(vodId: streamId);
      return info.toJson();
    } catch (e) {
      print('❌ Error obteniendo info VOD: $e');
      return null;
    }
  }

  /// Obtener información detallada de una serie
  Future<Map<String, dynamic>?> getSeriesInfo(String seriesId) async {
    if (!isConnected) throw Exception('No hay conexión activa');
    
    try {
      final info = await _client!.seriesInfo(seriesId: seriesId);
      return info.toJson();
    } catch (e) {
      print('❌ Error obteniendo info serie: $e');
      return null;
    }
  }

  /// Obtener EPG corto para un canal
  Future<List<dynamic>> getShortEpg(String streamId, {int limit = 10}) async {
    if (!isConnected) throw Exception('No hay conexión activa');
    
    try {
      final epg = await _client!.channelEpg(
        streamId: streamId,
        limit: limit,
      );
      return epg.map((program) => program.toJson()).toList() ?? [];
    } catch (e) {
      print('❌ Error obteniendo EPG: $e');
      return [];
    }
  }
}
