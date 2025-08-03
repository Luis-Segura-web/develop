import 'package:flutter/material.dart';
import '../models/service_profile.dart';
import '../models/stream_item.dart';
import 'player_screen.dart';
import 'login_screen.dart';
import 'select_profile_screen.dart';
import 'categories_screen.dart';
import 'streams_list_screen.dart';

/// Router principal de la aplicación IPTV
class AppRouter {
  static const String login = '/login';
  static const String profiles = '/profiles';
  static const String categories = '/categories';
  static const String streams = '/streams';
  static const String player = '/player';

  /// Generar rutas de la aplicación
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: settings,
        );

      case profiles:
        return MaterialPageRoute(
          builder: (_) => const SelectProfileScreen(),
          settings: settings,
        );

      case categories:
        final args = settings.arguments as Map<String, dynamic>?;
        final profile = args?['profile'] as ServiceProfile?;
        
        if (profile == null) {
          return _errorRoute('Perfil requerido para ver categorías');
        }
        
        return MaterialPageRoute(
          builder: (_) => CategoriesScreen(serviceProfile: profile),
          settings: settings,
        );

      case streams:
        final args = settings.arguments as Map<String, dynamic>?;
        final profile = args?['profile'] as ServiceProfile?;
        final categoryId = args?['categoryId'] as int?;
        final categoryName = args?['categoryName'] as String?;
        final streamType = args?['streamType'] as String?;
        
        if (profile == null || categoryId == null) {
          return _errorRoute('Perfil y categoría requeridos para ver streams');
        }
        
        return MaterialPageRoute(
          builder: (_) => StreamsListScreen(
            serviceProfile: profile,
            categoryId: categoryId,
            categoryName: categoryName ?? 'Sin nombre',
            streamType: streamType ?? 'live',
          ),
          settings: settings,
        );

      case player:
        final args = settings.arguments as Map<String, dynamic>?;
        final profile = args?['profile'] as ServiceProfile?;
        final streamItem = args?['streamItem'] as StreamItem?;
        
        if (profile == null || streamItem == null) {
          return _errorRoute('Perfil y stream requeridos para reproducir');
        }
        
        return MaterialPageRoute(
          builder: (_) => PlayerScreen(
            serviceProfile: profile,
            streamItem: streamItem,
          ),
          settings: settings,
        );

      default:
        return _errorRoute('Ruta no encontrada: ${settings.name}');
    }
  }

  /// Ruta de error
  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.red,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Error de navegación',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Navigator.of(_).pushNamedAndRemoveUntil(
                    login,
                    (route) => false,
                  ),
                  child: const Text('Volver al inicio'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Navegar a pantalla de login
  static void navigateToLogin(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      login,
      (route) => false,
    );
  }

  /// Navegar a selección de perfiles
  static void navigateToProfiles(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      profiles,
      (route) => false,
    );
  }

  /// Navegar a categorías
  static void navigateToCategories(BuildContext context, ServiceProfile profile) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      categories,
      (route) => false,
      arguments: {'profile': profile},
    );
  }

  /// Navegar a lista de streams
  static void navigateToStreams(
    BuildContext context, {
    required ServiceProfile profile,
    required int categoryId,
    required String categoryName,
    required String streamType,
  }) {
    Navigator.of(context).pushNamed(
      streams,
      arguments: {
        'profile': profile,
        'categoryId': categoryId,
        'categoryName': categoryName,
        'streamType': streamType,
      },
    );
  }

  /// Navegar al reproductor
  static void navigateToPlayer(
    BuildContext context, {
    required ServiceProfile profile,
    required StreamItem streamItem,
  }) {
    Navigator.of(context).pushNamed(
      player,
      arguments: {
        'profile': profile,
        'streamItem': streamItem,
      },
    );
  }

  /// Verificar si una ruta existe
  static bool isValidRoute(String routeName) {
    return [login, profiles, categories, streams, player].contains(routeName);
  }

  /// Obtener ruta inicial según estado de la aplicación
  static String getInitialRoute() {
    // Implementar lógica para determinar ruta inicial
    // Verificar si hay perfiles guardados usando SharedPreferences
    return _checkUserState();
  }

  /// Verificar estado del usuario y determinar ruta inicial
  static String _checkUserState() {
    // En una implementación completa, aquí verificaríamos:
    // 1. Si hay perfiles de servidor guardados
    // 2. Si hay un usuario logueado recientemente
    // 3. Si hay configuración de auto-login
    
    // Por ahora, siempre dirigir al login para nuevo setup
    // En el futuro esto podría verificar SharedPreferences o Hive
    return login;
  }
}