import '../models/service_profile.dart';

/// Logger de analítica para eventos de reproducción
class PlaybackLogger {
  static PlaybackLogger? _instance;
  
  PlaybackLogger._internal();
  
  static PlaybackLogger get instance {
    _instance ??= PlaybackLogger._internal();
    return _instance!;
  }
  
  factory PlaybackLogger() => instance;

  /// Log de inicio de reproducción
  void logPlayStarted({
    required String url,
    required PlayerEngine engine,
    required String streamType,
    required int streamId,
    Map<String, dynamic>? additionalData,
  }) {
    final event = {
      'event': 'play_started',
      'timestamp': DateTime.now().toIso8601String(),
      'url': _sanitizeUrl(url),
      'engine': engine.name,
      'stream_type': streamType,
      'stream_id': streamId,
      'session_id': _generateSessionId(),
      ...?additionalData,
    };
    
    _logEvent(event);
  }

  /// Log de fallo en reproducción
  void logPlayFailed({
    required String url,
    required PlayerEngine engine,
    required String error,
    required int streamId,
    Map<String, dynamic>? additionalData,
  }) {
    final event = {
      'event': 'play_failed',
      'timestamp': DateTime.now().toIso8601String(),
      'url': _sanitizeUrl(url),
      'engine': engine.name,
      'error': error,
      'stream_id': streamId,
      'session_id': _generateSessionId(),
      ...?additionalData,
    };
    
    _logEvent(event);
  }

  /// Log de cambio de motor de reproducción
  void logEngineSwitch({
    required PlayerEngine fromEngine,
    required PlayerEngine toEngine,
    required String url,
    required int streamId,
    Map<String, dynamic>? additionalData,
  }) {
    final event = {
      'event': 'engine_switch',
      'timestamp': DateTime.now().toIso8601String(),
      'from_engine': fromEngine.name,
      'to_engine': toEngine.name,
      'url': _sanitizeUrl(url),
      'stream_id': streamId,
      'session_id': _generateSessionId(),
      ...?additionalData,
    };
    
    _logEvent(event);
  }

  /// Log de pausa de reproducción
  void logPlayPaused({
    required String url,
    required PlayerEngine engine,
    required int streamId,
    required Duration position,
    Map<String, dynamic>? additionalData,
  }) {
    final event = {
      'event': 'play_paused',
      'timestamp': DateTime.now().toIso8601String(),
      'url': _sanitizeUrl(url),
      'engine': engine.name,
      'stream_id': streamId,
      'position_ms': position.inMilliseconds,
      'session_id': _generateSessionId(),
      ...?additionalData,
    };
    
    _logEvent(event);
  }

  /// Log de reanudación de reproducción
  void logPlayResumed({
    required String url,
    required PlayerEngine engine,
    required int streamId,
    required Duration position,
    Map<String, dynamic>? additionalData,
  }) {
    final event = {
      'event': 'play_resumed',
      'timestamp': DateTime.now().toIso8601String(),
      'url': _sanitizeUrl(url),
      'engine': engine.name,
      'stream_id': streamId,
      'position_ms': position.inMilliseconds,
      'session_id': _generateSessionId(),
      ...?additionalData,
    };
    
    _logEvent(event);
  }

  /// Log de finalización de reproducción
  void logPlayStopped({
    required String url,
    required PlayerEngine engine,
    required int streamId,
    required Duration totalDuration,
    required Duration watchedDuration,
    String? reason,
    Map<String, dynamic>? additionalData,
  }) {
    final event = {
      'event': 'play_stopped',
      'timestamp': DateTime.now().toIso8601String(),
      'url': _sanitizeUrl(url),
      'engine': engine.name,
      'stream_id': streamId,
      'total_duration_ms': totalDuration.inMilliseconds,
      'watched_duration_ms': watchedDuration.inMilliseconds,
      'completion_percentage': _calculateCompletionPercentage(totalDuration, watchedDuration),
      'reason': reason ?? 'user_action',
      'session_id': _generateSessionId(),
      ...?additionalData,
    };
    
    _logEvent(event);
  }

