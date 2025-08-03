import 'package:isar/isar.dart';

part 'service_profile.g.dart';

/// Perfil de servicio IPTV con configuración Xtream Codes
@collection
class ServiceProfile {
  Id id = Isar.autoIncrement;

  @Index()
  final String baseUrl;
  
  final String username;
  final String password;
  final String? token;
  final DateTime? tokenExpiry;
  final String? preferredEngine;

  ServiceProfile({
    required this.baseUrl,
    required this.username,
    required this.password,
    this.token,
    this.tokenExpiry,
    this.preferredEngine,
  });

  /// Constructor desde JSON
  factory ServiceProfile.fromJson(Map<String, dynamic> json) {
    return ServiceProfile(
      baseUrl: json['base_url'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      token: json['token'] as String?,
      tokenExpiry: json['token_expiry'] != null 
          ? DateTime.parse(json['token_expiry'] as String)
          : null,
      preferredEngine: json['preferred_engine'] as String?,
    );
  }

  /// Convertir a JSON
  Map<String, dynamic> toJson() {
    return {
      'base_url': baseUrl,
      'username': username,
      'password': password,
      'token': token,
      'token_expiry': tokenExpiry?.toIso8601String(),
      'preferred_engine': preferredEngine,
    };
  }

  /// Verificar si el token necesita renovación
  bool get needsTokenRefresh {
    if (token == null || tokenExpiry == null) return true;
    return DateTime.now().add(const Duration(minutes: 5)).isAfter(tokenExpiry!);
  }

  /// Método para renovar token si es necesario
  Future<void> refreshTokenIfNeeded() async {
    if (!needsTokenRefresh) return;
    
    try {
      // TODO: Llamar a XtreamCode.instance.client.serverInformation()
      // Implementación pendiente tras configuración del servicio
    } catch (e) {
      // Manejar errores si es necesario
      rethrow;
    }
  }

  /// Crear copia con campos actualizados
  ServiceProfile copyWith({
    String? baseUrl,
    String? username,
    String? password,
    String? token,
    DateTime? tokenExpiry,
    String? preferredEngine,
  }) {
    return ServiceProfile(
      baseUrl: baseUrl ?? this.baseUrl,
      username: username ?? this.username,
      password: password ?? this.password,
      token: token ?? this.token,
      tokenExpiry: tokenExpiry ?? this.tokenExpiry,
      preferredEngine: preferredEngine ?? this.preferredEngine,
    );
  }

  /// Overrides para equals y hashCode
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ServiceProfile &&
        other.baseUrl == baseUrl &&
        other.username == username &&
        other.password == password &&
        other.token == token &&
        other.tokenExpiry == tokenExpiry &&
        other.preferredEngine == preferredEngine;
  }

  @override
  int get hashCode {
    return Object.hash(
      baseUrl,
      username,
      password,
      token,
      tokenExpiry,
      preferredEngine,
    );
  }
}