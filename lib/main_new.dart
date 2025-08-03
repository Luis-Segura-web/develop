import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme.dart';
import 'core/constants.dart';
import 'core/user_session.dart';
import 'l10n/app_localizations.dart';
import 'shared/models/server_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializar UserSession primero
  await UserSession.init();
  
  // Inicializar Hive
  await Hive.initFlutter();
  
  // Registrar adaptadores de Hive
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(ServerModelAdapter());
  }
  
  // Abrir cajas de Hive
  await Future.wait([
    Hive.openBox<ServerModel>(AppConstants.serversBoxName),
    Hive.openBox(AppConstants.favoritesBoxName),
    Hive.openBox(AppConstants.historyBoxName),
    Hive.openBox(AppConstants.settingsBoxName),
    Hive.openBox(AppConstants.cacheBoxName),
  ]);
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Detectar si hay perfil activo previamente
    final String? activeProfileId = UserSession.getActiveProfile;
    final String initialRoute = activeProfileId == null ? '/login' : '/tabHome';
    
    return MaterialApp(
      title: 'Reproductor IPTV',
      theme: AppTheme.darkTheme,
      initialRoute: initialRoute,
      routes: {
        '/login': (context) => const LoginScreen(),
        '/tabHome': (context) => const TabHomeScreen(),
      },
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es', ''),
      ],
      locale: const Locale('es', ''),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Pantalla de login con gestión de sesión
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _serverController = TextEditingController();
  final _portController = TextEditingController(text: '8080');
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _serverController.dispose();
    _portController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar Sesión'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.account_circle,
                  size: 80,
                  color: AppTheme.primaryColor,
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _serverController,
                  decoration: const InputDecoration(
                    labelText: 'URL del Servidor',
                    hintText: 'http://tu-servidor.com',
                    prefixIcon: Icon(Icons.link),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese la URL del servidor';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _portController,
                  decoration: const InputDecoration(
                    labelText: 'Puerto',
                    prefixIcon: Icon(Icons.settings_ethernet),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el puerto';
                    }
                    final port = int.tryParse(value);
                    if (port == null || port < 1 || port > 65535) {
                      return 'Puerto inválido (1-65535)';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Usuario',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese su usuario';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese su contraseña';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleLogin,
                    child: _isLoading
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text('Conectando...'),
                            ],
                          )
                        : const Text('Conectar'),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: _isLoading ? null : _showDemoDialog,
                  child: const Text('Probar Demo'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Manejar proceso de login
  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Obtener valores de los campos
      final server = _serverController.text.trim();
      final port = _portController.text.trim();
      final username = _usernameController.text.trim();
      final password = _passwordController.text.trim();

      // Construir URL completa
      String serverUrl = server;
      if (!server.startsWith('http://') && !server.startsWith('https://')) {
        serverUrl = 'http://$server';
      }
      if (port.isNotEmpty) {
        serverUrl = '$serverUrl:$port';
      }

      // Simular proceso de conexión
      await Future.delayed(const Duration(seconds: 2));

      // Validación básica de credenciales
      if (username.length >= 3 && password.length >= 3) {
        // Generar un ID de perfil único
        final profileId = '${username}_${DateTime.now().millisecondsSinceEpoch}';
        
        // Guardar datos del perfil
        final profileData = {
          'username': username,
          'serverUrl': serverUrl,
          'loginTime': DateTime.now().toIso8601String(),
        };
        await UserSession.saveProfileData(profileId, profileData);
        
        // Guardar el perfil activo
        await UserSession.setActiveProfile(profileId);
        
        if (mounted) {
          _showSuccessMessage('¡Conexión exitosa a $serverUrl!');
          Future.delayed(const Duration(seconds: 1), () {
            if (mounted) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/tabHome',
                (route) => false,
              );
            }
          });
        }
      } else {
        _showErrorMessage('Usuario y contraseña deben tener al menos 3 caracteres');
      }
    } catch (e) {
      _showErrorMessage('Error de conexión: ${e.toString()}');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  /// Mostrar diálogo de demo
  void _showDemoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Modo Demo'),
          content: const Text(
            'El modo demo te permite probar la aplicación con datos de ejemplo '
            'sin necesidad de una conexión real al servidor IPTV.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                // Generar ID de perfil demo
                final demoProfileId = 'demo_${DateTime.now().millisecondsSinceEpoch}';
                
                // Guardar datos del perfil demo
                final demoProfileData = {
                  'username': 'demo',
                  'serverUrl': 'demo.server.com',
                  'loginTime': DateTime.now().toIso8601String(),
                  'isDemo': 'true',
                };
                await UserSession.saveProfileData(demoProfileId, demoProfileData);
                await UserSession.setActiveProfile(demoProfileId);
                
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/tabHome',
                  (route) => false,
                );
              },
              child: const Text('Continuar'),
            ),
          ],
        );
      },
    );
  }

  /// Mostrar mensaje de éxito
  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// Mostrar mensaje de error
  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

