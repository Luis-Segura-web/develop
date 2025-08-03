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
}