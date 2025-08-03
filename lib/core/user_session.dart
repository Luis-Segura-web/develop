import 'package:shared_preferences/shared_preferences.dart';

/// Singleton para gestionar la sesión del usuario
class UserSession {
  static late SharedPreferences _prefs;
  static String? activeProfileId;
  
  /// Inicializar SharedPreferences y cargar perfil activo
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    activeProfileId = _prefs.getString('activeProfileId');
  }
  
  /// Establecer perfil activo
  static Future<void> setActiveProfile(String profileId) async {
    await _prefs.setString('activeProfileId', profileId);
    activeProfileId = profileId;
  }
  
  /// Limpiar sesión (logout)
  static Future<void> clearSession() async {
    await _prefs.remove('activeProfileId');
    activeProfileId = null;
  }
  
  /// Verificar si hay una sesión activa
  static bool get hasActiveSession => activeProfileId != null;
  
  /// Obtener perfil activo
  static String? get getActiveProfile => activeProfileId;
  
  /// Guardar datos del perfil
  static Future<void> saveProfileData(String profileId, Map<String, dynamic> profileData) async {
    final profileKey = 'profile_$profileId';
    final profileDataJson = profileData.map((key, value) => MapEntry(key, value.toString()));
    await _prefs.setString(profileKey, profileDataJson.toString());
  }
  
  /// Obtener datos del perfil
  static Map<String, dynamic>? getProfileData(String profileId) {
    final profileKey = 'profile_$profileId';
    final profileDataString = _prefs.getString(profileKey);
    if (profileDataString != null) {
      // Aquí podrías implementar parsing JSON más sofisticado
      return {'raw': profileDataString};
    }
    return null;
  }
  
  /// Obtener lista de perfiles guardados
  static List<String> getSavedProfiles() {
    final keys = _prefs.getKeys();
    return keys
        .where((key) => key.startsWith('profile_'))
        .map((key) => key.substring(8)) // Remover 'profile_' prefix
        .toList();
  }
  
  /// Eliminar perfil específico
  static Future<void> removeProfile(String profileId) async {
    final profileKey = 'profile_$profileId';
    await _prefs.remove(profileKey);
    
    // Si era el perfil activo, limpiar sesión
    if (activeProfileId == profileId) {
      await clearSession();
    }
  }
}