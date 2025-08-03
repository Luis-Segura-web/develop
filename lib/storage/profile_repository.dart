import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/service_profile.dart';
import '../core/constants.dart';

/// Repositorio para gestionar perfiles de servicio usando Isar
class ProfileRepository {
  static Isar? _isar;
  
  /// Inicializar base de datos Isar
  static Future<void> initialize() async {
    if (_isar != null) return;
    
    final dir = await getApplicationDocumentsDirectory();
    
    _isar = await Isar.open(
      [ServiceProfileSchema],
      directory: dir.path,
      name: 'profiles_db',
    );
  }

  /// Obtener instancia de Isar
  static Isar get _instance {
    if (_isar == null) {
      throw Exception('ProfileRepository no inicializado. Llame a initialize() primero.');
    }
    return _isar!;
  }

  /// Leer todos los perfiles
  Future<List<ServiceProfile>> readProfiles() async {
    try {
      return await _instance.serviceProfiles.where().findAll();
    } catch (e) {
      throw Exception('Error al leer perfiles: $e');
    }
  }

  /// Guardar perfil
  Future<void> saveProfile(ServiceProfile profile) async {
    try {
      await _instance.writeTxn(() async {
        await _instance.serviceProfiles.put(profile);
      });
    } catch (e) {
      throw Exception('Error al guardar perfil: $e');
    }
  }

  /// Eliminar perfil
  Future<void> deleteProfile(int profileId) async {
    try {
      await _instance.writeTxn(() async {
        await _instance.serviceProfiles.delete(profileId);
      });
    } catch (e) {
      throw Exception('Error al eliminar perfil: $e');
    }
  }

  /// Buscar perfil por URL base
  Future<ServiceProfile?> findProfileByBaseUrl(String baseUrl) async {
    try {
      return await _instance.serviceProfiles
          .where()
          .baseUrlEqualTo(baseUrl)
          .findFirst();
    } catch (e) {
      throw Exception('Error al buscar perfil por URL: $e');
    }
  }

  /// Buscar perfil por ID
  Future<ServiceProfile?> findProfileById(int profileId) async {
    try {
      return await _instance.serviceProfiles.get(profileId);
    } catch (e) {
      throw Exception('Error al buscar perfil por ID: $e');
    }
  }

  /// Actualizar motor preferido de un perfil
  Future<void> setPreferredEngine(int profileId, PlayerEngine engine) async {
    try {
      final profile = await findProfileById(profileId);
      if (profile == null) {
        throw Exception('Perfil no encontrado');
      }
      
      final engineString = engine == PlayerEngine.vlc ? 'vlc' : 'media3';
      final updatedProfile = profile.copyWith(preferredEngine: engineString);
      await saveProfile(updatedProfile);
    } catch (e) {
      throw Exception('Error al actualizar motor preferido: $e');
    }
  }

  /// Actualizar token de un perfil
  Future<void> updateToken(int profileId, String token, DateTime expiry) async {
    try {
      final profile = await findProfileById(profileId);
      if (profile == null) {
        throw Exception('Perfil no encontrado');
      }
      
      final updatedProfile = profile.copyWith(
        token: token,
        tokenExpiry: expiry,
      );
      await saveProfile(updatedProfile);
    } catch (e) {
      throw Exception('Error al actualizar token: $e');
    }
  }

  /// Limpiar tokens expirados
  Future<void> cleanExpiredTokens() async {
    try {
      final profiles = await readProfiles();
      final now = DateTime.now();
      
      for (final profile in profiles) {
        if (profile.tokenExpiry != null && 
            profile.tokenExpiry!.isBefore(now)) {
          final cleanProfile = profile.copyWith(
            token: null,
            tokenExpiry: null,
          );
          await saveProfile(cleanProfile);
        }
      }
    } catch (e) {
      throw Exception('Error al limpiar tokens expirados: $e');
    }
  }

  /// Obtener perfiles que necesitan renovación de token
  Future<List<ServiceProfile>> getProfilesNeedingRefresh() async {
    try {
      final profiles = await readProfiles();
      return profiles.where((profile) => profile.needsTokenRefresh).toList();
    } catch (e) {
      throw Exception('Error al obtener perfiles que necesitan renovación: $e');
    }
  }

  /// Verificar si existe un perfil con la misma configuración
  Future<bool> profileExists(String baseUrl, String username) async {
    try {
      final existingProfile = await _instance.serviceProfiles
          .where()
          .baseUrlEqualTo(baseUrl)
          .findFirst();
      
      return existingProfile != null && existingProfile.username == username;
    } catch (e) {
      throw Exception('Error al verificar existencia de perfil: $e');
    }
  }

  /// Obtener estadísticas de perfiles
  Future<Map<String, int>> getProfileStats() async {
    try {
      final profiles = await readProfiles();
      final stats = <String, int>{};
      
      stats['total'] = profiles.length;
      stats['with_token'] = profiles.where((p) => p.token != null).length;
      stats['expired_tokens'] = profiles.where((p) => 
          p.tokenExpiry != null && 
          p.tokenExpiry!.isBefore(DateTime.now())
      ).length;
      stats['media3_engine'] = profiles.where((p) => 
          p.preferredEngine == 'media3'
      ).length;
      stats['vlc_engine'] = profiles.where((p) => 
          p.preferredEngine == 'vlc'
      ).length;
      
      return stats;
    } catch (e) {
      throw Exception('Error al obtener estadísticas: $e');
    }
  }

  /// Cerrar base de datos
  static Future<void> close() async {
    await _isar?.close();
    _isar = null;
  }

  /// Limpiar toda la base de datos (solo para testing)
  Future<void> clearAll() async {
    try {
      await _instance.writeTxn(() async {
        await _instance.serviceProfiles.clear();
      });
    } catch (e) {
      throw Exception('Error al limpiar base de datos: $e');
    }
  }
}