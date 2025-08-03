import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/user_session.dart';

/// SplashScreen (pantalla de arranque)
/// Propósito: marcar con marca mientras se validan credenciales/auto-login.
/// Visible máximo: 1s para evitar percepción de lentitud
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  /// Inicializar aplicación y navegación
  Future<void> _initializeApp() async {
    // Inicializar UserSession si no está inicializado
    await UserSession.init();
    
    // Simular tiempo mínimo de splash (1 segundo)
    await Future.delayed(const Duration(seconds: 1));
    
    if (!mounted) return;
    
    // Verificar si hay perfil activo
    final activeProfile = UserSession.getActiveProfile;
    
    if (activeProfile != null) {
      // Usuario ya logueado, ir a TabHome
      context.go('/home');
    } else {
      // No hay sesión, ir a Login
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117), // Fondo oscuro
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logotipo centrado (150-200 dp)
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.blue.shade600,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Icon(
                Icons.live_tv,
                size: 80,
                color: Colors.white,
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Título de la app
            const Text(
              'Reproductor IPTV',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Subtítulo
            const Text(
              'Cargando...',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Barra de progreso spinner pequeño
            SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.blue.shade600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}