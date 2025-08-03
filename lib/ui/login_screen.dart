import 'package:flutter/material.dart';
import '../models/service_profile.dart';
import '../storage/profile_repository.dart';
import 'app_router.dart';

/// Pantalla de inicio de sesión
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _baseUrlController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  
  bool _isLoading = false;
  PlayerEngine _selectedEngine = PlayerEngine.media3;

  @override
  void dispose() {
    _baseUrlController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              _buildHeader(),
              const SizedBox(height: 40),
              _buildLoginForm(),
              const SizedBox(height: 20),
              _buildProfilesList(),
            ],
          ),
        ),
      ),
    );
  }

  /// Construir encabezado
  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.blue.shade600,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(
            Icons.live_tv,
            size: 40,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Reproductor IPTV',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const Text(
          'Conecte con su servidor Xtream Codes',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  /// Construir formulario de login
  Widget _buildLoginForm() {
    return Card(
      color: const Color(0xFF161B22),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Nuevo Perfil',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              
              // URL del servidor
              TextFormField(
                controller: _baseUrlController,
                decoration: const InputDecoration(
                  labelText: 'URL del Servidor',
                  hintText: 'http://servidor.com:8080',
                  prefixIcon: Icon(Icons.link),
                ),
                keyboardType: TextInputType.url,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la URL del servidor';
                  }
                  if (!value.startsWith('http')) {
                    return 'La URL debe comenzar con http:// o https://';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              // Usuario
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Usuario',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su usuario';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              // Contraseña
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su contraseña';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              // Selector de motor
              DropdownButtonFormField<PlayerEngine>(
                value: _selectedEngine,
                decoration: const InputDecoration(
                  labelText: 'Motor de Reproducción',
                  prefixIcon: Icon(Icons.play_circle),
                ),
                items: PlayerEngine.values.map((engine) {
                  return DropdownMenuItem(
                    value: engine,
                    child: Text(_getEngineDisplayName(engine)),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedEngine = value;
                    });
                  }
                },
              ),
              
              const SizedBox(height: 24),
              
              // Botón de conexión
              ElevatedButton(
                onPressed: _isLoading ? null : _connectProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade600,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'Conectar',
                        style: TextStyle(fontSize: 16),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Construir lista de perfiles guardados
  Widget _buildProfilesList() {
    return FutureBuilder<List<ServiceProfile>>(
      future: ProfileRepository().readProfiles(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SizedBox.shrink();
        }

        return Card(
          color: const Color(0xFF161B22),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Perfiles Guardados',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                ...snapshot.data!.map((profile) => _buildProfileTile(profile)),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Construir elemento de perfil
  Widget _buildProfileTile(ServiceProfile profile) {
    return Card(
      color: const Color(0xFF21262D),
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade600,
          child: Text(
            profile.username[0].toUpperCase(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(
          profile.username,
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          profile.baseUrl,
          style: const TextStyle(color: Colors.white70),
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              profile.preferredEngine == PlayerEngine.media3
                  ? Icons.video_library
                  : Icons.play_circle,
              color: Colors.white70,
              size: 20,
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white70,
              size: 16,
            ),
          ],
        ),
        onTap: () => _selectProfile(profile),
      ),
    );
  }

  /// Obtener nombre legible del motor
  String _getEngineDisplayName(PlayerEngine engine) {
    switch (engine) {
      case PlayerEngine.media3:
        return 'Media3 (Recomendado)';
      case PlayerEngine.vlc:
        return 'VLC Player';
    }
  }

  /// Conectar nuevo perfil
  Future<void> _connectProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final profile = ServiceProfile(
        baseUrl: _baseUrlController.text.trim(),
        username: _usernameController.text.trim(),
        password: _passwordController.text.trim(),
        preferredEngine: _selectedEngine,
      );

      // Guardar perfil
      await ProfileRepository().saveProfile(profile);

      // Navegar a categorías
      if (mounted) {
        AppRouter.navigateToCategories(context, profile);
      }
    } catch (e) {
      _showErrorDialog('Error de conexión', e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// Seleccionar perfil existente
  Future<void> _selectProfile(ServiceProfile profile) async {
    try {
      // Verificar si el token necesita renovación
      final updatedProfile = await profile.refreshTokenIfNeeded();
      
      if (mounted) {
        AppRouter.navigateToCategories(context, updatedProfile);
      }
    } catch (e) {
      _showErrorDialog('Error al conectar', e.toString());
    }
  }

  /// Mostrar diálogo de error
  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}