import 'package:flutter/material.dart';
import '../models/service_profile.dart';
import '../storage/profile_repository.dart';
import 'app_router.dart';

/// Pantalla de selección de perfiles
class SelectProfileScreen extends StatefulWidget {
  const SelectProfileScreen({super.key});

  @override
  State<SelectProfileScreen> createState() => _SelectProfileScreenState();
}

class _SelectProfileScreenState extends State<SelectProfileScreen> {
  final ProfileRepository _profileRepository = ProfileRepository();
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
      final profiles = await _profileRepository.readProfiles();
      setState(() {
        _profiles = profiles;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showErrorDialog('Error al cargar perfiles', e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(
        title: const Text('Seleccionar Perfil'),
        backgroundColor: const Color(0xFF161B22),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => AppRouter.navigateToLogin(context),
            tooltip: 'Agregar nuevo perfil',
          ),
        ],
      ),
      body: _isLoading ? _buildLoadingScreen() : _buildProfilesList(),
    );
  }

  /// Pantalla de carga
  Widget _buildLoadingScreen() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Colors.blue),
          SizedBox(height: 16),
          Text(
            'Cargando perfiles...',
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  /// Lista de perfiles
  Widget _buildProfilesList() {
    if (_profiles.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _profiles.length,
      itemBuilder: (context, index) {
        final profile = _profiles[index];
        return _buildProfileCard(profile);
      },
    );
  }

  /// Estado vacío
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.account_circle_outlined,
              size: 80,
              color: Colors.white30,
            ),
            const SizedBox(height: 16),
            const Text(
              'No hay perfiles configurados',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Agregue un nuevo perfil para comenzar',
              style: TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => AppRouter.navigateToLogin(context),
              icon: const Icon(Icons.add),
              label: const Text('Agregar Perfil'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade600,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Tarjeta de perfil
  Widget _buildProfileCard(ServiceProfile profile) {
    return Card(
      color: const Color(0xFF161B22),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blue.shade600,
              child: Text(
                profile.username[0].toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            const SizedBox(width: 16),
            
            // Información del perfil
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile.username,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    profile.baseUrl,
                    style: const TextStyle(color: Colors.white70),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildStatusChip(profile),
                      const SizedBox(width: 8),
                      _buildEngineChip(profile),
                    ],
                  ),
                ],
              ),
            ),
            
            // Acciones
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.play_arrow, color: Colors.green),
                  onPressed: () => _selectProfile(profile),
                  tooltip: 'Seleccionar perfil',
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _confirmDeleteProfile(profile),
                  tooltip: 'Eliminar perfil',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Chip de estado del perfil
  Widget _buildStatusChip(ServiceProfile profile) {
    final needsRefresh = profile.needsTokenRefresh;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: needsRefresh ? Colors.orange.shade600 : Colors.green.shade600,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        needsRefresh ? 'Token expirado' : 'Activo',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// Chip de motor de reproducción
  Widget _buildEngineChip(ServiceProfile profile) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue.shade600,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            profile.preferredEngine == PlayerEngine.media3
                ? Icons.video_library
                : Icons.play_circle,
            color: Colors.white,
            size: 14,
          ),
          const SizedBox(width: 4),
          Text(
            profile.preferredEngine.name.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  /// Seleccionar perfil
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

  /// Confirmar eliminación de perfil
  void _confirmDeleteProfile(ServiceProfile profile) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Perfil'),
        content: Text(
          '¿Está seguro de que desea eliminar el perfil "${profile.username}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _deleteProfile(profile);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  /// Eliminar perfil
  Future<void> _deleteProfile(ServiceProfile profile) async {
    try {
      await _profileRepository.deleteProfile(profile.id);
      await _loadProfiles(); // Recargar lista
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Perfil eliminado correctamente'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      _showErrorDialog('Error al eliminar perfil', e.toString());
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