// Página de Canales en Vivo
class ChannelsTab extends StatefulWidget {
  const ChannelsTab({super.key});

  @override
  State<ChannelsTab> createState() => _ChannelsTabState();
}

class _ChannelsTabState extends State<ChannelsTab> {
  @override
  void initState() {
    super.initState();
    // Cargar lista desde DB o fetch API si stale
    _loadChannels();
  }

  void _loadChannels() {
    // TODO: Implementar carga de canales
    // Por ahora mostrar contenido placeholder
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.live_tv, size: 64, color: AppTheme.primaryColor),
          SizedBox(height: 16),
          Text(
            'Canales en Vivo',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Aquí se mostrarán los canales de televisión en vivo',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

// Página de Películas (VOD)
class VodsTab extends StatefulWidget {
  const VodsTab({super.key});

  @override
  State<VodsTab> createState() => _VodsTabState();
}

class _VodsTabState extends State<VodsTab> {
  @override
  void initState() {
    super.initState();
    // Cargar lista desde DB o fetch API si stale
    _loadMovies();
  }

  void _loadMovies() {
    // TODO: Implementar carga de películas
    // Por ahora mostrar contenido placeholder
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.movie, size: 64, color: AppTheme.primaryColor),
          SizedBox(height: 16),
          Text(
            'Películas',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Aquí se mostrarán las películas disponibles',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

// Página de Series
class SeriesTab extends StatefulWidget {
  const SeriesTab({super.key});

  @override
  State<SeriesTab> createState() => _SeriesTabState();
}

class _SeriesTabState extends State<SeriesTab> {
  @override
  void initState() {
    super.initState();
    // Cargar lista desde DB o fetch API si stale
    _loadSeries();
  }

  void _loadSeries() {
    // TODO: Implementar carga de series
    // Por ahora mostrar contenido placeholder
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.tv, size: 64, color: AppTheme.primaryColor),
          SizedBox(height: 16),
          Text(
            'Series',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Aquí se mostrarán las series disponibles',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

// TabHomeScreen: Scaffold con BottomNavigation usando IndexedStack
class TabHomeScreen extends StatefulWidget {
  const TabHomeScreen({super.key});

  @override
  State<TabHomeScreen> createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHomeScreen> {
  int currentIndex = 0;
  
  final List<Widget> tabs = const [
    ChannelsTab(),
    VodsTab(), 
    SeriesTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reproductor IPTV'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                _handleLogout();
              } else if (value == 'switch_profile') {
                _showProfileSelector();
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'switch_profile',
                child: Row(
                  children: [
                    Icon(Icons.account_circle),
                    SizedBox(width: 8),
                    Text('Cambiar perfil'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 8),
                    Text('Cerrar sesión'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: IndexedStack(
        index: currentIndex,
        children: tabs,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.live_tv),
            label: 'Canales',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Películas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv),
            label: 'Series',
          ),
        ],
        onTap: (idx) => setState(() => currentIndex = idx),
      ),
    );
  }

  /// Manejar cierre de sesión
  Future<void> _handleLogout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cerrar sesión'),
          content: const Text('¿Estás seguro de que quieres cerrar sesión?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Cerrar sesión'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await UserSession.clearSession();
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/login',
          (route) => false,
        );
      }
    }
  }

  /// Mostrar selector de perfiles
  void _showProfileSelector() {
    final savedProfiles = UserSession.getSavedProfiles();
    final currentProfile = UserSession.getActiveProfile;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Seleccionar Perfil'),
          content: savedProfiles.isEmpty
              ? const Text('No hay perfiles guardados disponibles.')
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: savedProfiles.map((profileId) {
                    final isActive = profileId == currentProfile;
                    return ListTile(
                      leading: Icon(
                        Icons.account_circle,
                        color: isActive ? AppTheme.primaryColor : Colors.grey,
                      ),
                      title: Text(
                        profileId.contains('_') ? profileId.split('_')[0] : profileId,
                        style: TextStyle(
                          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                          color: isActive ? AppTheme.primaryColor : null,
                        ),
                      ),
                      subtitle: Text(isActive ? 'Perfil activo' : 'Toca para cambiar'),
                      onTap: isActive ? null : () => _switchToProfile(profileId),
                      trailing: isActive
                          ? const Icon(Icons.check, color: AppTheme.primaryColor)
                          : null,
                    );
                  }).toList(),
                ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            if (savedProfiles.isNotEmpty)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                    (route) => false,
                  );
                },
                child: const Text('Nuevo perfil'),
              ),
          ],
        );
      },
    );
  }

  /// Cambiar a perfil específico
  Future<void> _switchToProfile(String profileId) async {
    try {
      await UserSession.setActiveProfile(profileId);
      if (mounted) {
        Navigator.of(context).pop(); // Cerrar diálogo
        // Recargar la pantalla con el nuevo perfil
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/tabHome',
          (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        Navigator.of(context).pop(); // Cerrar diálogo
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al cambiar perfil: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
