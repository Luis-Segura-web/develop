import '../models/service_profile.dart';
import '../models/stream_item.dart';

/// Constructor de URLs para streams IPTV
class StreamUrlBuilder {
  /// Construir URL final para reproducción
  static String buildStreamUrl(
    ServiceProfile serviceProfile,
    StreamItem item,
    String extension,
  ) {
    final baseUrl = _normalizeBaseUrl(serviceProfile.baseUrl);
    final username = serviceProfile.username;
    final password = serviceProfile.password;
    final streamId = item.streamId;

    // Determinar el tipo de stream según el item
    String streamType;
    if (item is LiveStreamItem) {
      streamType = 'live';
    } else if (item is VodStreamItem) {
      streamType = 'movie';
    } else if (item is SeriesStreamItem) {
      streamType = 'series';
    } else {
      streamType = 'live'; // Por defecto
    }

    // Construir URL según el tipo de stream
    switch (streamType) {
      case 'live':
        return _buildLiveStreamUrl(baseUrl, username, password, streamId, extension);
      case 'movie':
        return _buildVodStreamUrl(baseUrl, username, password, streamId, extension);
      case 'series':
        return _buildSeriesStreamUrl(baseUrl, username, password, streamId, extension);
      default:
        return _buildLiveStreamUrl(baseUrl, username, password, streamId, extension);
    }
  }

  /// Construir URL para canal en vivo
  static String _buildLiveStreamUrl(
    String baseUrl,
    String username,
    String password,
    int streamId,
    String extension,
  ) {
    // Formato: http://domain:port/username/password/streamId.ext
    return '$baseUrl/$username/$password/$streamId.$extension';
  }

  /// Construir URL para VOD
  static String _buildVodStreamUrl(
    String baseUrl,
    String username,
    String password,
    int streamId,
    String extension,
  ) {
    // Formato: http://domain:port/movie/username/password/streamId.ext
    return '$baseUrl/movie/$username/$password/$streamId.$extension';
  }

  /// Construir URL para series
  static String _buildSeriesStreamUrl(
    String baseUrl,
    String username,
    String password,
    int streamId,
    String extension,
  ) {
    // Formato: http://domain:port/series/username/password/streamId.ext
    return '$baseUrl/series/$username/$password/$streamId.$extension';
  }

  /// Normalizar URL base eliminando barras finales
  static String _normalizeBaseUrl(String url) {
    return url.endsWith('/') ? url.substring(0, url.length - 1) : url;
  }

  /// Obtener extensión recomendada según el tipo de stream
  static String getRecommendedExtension(StreamItem item) {
    if (item is LiveStreamItem) {
      return 'm3u8'; // HLS para streams en vivo
    } else if (item is VodStreamItem) {
      return item.containerExtension.isNotEmpty 
          ? item.containerExtension 
          : 'mp4';
    } else if (item is SeriesStreamItem) {
      return 'mp4'; // Por defecto para series
    }
    return 'm3u8'; // Por defecto HLS
  }

  /// Construir URL con extensión recomendada
  static String buildRecommendedUrl(
    ServiceProfile serviceProfile,
    StreamItem item,
  ) {
    final extension = getRecommendedExtension(item);
    return buildStreamUrl(serviceProfile, item, extension);
  }

  /// Construir URLs alternativas para fallback
  static List<String> buildFallbackUrls(
    ServiceProfile serviceProfile,
    StreamItem item,
  ) {
    final urls = <String>[];
    
    // URL principal con extensión recomendada
    urls.add(buildRecommendedUrl(serviceProfile, item));
    
    // URLs alternativas
    if (item is LiveStreamItem) {
      // Para canales en vivo: m3u8, ts
      urls.add(buildStreamUrl(serviceProfile, item, 'm3u8'));
      urls.add(buildStreamUrl(serviceProfile, item, 'ts'));
    } else {
      // Para VOD/Series: mp4, mkv, avi
      urls.add(buildStreamUrl(serviceProfile, item, 'mp4'));
      urls.add(buildStreamUrl(serviceProfile, item, 'mkv'));
      urls.add(buildStreamUrl(serviceProfile, item, 'avi'));
    }
    
    // Remover duplicados manteniendo orden
    return urls.toSet().toList();
  }

  /// Validar si una URL es válida
  static bool isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }

  /// Construir URL de token si es necesario
  static String buildTokenUrl(
    ServiceProfile serviceProfile,
    StreamItem item,
    String extension,
    String token,
  ) {
    final baseUrl = buildStreamUrl(serviceProfile, item, extension);
    return '$baseUrl?token=$token';
  }
}