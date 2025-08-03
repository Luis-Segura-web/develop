import '../constants.dart';

/// Utilidad para construir URLs de reproducción Xtream Codes
class StreamUrlBuilder {
  /// Construye la URL de reproducción para el tipo de contenido dado.
  ///
  /// [type]: live, vod o series
  /// [baseUrl]: URL base del servidor (incluye protocolo y puerto)
  /// [username], [password]: credenciales Xtream Codes
  /// [streamId]: ID del stream (canal, película o serie)
  /// [queryParams]: parámetros opcionales de consulta
  static Uri build({
    required ContentType type,
    required String baseUrl,
    required String username,
    required String password,
    required String streamId,
    Map<String, String>? queryParams,
  }) {
    final baseUri = Uri.parse(baseUrl);
    // Selección de segmento según tipo de contenido
    final pathSegment = type == ContentType.live
        ? 'live'
        : type == ContentType.vod
            ? 'movie'
            : 'series';
    // Extensión de archivo por defecto (.ts)
    final fileExt = AppConstants.supportedStreamFormats.first;

    return Uri(
      scheme: baseUri.scheme,
      host: baseUri.host,
      port: baseUri.port,
      // Construye la ruta: /live/USER/PASS/streamId.ext
      pathSegments: [
        pathSegment,
        username,
        password,
        '$streamId.$fileExt',
      ],
      queryParameters: queryParams,
    );
  }
}
