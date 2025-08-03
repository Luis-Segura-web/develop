// Constantes principales de la aplicación
class AppConstants {
  // URLs de API Xtream Codes
  static const String playerApiPath = '/player_api.php';
  static const String xmltvPath = '/xmltv.php';
  
  // Acciones de API
  static const String actionGetLiveCategories = 'get_live_categories';
  static const String actionGetLiveStreams = 'get_live_streams';
  static const String actionGetVodCategories = 'get_vod_categories';
  static const String actionGetVodStreams = 'get_vod_streams';
  static const String actionGetVodInfo = 'get_vod_info';
  static const String actionGetSeriesCategories = 'get_series_categories';
  static const String actionGetSeries = 'get_series';
  static const String actionGetSeriesInfo = 'get_series_info';
  static const String actionGetShortEpg = 'get_short_epg';
  static const String actionGetSimpleDataTable = 'get_simple_data_table';
  
  // Formatos de stream
  static const List<String> supportedStreamFormats = ['ts', 'm3u8'];
  
  // Configuraciones de cache
  static const int maxCacheSize = 100 * 1024 * 1024; // 100MB
  static const Duration cacheExpiration = Duration(hours: 6);
  static const Duration epgCacheExpiration = Duration(hours: 2);
  
  // Configuraciones de reproductor
  static const Duration seekIncrement = Duration(seconds: 10);
  static const Duration maxBufferDuration = Duration(seconds: 30);
  static const int maxRetryAttempts = 3;
  static const Duration retryDelay = Duration(seconds: 2);
  
  // Configuraciones de UI
  static const int gridCrossAxisCount = 2;
  static const double gridChildAspectRatio = 16 / 9;
  static const Duration animationDuration = Duration(milliseconds: 300);
  
  // Configuraciones de seguridad
  static const String secureStorageKey = 'iptv_credentials';
  static const String pinKey = 'parental_pin';
  static const int pinLength = 4;
  
  // Base de datos local
  static const String serversBoxName = 'servers';
  static const String favoritesBoxName = 'favorites';
  static const String historyBoxName = 'history';
  static const String settingsBoxName = 'settings';
  static const String cacheBoxName = 'cache';
  
  // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 60);
  static const Duration sendTimeout = Duration(seconds: 30);
}

// Enums para diferentes tipos de contenido
enum ContentType {
  live,
  vod,
  series,
}

enum StreamFormat {
  ts,
  m3u8,
}

enum PlayerState {
  idle,
  loading,
  ready,
  playing,
  paused,
  error,
  ended,
}

enum ConnectionStatus {
  disconnected,
  connecting,
  connected,
  error,
}
