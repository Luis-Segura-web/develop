import 'package:flutter/material.dart';
import '../models/service_profile.dart';
import '../services/xtream_service.dart';
import 'app_router.dart';

/// Pantalla de categorías de contenido
class CategoriesScreen extends StatefulWidget {
  final ServiceProfile serviceProfile;

  const CategoriesScreen({
    super.key,
    required this.serviceProfile,
  });

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final XtreamService _xtreamService = XtreamService();
  
  List<Map<String, dynamic>> _liveCategories = [];
  List<Map<String, dynamic>> _vodCategories = [];
  List<Map<String, dynamic>> _seriesCategories = [];
  
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _initializeService();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _xtreamService.dispose();
    super.dispose();
  }

  /// Inicializar servicio y cargar categorías
  Future<void> _initializeService() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      await _xtreamService.initialize(widget.serviceProfile);
      await _loadAllCategories();

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
    }
  }

  /// Cargar todas las categorías
  Future<void> _loadAllCategories() async {
    final futures = await Future.wait([
      _xtreamService.fetchLiveCategories(),
      _xtreamService.fetchVodCategories(),
      _xtreamService.fetchSeriesCategories(),
    ]);

    setState(() {
      _liveCategories = futures[0];
      _vodCategories = futures[1];
      _seriesCategories = futures[2];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: _buildAppBar(),
      body: _isLoading ? _buildLoadingScreen() : _buildCategoriesContent(),
    );
  }

  /// Construir barra de aplicación
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF161B22),
      foregroundColor: Colors.white,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Categorías', style: TextStyle(fontSize: 18)),
          Text(
            widget.serviceProfile.username,
            style: const TextStyle(fontSize: 12, color: Colors.white70),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: _initializeService,
          tooltip: 'Actualizar',
        ),
        IconButton(
          icon: const Icon(Icons.account_circle),
          onPressed: () => AppRouter.navigateToProfiles(context),
          tooltip: 'Cambiar perfil',
        ),
      ],
      bottom: _errorMessage == null
          ? TabBar(
              controller: _tabController,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              indicatorColor: Colors.blue.shade400,
              tabs: const [
                Tab(
                  icon: Icon(Icons.live_tv),
                  text: 'En Vivo',
                ),
                Tab(
                  icon: Icon(Icons.movie),
                  text: 'Películas',
                ),
                Tab(
                  icon: Icon(Icons.tv),
                  text: 'Series',
                ),
              ],
            )
          : null,
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
            'Cargando categorías...',
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  /// Contenido de categorías
  Widget _buildCategoriesContent() {
    if (_errorMessage != null) {
      return _buildErrorScreen();
    }

    return TabBarView(
      controller: _tabController,
      children: [
        _buildCategoryList(_liveCategories, 'live'),
        _buildCategoryList(_vodCategories, 'vod'),
        _buildCategoryList(_seriesCategories, 'series'),
      ],
    );
  }

  /// Lista de categorías
  Widget _buildCategoryList(List<Map<String, dynamic>> categories, String type) {
    if (categories.isEmpty) {
      return _buildEmptyState(type);
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return _buildCategoryCard(category, type);
      },
    );
  }

  /// Estado vacío
  Widget _buildEmptyState(String type) {
    String message;
    IconData icon;

    switch (type) {
      case 'live':
        message = 'No hay categorías de canales en vivo';
        icon = Icons.live_tv;
        break;
      case 'vod':
        message = 'No hay categorías de películas';
        icon = Icons.movie;
        break;
      case 'series':
        message = 'No hay categorías de series';
        icon = Icons.tv;
        break;
      default:
        message = 'No hay categorías disponibles';
        icon = Icons.category;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: Colors.white30),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Tarjeta de categoría
  Widget _buildCategoryCard(Map<String, dynamic> category, String type) {
    final categoryId = int.parse(category['category_id'].toString());
    final categoryName = category['category_name'] as String;

    return Card(
      color: const Color(0xFF161B22),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: _buildCategoryIcon(type),
        title: Text(
          categoryName,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          _getCategoryDescription(type),
          style: const TextStyle(color: Colors.white70),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.white70,
          size: 16,
        ),
        onTap: () => _navigateToStreams(categoryId, categoryName, type),
      ),
    );
  }

  /// Icono de categoría
  Widget _buildCategoryIcon(String type) {
    IconData icon;
    Color color;

    switch (type) {
      case 'live':
        icon = Icons.live_tv;
        color = Colors.red.shade400;
        break;
      case 'vod':
        icon = Icons.movie;
        color = Colors.blue.shade400;
        break;
      case 'series':
        icon = Icons.tv;
        color = Colors.green.shade400;
        break;
      default:
        icon = Icons.category;
        color = Colors.grey.shade400;
    }

    return CircleAvatar(
      backgroundColor: color.withOpacity(0.2),
      child: Icon(icon, color: color),
    );
  }

  /// Descripción de categoría
  String _getCategoryDescription(String type) {
    switch (type) {
      case 'live':
        return 'Canales de televisión en vivo';
      case 'vod':
        return 'Películas bajo demanda';
      case 'series':
        return 'Series de televisión';
      default:
        return 'Contenido multimedia';
    }
  }

  /// Navegar a lista de streams
  void _navigateToStreams(int categoryId, String categoryName, String type) {
    AppRouter.navigateToStreams(
      context,
      profile: widget.serviceProfile,
      categoryId: categoryId,
      categoryName: categoryName,
      streamType: type,
    );
  }

  /// Pantalla de error
  Widget _buildErrorScreen() {
    return Center(
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
              'Error al cargar categorías',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _errorMessage!,
              style: const TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _initializeService,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reintentar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade600,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => AppRouter.navigateToProfiles(context),
                  icon: const Icon(Icons.account_circle),
                  label: const Text('Cambiar perfil'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade600,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}