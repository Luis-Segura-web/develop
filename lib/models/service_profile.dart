import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

part 'service_profile.g.dart';

/// Perfil de servicio IPTV con configuración Xtream Codes
@collection
class ServiceProfile extends Equatable {
  Id id = Isar.autoIncrement;

  @Index()
  final String baseUrl;
  
  final String username;
  final String password;
  final String? token;
  final DateTime? tokenExpiry;
  
  @enumerated
  final PlayerEngine preferredEngine;

  const ServiceProfile({
    required this.baseUrl,
    required this.username,
    required this.password,
    this.token,
    this.tokenExpiry,
    this.preferredEngine = PlayerEngine.media3,
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
      preferredEngine: PlayerEngine.values.firstWhere(
        (e) => e.name == json['preferred_engine'],
        orElse: () => PlayerEngine.media3,
      ),
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
      'preferred_engine': preferredEngine.name,
    };
  }

  /// Verificar si el token necesita renovación
  bool get needsTokenRefresh {
    if (token == null || tokenExpiry == null) return true;
    return DateTime.now().add(const Duration(minutes: 5)).isAfter(tokenExpiry!);
  }

  /// Método para renovar token si es necesario
  Future<ServiceProfile> refreshTokenIfNeeded() async {
    if (!needsTokenRefresh) return this;
    
    // El refresh real del token se hace en XtreamService
    // Este método solo verifica la necesidad
    return copyWith(token: null, tokenExpiry: null);
  }

  /// Crear copia con campos actualizados
  ServiceProfile copyWith({
    String? baseUrl,
    String? username,
    String? password,
    String? token,
    DateTime? tokenExpiry,
    PlayerEngine? preferredEngine,
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

  @override
  List<Object?> get props => [
        baseUrl,
        username,
        password,
        token,
        tokenExpiry,
        preferredEngine,
      ];
}

/// Motores de reproducción disponibles
enum PlayerEngine {
  media3,  // video_player con ExoPlayer
  vlc,     // flutter_vlc_player
}