  /// Log de error de buffer
  void logBufferError({
    required String url,
    required PlayerEngine engine,
    required int streamId,
    required String errorDetails,
    Map<String, dynamic>? additionalData,
  }) {
    final event = {
      'event': 'buffer_error',
      'timestamp': DateTime.now().toIso8601String(),
      'url': _sanitizeUrl(url),
      'engine': engine.name,
      'stream_id': streamId,
      'error_details': errorDetails,
      'session_id': _generateSessionId(),
      ...?additionalData,
    };
    
    _logEvent(event);
  }

  /// Log de información de calidad de stream
  void logStreamQuality({
    required String url,
    required PlayerEngine engine,
    required int streamId,
    String? bitrate,
    String? resolution,
    String? codec,
    Map<String, dynamic>? additionalData,
  }) {
    final event = {
      'event': 'stream_quality',
      'timestamp': DateTime.now().toIso8601String(),
      'url': _sanitizeUrl(url),
      'engine': engine.name,
      'stream_id': streamId,
      'bitrate': bitrate,
      'resolution': resolution,
      'codec': codec,
      'session_id': _generateSessionId(),
      ...?additionalData,
    };
    
    _logEvent(event);
  }

  /// Log de eventos de conectividad
  void logConnectivityEvent({
    required String eventType, // 'network_lost', 'network_restored', 'reconnecting'
    required String url,
    required int streamId,
    Map<String, dynamic>? additionalData,
  }) {
    final event = {
      'event': 'connectivity_$eventType',
      'timestamp': DateTime.now().toIso8601String(),
      'url': _sanitizeUrl(url),
      'stream_id': streamId,
      'session_id': _generateSessionId(),
      ...?additionalData,
    };
    
    _logEvent(event);
  }

  /// Sanitizar URL para logging (remover credenciales)
  String _sanitizeUrl(String url) {
    try {
      final uri = Uri.parse(url);
      final sanitized = Uri(
        scheme: uri.scheme,
        host: uri.host,
        port: uri.port,
        path: uri.path,
        query: uri.query.isNotEmpty ? '[QUERY_PARAMS]' : null,
      );
      return sanitized.toString();
    } catch (e) {
      return '[INVALID_URL]';
    }
  }

  /// Generar ID de sesión único
  String _generateSessionId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  /// Calcular porcentaje de completitud
  double _calculateCompletionPercentage(Duration total, Duration watched) {
    if (total.inMilliseconds == 0) return 0.0;
    return (watched.inMilliseconds / total.inMilliseconds * 100).clamp(0.0, 100.0);
  }

  /// Enviar evento a sistema de analytics
  void _logEvent(Map<String, dynamic> event) {
    // En desarrollo, mostrar en consola
    print('🎬 PLAYBACK EVENT: ${event['event']}');
    print('   Details: $event');
    
    // TODO: En producción, enviar a servicio de analytics
    // Ejemplos:
    // - Firebase Analytics
    // - Google Analytics
    // - Sistema de analytics personalizado
    // - Archivo local para debugging
    
    _saveToLocalLog(event);
  }

  /// Guardar evento en log local para debugging
  void _saveToLocalLog(Map<String, dynamic> event) {
    // TODO: Implementar guardado en archivo local
    // Útil para debugging y análisis offline
  }

  /// Obtener estadísticas de reproducción
  Map<String, dynamic> getPlaybackStats() {
    // TODO: Implementar recopilación de estadísticas
    return {
      'total_plays': 0,
      'successful_plays': 0,
      'failed_plays': 0,
      'engine_usage': {
        'media3': 0,
        'vlc': 0,
      },
      'average_watch_time': 0,
      'most_used_streams': [],
    };
  }

  /// Limpiar logs antiguos
  Future<void> cleanOldLogs({Duration? olderThan}) async {
    olderThan ??= const Duration(days: 30);
    
    // TODO: Implementar limpieza de logs antiguos
    print('Limpiando logs más antiguos de ${olderThan.inDays} días');
  }

  /// Exportar logs para análisis
  Future<String?> exportLogs({
    DateTime? startDate,
    DateTime? endDate,
    String format = 'json',
  }) async {
    // TODO: Implementar exportación de logs
    print('Exportando logs del $startDate al $endDate en formato $format');
    return null;
  }
}