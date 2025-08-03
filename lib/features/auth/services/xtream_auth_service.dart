import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../shared/models/server_model.dart';

class XtreamAuthService {
  ServerModel? _currentServer;
  Map<String, dynamic>? _serverInfo;

  ServerModel? get currentServer => _currentServer;
  bool get isConnected => _currentServer != null && _serverInfo != null;

  /// Conectar con servidor Xtream Codes usando parámetros individuales
  Future<bool> connect({
    required String url,
    required String port,
    required String username,
    required String password,
  }) async {
    try {
      // Limpiar conexión anterior
      await disconnect();

      // Crear modelo de servidor temporal
      final server = ServerModel(
        id: 'temp',
        name: 'Servidor Temporal',
        url: url,
        port: port,
        username: username,
        password: password,
      );

      // Probar conexión obteniendo información del servidor
      final testUrl = '${server.fullUrl}/player_api.php?username=${server.username}&password=${server.password}';
      
      print('🔗 Probando conexión: $testUrl');
      
      final response = await http.get(
        Uri.parse(testUrl),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data['user_info'] != null) {
          _currentServer = server;
          _serverInfo = data;
          print('✅ Conectado al servidor: ${server.fullUrl}');
          print('👤 Usuario: ${data['user_info']['username']}');
          print('📊 Estado: ${data['user_info']['status']}');
          return true;
        } else {
          print('❌ Error: Respuesta inválida del servidor');
          return false;
        }
      } else {
        print('❌ Error HTTP: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('❌ Error de conexión: $e');
      await disconnect();
      return false;
    }
  }

  /// Conectar usando un modelo de servidor
  Future<bool> connectServer(ServerModel server) async {
    return await connect(
      url: server.url,
      port: server.port,
      username: server.username,
      password: server.password,
    );
  }

  /// Desconectar del servidor actual
  Future<void> disconnect() async {
    _currentServer = null;
    _serverInfo = null;
    print('🔌 Desconectado del servidor');
  }

  /// Obtener categorías de canales en vivo
  Future<List<dynamic>> getLiveCategories() async {
    if (!isConnected) throw Exception('No hay conexión activa');
    
    try {
      final url = '${_currentServer!.fullUrl}/player_api.php?username=${_currentServer!.username}&password=${_currentServer!.password}&action=get_live_categories';
      
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final List<dynamic> categories = json.decode(response.body);
        print('📺 Obtenidas ${categories.length} categorías de TV en vivo');
        return categories;
      } else {
        throw Exception('Error HTTP: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error obteniendo categorías live: $e');
      rethrow;
    }
  }

  /// Obtener canales en vivo por categoría
  Future<List<dynamic>> getLiveStreams({String? categoryId}) async {
    if (!isConnected) throw Exception('No hay conexión activa');
    
    try {
      String url = '${_currentServer!.fullUrl}/player_api.php?username=${_currentServer!.username}&password=${_currentServer!.password}&action=get_live_streams';
      
      if (categoryId != null) {
        url += '&category_id=$categoryId';
      }
      
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final List<dynamic> streams = json.decode(response.body);
        print('📺 Obtenidos ${streams.length} canales en vivo');
        return streams;
      } else {
        throw Exception('Error HTTP: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error obteniendo streams live: $e');
      rethrow;
    }
  }

  /// Obtener categorías de VOD
  Future<List<dynamic>> getVodCategories() async {
    if (!isConnected) throw Exception('No hay conexión activa');
    
    try {
      final url = '${_currentServer!.fullUrl}/player_api.php?username=${_currentServer!.username}&password=${_currentServer!.password}&action=get_vod_categories';
      
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final List<dynamic> categories = json.decode(response.body);
        print('🎬 Obtenidas ${categories.length} categorías de películas');
        return categories;
      } else {
        throw Exception('Error HTTP: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error obteniendo categorías VOD: $e');
      rethrow;
    }
  }

  /// Obtener películas VOD por categoría
  Future<List<dynamic>> getVodStreams({String? categoryId}) async {
    if (!isConnected) throw Exception('No hay conexión activa');
    
    try {
      String url = '${_currentServer!.fullUrl}/player_api.php?username=${_currentServer!.username}&password=${_currentServer!.password}&action=get_vod_streams';
      
      if (categoryId != null) {
        url += '&category_id=$categoryId';
      }
      
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final List<dynamic> streams = json.decode(response.body);
        print('🎬 Obtenidas ${streams.length} películas');
        return streams;
      } else {
        throw Exception('Error HTTP: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error obteniendo streams VOD: $e');
      rethrow;
    }
  }

  /// Obtener categorías de series
  Future<List<dynamic>> getSeriesCategories() async {
    if (!isConnected) throw Exception('No hay conexión activa');
    
    try {
      final url = '${_currentServer!.fullUrl}/player_api.php?username=${_currentServer!.username}&password=${_currentServer!.password}&action=get_series_categories';
      
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final List<dynamic> categories = json.decode(response.body);
        print('📺 Obtenidas ${categories.length} categorías de series');
        return categories;
      } else {
        throw Exception('Error HTTP: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error obteniendo categorías series: $e');
      rethrow;
    }
  }

  /// Obtener series por categoría
  Future<List<dynamic>> getSeries({String? categoryId}) async {
    if (!isConnected) throw Exception('No hay conexión activa');
    
    try {
      String url = '${_currentServer!.fullUrl}/player_api.php?username=${_currentServer!.username}&password=${_currentServer!.password}&action=get_series';
      
      if (categoryId != null) {
        url += '&category_id=$categoryId';
      }
      
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final List<dynamic> series = json.decode(response.body);
        print('📺 Obtenidas ${series.length} series');
        return series;
      } else {
        throw Exception('Error HTTP: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error obteniendo series: $e');
      rethrow;
    }
  }

  /// Obtener URL de stream para un canal
  String getStreamUrl(String streamId, {String format = 'ts'}) {
    if (!isConnected) throw Exception('No hay conexión activa');
    
    final server = _currentServer!;
    
    // Formato de URL para stream en vivo
    // http://server:port/live/username/password/streamid.ts
    // http://server:port/live/username/password/streamid.m3u8
    
    return '${server.fullUrl}/live/${server.username}/${server.password}/$streamId.$format';
  }

  /// Obtener URL de stream VOD
  String getVodStreamUrl(String streamId, {String format = 'mp4'}) {
    if (!isConnected) throw Exception('No hay conexión activa');
    
    final server = _currentServer!;
    
    // Formato de URL para VOD
    // http://server:port/movie/username/password/streamid.ext
    
    return '${server.fullUrl}/movie/${server.username}/${server.password}/$streamId.$format';
  }

  /// Obtener información detallada de una película
  Future<Map<String, dynamic>?> getVodInfo(String streamId) async {
    if (!isConnected) throw Exception('No hay conexión activa');
    
    try {
      final url = '${_currentServer!.fullUrl}/player_api.php?username=${_currentServer!.username}&password=${_currentServer!.password}&action=get_vod_info&vod_id=$streamId';
      
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Error HTTP: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error obteniendo info VOD: $e');
      return null;
    }
  }

  /// Obtener información detallada de una serie
  Future<Map<String, dynamic>?> getSeriesInfo(String seriesId) async {
    if (!isConnected) throw Exception('No hay conexión activa');
    
    try {
      final url = '${_currentServer!.fullUrl}/player_api.php?username=${_currentServer!.username}&password=${_currentServer!.password}&action=get_series_info&series_id=$seriesId';
      
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Error HTTP: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error obteniendo info serie: $e');
      return null;
    }
  }

  /// Obtener EPG corto para un canal
  Future<List<dynamic>> getShortEpg(String streamId, {int limit = 10}) async {
    if (!isConnected) throw Exception('No hay conexión activa');
    
    try {
      final url = '${_currentServer!.fullUrl}/player_api.php?username=${_currentServer!.username}&password=${_currentServer!.password}&action=get_short_epg&stream_id=$streamId&limit=$limit';
      
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['epg_listings'] != null) {
          return data['epg_listings'];
        }
        return [];
      } else {
        throw Exception('Error HTTP: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error obteniendo EPG: $e');
      return [];
    }
  }

  /// Obtener información del servidor actual
  Map<String, dynamic>? getServerInfo() {
    return _serverInfo;
  }
}
