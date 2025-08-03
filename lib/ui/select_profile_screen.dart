import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/service_profile.dart';
import '../storage/profile_repository.dart';
import '../core/user_session.dart';

/// SelectProfileScreen para multi-perfil
/// Propósito: Permitir seleccionar entre perfiles guardados o crear uno nuevo
class SelectProfileScreen extends StatefulWidget {
  const SelectProfileScreen({super.key});

  @override
  State<SelectProfileScreen> createState() => _SelectProfileScreenState();
}

class _SelectProfileScreenState extends State<SelectProfileScreen> {
  List<ServiceProfile> _profiles = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfiles();
  }

  /// Cargar perfiles guardados
  Future<void> _loadProfiles() async {
    try {
      final profiles = await ProfileRepository().readProfiles();
      if (mounted) {
        setState(() {
          _profiles = profiles;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        _showErrorMessage('Error al cargar perfiles: ${e.toString()}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Selecciona perfil',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : _profiles.isEmpty
              ? _buildEmptyState()
              : _buildProfilesList(),
      // Botón flotante FAB "+ Nuevo"
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/login'),
        backgroundColor: Colors.blue.shade600,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Nuevo',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  /// Estado vacío cuando no hay perfiles
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.account_circle_outlined,
              size: 80,
              color: Colors.white.withOpacity(0.3),
            ),
            const SizedBox(height: 24),
            const Text(
              'No hay perfiles guardados',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Presiona el botón + para crear tu primer perfil IPTV',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () => context.go('/login'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade600,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                ),
                icon: const Icon(Icons.add),
                label: const Text(
                  'Crear perfil',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Lista vertical de perfiles guardados
  Widget _buildProfilesList() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Perfiles disponibles:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _profiles.length,
              itemBuilder: (context, index) {
                final profile = _profiles[index];
                return _buildProfileCard(profile, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Tarjeta por perfil con logo genérico, baseUrl y nombre de usuario
  Widget _buildProfileCard(ServiceProfile profile, int index) {
    return Card(
      color: const Color(0xFF161B22),
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () => _selectProfile(profile),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Logo genérico
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.blue.shade600,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(
                  Icons.live_tv,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              
              const SizedBox(width: 16),
              
              // Información del perfil
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nombre de usuario (negrita)
                    Text(
                      profile.username,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // baseUrl (en gris)
                    Text(
                      profile.baseUrl,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.7),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    // Motor preferido
                    Text(
                      'Motor: ${profile.preferredEngine ?? 'media3'}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Botones secundarios: editar y eliminar
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Botón editar (ícono "lápiz")
                  IconButton(
                    onPressed: () => _editProfile(profile, index),
                    icon: const Icon(
                      Icons.edit_outlined,
                      color: Colors.white70,
                      size: 20,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 48,
                      minHeight: 48,
                    ),
                  ),
                  // Botón eliminar (ícono "basura")
                  IconButton(
                    onPressed: () => _deleteProfile(profile, index),
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                      size: 20,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 48,
                      minHeight: 48,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Seleccionar perfil y navegar a TabHome
  Future<void> _selectProfile(ServiceProfile profile) async {
    try {
      // Verificar si el token necesita renovación
      final updatedProfile = await profile.refreshTokenIfNeeded();
      
      // Establecer como perfil activo
      await UserSession.setActiveProfile(profile.username);
      
      if (mounted) {
        context.go('/home');
      }
    } catch (e) {
      _showErrorMessage('Error al conectar con el perfil: ${e.toString()}');
    }
  }

  /// Editar perfil (por ahora solo mostrar mensaje)
  void _editProfile(ServiceProfile profile, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF161B22),
        title: const Text(
          'Editar perfil',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'Función de edición para ${profile.username} estará disponible próximamente.',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Entendido'),
          ),
        ],
      ),
    );
  }

  /// Eliminar perfil con confirmación
  Future<void> _deleteProfile(ServiceProfile profile, int index) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF161B22),
        title: const Text(
          'Eliminar perfil',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          '¿Estás seguro de que quieres eliminar el perfil "${profile.username}"?',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await ProfileRepository().deleteProfile(profile.username);
        
        if (mounted) {
          setState(() {
            _profiles.removeAt(index);
          });
          
          _showSuccessMessage('Perfil eliminado correctamente');
        }
      } catch (e) {
        _showErrorMessage('Error al eliminar perfil: ${e.toString()}');
      }
    }
  }

  /// Mostrar mensaje de error
  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Mostrar mensaje de éxito
  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}