import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants.dart';

/// Logger de analítica para eventos de reproducción
class PlaybackLogger {
  static PlaybackLogger? _instance;
  
  // Contadores de estadísticas
  int _totalPlays = 0;
  int _successfulPlays = 0;
  int _failedPlays = 0;
  final Map<String, int> _engineUsage = {'media3': 0, 'vlc': 0};
  final List<Map<String, dynamic>> _localLogs = [];
  
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
    
    // Actualizar estadísticas
    _totalPlays++;
    _engineUsage[engine.name] = (_engineUsage[engine.name] ?? 0) + 1;
    _saveStats(); // Guardar asincrónicamente
    
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
    
    // Actualizar estadísticas de fallos
    _failedPlays++;
    _saveStats();
    
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
    
    // Si la reproducción se completó exitosamente (más del 80%), contar como exitosa
    final completionPercentage = _calculateCompletionPercentage(totalDuration, watchedDuration);
    if (completionPercentage > 80) {
      _successfulPlays++;
      _saveStats();
    }
    
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
    
    // Implementar envío a servicio de analytics (fire and forget)
    _sendToAnalyticsService(event);
    
    // Guardar en log local para backup y debugging (fire and forget)
    _saveToLocalLog(event);
  }

  /// Enviar evento a servicio de analytics
  Future<void> _sendToAnalyticsService(Map<String, dynamic> event) async {
    try {
      // En producción, aquí se enviaría a servicios como:
      // - Firebase Analytics
      // - Google Analytics
      // - Sistema de analytics personalizado
      
      // Simular envío exitoso
      await Future.delayed(const Duration(milliseconds: 100));
      
      // Por ahora, solo registrar el envío localmente
      print('📊 Analytics: Evento enviado - ${event['event']}');
      
      // En implementación real:
      // await firebaseAnalytics.logEvent(name: event['event'], parameters: event);
      // o
      // await httpClient.post(analyticsEndpoint, body: json.encode(event));
      
    } catch (e) {
      print('❌ Error enviando a analytics: $e');
      // En caso de error, asegurar que se guarde localmente
    }
  }

  /// Guardar evento en log local para debugging
  Future<void> _saveToLocalLog(Map<String, dynamic> event) async {
    try {
      // Agregar timestamp y guardar en memoria
      final logEntry = {
        ...event,
        'local_timestamp': DateTime.now().toIso8601String(),
        'logged_at': DateTime.now().millisecondsSinceEpoch,
      };
      
      _localLogs.add(logEntry);
      
      // Mantener solo los últimos 1000 eventos en memoria
      if (_localLogs.length > 1000) {
        _localLogs.removeRange(0, _localLogs.length - 1000);
      }
      
      // Guardar en archivo local
      await _writeToLogFile(logEntry);
      
      print('💾 Log guardado localmente: ${event['event']}');
      
    } catch (e) {
      print('❌ Error guardando log local: $e');
    }
  }

  /// Escribir entrada de log a archivo
  Future<void> _writeToLogFile(Map<String, dynamic> logEntry) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final logsDir = Directory('${directory.path}/iptv_logs');
      
      if (!await logsDir.exists()) {
        await logsDir.create(recursive: true);
      }
      
      // Crear archivo con fecha actual
      final today = DateTime.now();
      final fileName = 'playback_${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}.log';
      final logFile = File('${logsDir.path}/$fileName');
      
      // Escribir línea de log en formato JSON
      final logLine = '${json.encode(logEntry)}\n';
      await logFile.writeAsString(logLine, mode: FileMode.append);
      
    } catch (e) {
      print('❌ Error escribiendo archivo de log: $e');
    }
  }

  /// Obtener estadísticas de reproducción
  Future<Map<String, dynamic>> getPlaybackStats() async {
    try {
      // Cargar estadísticas guardadas
      await _loadStats();
      
      return {
        'total_plays': _totalPlays,
        'successful_plays': _successfulPlays,
        'failed_plays': _failedPlays,
        'success_rate': _totalPlays > 0 ? (_successfulPlays / _totalPlays * 100).toStringAsFixed(1) : '0.0',
        'engine_usage': Map<String, dynamic>.from(_engineUsage),
        'preferred_engine': _getMostUsedEngine(),
        'logs_in_memory': _localLogs.length,
        'last_updated': DateTime.now().toIso8601String(),
        'recent_events': _getRecentEvents(5),
        'average_watch_time': 0, // Podría calcularse con más datos
        'most_used_streams': [], // Requiere tracking adicional
      };
    } catch (e) {
      print('Error obteniendo estadísticas: $e');
      return {
        'total_plays': 0,
        'successful_plays': 0,
        'failed_plays': 0,
        'success_rate': '0.0',
        'engine_usage': {'media3': 0, 'vlc': 0},
        'preferred_engine': 'media3',
        'logs_in_memory': 0,
        'last_updated': DateTime.now().toIso8601String(),
        'recent_events': [],
        'average_watch_time': 0,
        'most_used_streams': [],
      };
    }
  }

  /// Limpiar logs antiguos
  Future<void> cleanOldLogs({Duration? olderThan}) async {
    olderThan ??= const Duration(days: 30);
    
    try {
      final directory = await getApplicationDocumentsDirectory();
      final logsDir = Directory('${directory.path}/iptv_logs');
      
      if (!await logsDir.exists()) {
        print('📁 Directorio de logs no existe, no hay nada que limpiar');
        return;
      }
      
      final cutoffDate = DateTime.now().subtract(olderThan);
      int filesDeleted = 0;
      
      await for (final file in logsDir.list()) {
        if (file is File && file.path.endsWith('.log')) {
          final fileStat = await file.stat();
          if (fileStat.modified.isBefore(cutoffDate)) {
            await file.delete();
            filesDeleted++;
            print('🗑️ Log eliminado: ${file.path}');
          }
        }
      }
      
      // Limpiar logs en memoria que sean muy antiguos
      final oldLogCount = _localLogs.length;
      _localLogs.removeWhere((log) {
        final logTime = DateTime.fromMillisecondsSinceEpoch(log['logged_at'] ?? 0);
        return logTime.isBefore(cutoffDate);
      });
      
      final memoryLogsRemoved = oldLogCount - _localLogs.length;
      
      print('🧹 Limpieza completada:');
      print('   - Archivos eliminados: $filesDeleted');
      print('   - Logs en memoria removidos: $memoryLogsRemoved');
      print('   - Logs más antiguos de ${olderThan.inDays} días');
      
    } catch (e) {
      print('❌ Error limpiando logs antiguos: $e');
    }
  }

  /// Exportar logs para análisis
  Future<String?> exportLogs({
    DateTime? startDate,
    DateTime? endDate,
    String format = 'json',
  }) async {
    try {
      startDate ??= DateTime.now().subtract(const Duration(days: 7));
      endDate ??= DateTime.now();
      
      final directory = await getApplicationDocumentsDirectory();
      final logsDir = Directory('${directory.path}/iptv_logs');
      final exportDir = Directory('${directory.path}/iptv_exports');
      
      if (!await exportDir.exists()) {
        await exportDir.create(recursive: true);
      }
      
      final exportData = <Map<String, dynamic>>[];
      
      // Recopilar logs de archivos
      if (await logsDir.exists()) {
        await for (final file in logsDir.list()) {
          if (file is File && file.path.endsWith('.log')) {
            final lines = await file.readAsLines();
            for (final line in lines) {
              try {
                final logEntry = json.decode(line) as Map<String, dynamic>;
                final logTime = DateTime.parse(logEntry['timestamp'] ?? '');
                
                if (logTime.isAfter(startDate) && logTime.isBefore(endDate)) {
                  exportData.add(logEntry);
                }
              } catch (e) {
                // Ignorar líneas mal formateadas
              }
            }
          }
        }
      }
      
      // Agregar logs en memoria si están en el rango
      for (final log in _localLogs) {
        final logTime = DateTime.parse(log['timestamp'] ?? '');
        if (logTime.isAfter(startDate) && logTime.isBefore(endDate)) {
          exportData.add(log);
        }
      }
      
      // Ordenar por timestamp
      exportData.sort((a, b) {
        final timeA = DateTime.parse(a['timestamp'] ?? '');
        final timeB = DateTime.parse(b['timestamp'] ?? '');
        return timeA.compareTo(timeB);
      });
      
      // Generar archivo de exportación
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName = 'playback_export_$timestamp.$format';
      final exportFile = File('${exportDir.path}/$fileName');
      
      String content;
      switch (format.toLowerCase()) {
        case 'csv':
          content = _generateCSVContent(exportData);
          break;
        case 'txt':
          content = _generateTextContent(exportData);
          break;
        case 'json':
        default:
          content = _generateJSONContent(exportData);
          break;
      }
      
      await exportFile.writeAsString(content);
      
      print('📤 Exportación completada:');
      print('   - Archivo: ${exportFile.path}');
      print('   - Registros: ${exportData.length}');
      print('   - Formato: $format');
      print('   - Período: ${startDate.toIso8601String()} - ${endDate.toIso8601String()}');
      
      return exportFile.path;
      
    } catch (e) {
      print('❌ Error exportando logs: $e');
      return null;
    }
  }

  /// Generar contenido JSON para exportación
  String _generateJSONContent(List<Map<String, dynamic>> logs) {
    final exportData = {
      'metadata': {
        'exported_at': DateTime.now().toIso8601String(),
        'total_records': logs.length,
        'app_version': '1.0.0',
        'export_type': 'playback_logs',
      },
      'logs': logs,
    };
    
    return json.encode(exportData);
  }

  /// Generar contenido CSV para exportación
  String _generateCSVContent(List<Map<String, dynamic>> logs) {
    if (logs.isEmpty) return 'timestamp,event,engine,url,stream_id\n';
    
    final buffer = StringBuffer();
    buffer.writeln('timestamp,event,engine,url,stream_id,details');
    
    for (final log in logs) {
      final timestamp = log['timestamp'] ?? '';
      final event = log['event'] ?? '';
      final engine = log['engine'] ?? '';
      final url = log['url'] ?? '';
      final streamId = log['stream_id'] ?? '';
      final details = log['details']?.toString().replaceAll(',', ';') ?? '';
      
      buffer.writeln('$timestamp,$event,$engine,$url,$streamId,$details');
    }
    
    return buffer.toString();
  }

  /// Generar contenido de texto plano para exportación
  String _generateTextContent(List<Map<String, dynamic>> logs) {
    final buffer = StringBuffer();
    buffer.writeln('=== REPORTE DE REPRODUCCIÓN IPTV ===');
    buffer.writeln('Exportado: ${DateTime.now().toIso8601String()}');
    buffer.writeln('Total de registros: ${logs.length}');
    buffer.writeln('');
    
    for (final log in logs) {
      buffer.writeln('--- ${log['timestamp']} ---');
      buffer.writeln('Evento: ${log['event']}');
      buffer.writeln('Motor: ${log['engine']}');
      buffer.writeln('URL: ${log['url']}');
      buffer.writeln('Stream ID: ${log['stream_id']}');
      if (log['details'] != null) {
        buffer.writeln('Detalles: ${log['details']}');
      }
      buffer.writeln('');
    }
    
    return buffer.toString();
  }

  /// Cargar estadísticas desde SharedPreferences
  Future<void> _loadStats() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _totalPlays = prefs.getInt('analytics_total_plays') ?? 0;
      _successfulPlays = prefs.getInt('analytics_successful_plays') ?? 0;
      _failedPlays = prefs.getInt('analytics_failed_plays') ?? 0;
      
      final engineUsageJson = prefs.getString('analytics_engine_usage') ?? '{"media3": 0, "vlc": 0}';
      final engineData = json.decode(engineUsageJson) as Map<String, dynamic>;
      _engineUsage['media3'] = engineData['media3'] ?? 0;
      _engineUsage['vlc'] = engineData['vlc'] ?? 0;
    } catch (e) {
      print('Error cargando estadísticas: $e');
    }
  }

  /// Guardar estadísticas en SharedPreferences
  Future<void> _saveStats() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('analytics_total_plays', _totalPlays);
      await prefs.setInt('analytics_successful_plays', _successfulPlays);
      await prefs.setInt('analytics_failed_plays', _failedPlays);
      await prefs.setString('analytics_engine_usage', json.encode(_engineUsage));
    } catch (e) {
      print('Error guardando estadísticas: $e');
    }
  }

  /// Obtener el motor más usado
  String _getMostUsedEngine() {
    if (_engineUsage['vlc']! > _engineUsage['media3']!) {
      return 'vlc';
    } else if (_engineUsage['media3']! > _engineUsage['vlc']!) {
      return 'media3';
    } else {
      return 'balanced';
    }
  }

  /// Obtener eventos recientes
  List<Map<String, dynamic>> _getRecentEvents(int count) {
    if (_localLogs.isEmpty) return [];
    
    final recentLogs = _localLogs.length > count 
        ? _localLogs.sublist(_localLogs.length - count)
        : _localLogs;
    
    return recentLogs.map((log) => {
      'event': log['event'],
      'timestamp': log['timestamp'],
      'engine': log['engine'],
    }).toList();
  }
}