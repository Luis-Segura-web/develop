import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'core/theme.dart';
import 'core/constants.dart';
import 'core/user_session.dart';
import 'l10n/app_localizations.dart';
import 'shared/models/server_model.dart';
import 'ui/splash_screen.dart';
import 'ui/login_screen.dart';
import 'ui/select_profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializar UserSession primero
  await UserSession.init();
  
  // Inicializar Hive
  await Hive.initFlutter();
  
  // Abrir cajas de Hive
  await Future.wait([
    Hive.openBox(AppConstants.serversBoxName),
    Hive.openBox(AppConstants.favoritesBoxName),
    Hive.openBox(AppConstants.historyBoxName),
    Hive.openBox(AppConstants.settingsBoxName),
    Hive.openBox(AppConstants.cacheBoxName),
  ]);
  
  runApp(MyApp());
}

// Definir router global con manejo completo de navegación
final GoRouter _router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/select-profile',
      builder: (context, state) => const SelectProfileScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const TabHomeScreen(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Reproductor IPTV',
      theme: AppTheme.darkTheme,
      routerConfig: _router,
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

// TabHomeScreen: Scaffold con BottomNavigation usando IndexedStack (3-5 destinos según especificación)
class TabHomeScreen extends StatefulWidget {
  const TabHomeScreen({super.key});

  @override
  State<TabHomeScreen> createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHomeScreen> {
  int currentIndex = 0;
  
  final List<Widget> tabs = [
    const ChannelsTab(),
    const VodsTab(), 
    const SeriesTab(),
    const FavoritesTab(),
    const SettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reproductor IPTV',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFF0D1117),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // TODO: Implementar SearchScreen
              _showComingSoon('Búsqueda global');
            },
            constraints: const BoxConstraints(
              minWidth: 48,
              minHeight: 48,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              _refreshCurrentTab();
            },
            constraints: const BoxConstraints(
              minWidth: 48,
              minHeight: 48,
            ),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            color: const Color(0xFF161B22),
            onSelected: (value) {
              _handleMenuAction(value);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'profiles',
                child: Row(
                  children: [
                    Icon(Icons.account_circle, color: Colors.white70),
                    SizedBox(width: 12),
                    Text('Cambiar perfil', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.red),
                    SizedBox(width: 12),
                    Text('Cerrar sesión', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: const Color(0xFF0D1117),
      body: IndexedStack(
        index: currentIndex,
        children: tabs,
      ),
      // BottomNavigationBar con 5 destinos según especificación (máximo recomendado)
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF161B22),
        currentIndex: currentIndex,
        onTap: (idx) => setState(() => currentIndex = idx),
        selectedItemColor: Colors.blue.shade400,
        unselectedItemColor: Colors.white54,
        selectedFontSize: 12,
        unselectedFontSize: 12,
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
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ajustes',
          ),
        ],
      ),
    );
  }

  /// Refrescar contenido de la pestaña actual
  void _refreshCurrentTab() {
    switch (currentIndex) {
      case 0:
        _showMessage('Actualizando canales...');
        break;
      case 1:
        _showMessage('Actualizando películas...');
        break;
      case 2:
        _showMessage('Actualizando series...');
        break;
      case 3:
        _showMessage('Actualizando favoritos...');
        break;
      case 4:
        _showMessage('Configuración actualizada');
        break;
    }
  }

  /// Manejar acciones del menú
  void _handleMenuAction(String action) {
    switch (action) {
      case 'profiles':
        context.go('/select-profile');
        break;
      case 'logout':
        _handleLogout();
        break;
    }
  }

  /// Manejar cierre de sesión
  Future<void> _handleLogout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF161B22),
        title: const Text('Cerrar Sesión', style: TextStyle(color: Colors.white)),
        content: const Text(
          '¿Estás seguro de que quieres cerrar sesión?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Cerrar Sesión'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await UserSession.clearSession();
      if (mounted) {
        context.go('/login');
      }
    }
  }

  /// Mostrar mensaje temporal
  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.blue.shade600,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// Mostrar mensaje "próximamente"
  void _showComingSoon(String feature) {
    _showMessage('$feature estará disponible próximamente');
  }
}

// ChannelsTab: Lista de canales en vivo con skeleton placeholders
class ChannelsTab extends StatefulWidget {
  const ChannelsTab({super.key});

  @override
  State<ChannelsTab> createState() => _ChannelsTabState();
}

class _ChannelsTabState extends State<ChannelsTab> {
  bool _isLoading = true;
  List<Map<String, String>> _channels = [];

  @override
  void initState() {
    super.initState();
    _loadChannels();
  }

  Future<void> _loadChannels() async {
    // Simular carga de datos
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      setState(() {
        _channels = List.generate(20, (index) => {
          'name': 'Canal ${index + 1}',
          'logo': 'https://via.placeholder.com/60',
          'category': index % 3 == 0 ? 'Noticias' : index % 3 == 1 ? 'Entretenimiento' : 'Deportes',
        });
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Barra de búsqueda/filtro opcional
        Container(
          padding: const EdgeInsets.all(16),
          child: TextField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Buscar canales...',
              hintStyle: const TextStyle(color: Colors.white54),
              prefixIcon: const Icon(Icons.search, color: Colors.white54),
              filled: true,
              fillColor: const Color(0xFF161B22),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        
        // Cuerpo: ListView.lazy paginada
        Expanded(
          child: _isLoading 
              ? _buildSkeletonList()
              : _buildChannelsList(),
        ),
      ],
    );
  }

  /// Lista de canales
  Widget _buildChannelsList() {
    return RefreshIndicator(
      onRefresh: _loadChannels,
      child: ListView.builder(
        itemCount: _channels.length,
        itemBuilder: (context, index) {
          final channel = _channels[index];
          return _buildChannelTile(channel);
        },
      ),
    );
  }

  /// Tile de canal con logo, nombre e indicador de en vivo
  Widget _buildChannelTile(Map<String, String> channel) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.blue.shade600,
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Icon(
          Icons.live_tv,
          color: Colors.white,
          size: 30,
        ),
      ),
      title: Text(
        channel['name']!,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'EN VIVO • ${channel['category']}',
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 12,
            ),
          ),
        ],
      ),
      trailing: IconButton(
        onPressed: () => _playChannel(channel),
        icon: const Icon(
          Icons.play_circle_fill,
          color: Colors.blue,
          size: 32,
        ),
        constraints: const BoxConstraints(
          minWidth: 48,
          minHeight: 48,
        ),
      ),
      onTap: () => _playChannel(channel),
    );
  }

  /// Skeleton placeholder mientras carga
  Widget _buildSkeletonList() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          title: Container(
            height: 16,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          subtitle: Container(
            height: 12,
            width: 120,
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          trailing: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        );
      },
    );
  }

  /// Reproducir canal
  void _playChannel(Map<String, String> channel) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reproduciendo ${channel['name']}'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

// VodsTab: Películas on-demand con GridView
class VodsTab extends StatefulWidget {
  const VodsTab({super.key});

  @override
  State<VodsTab> createState() => _VodsTabState();
}

class _VodsTabState extends State<VodsTab> {
  bool _isLoading = true;
  List<Map<String, String>> _movies = [];

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      setState(() {
        _movies = List.generate(12, (index) => {
          'title': 'Película ${index + 1}',
          'poster': 'https://via.placeholder.com/300x450',
          'year': '${2020 + (index % 5)}',
          'genre': index % 3 == 0 ? 'Acción' : index % 3 == 1 ? 'Drama' : 'Comedia',
        });
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Encabezado opcional con búsqueda
        Container(
          padding: const EdgeInsets.all(16),
          child: TextField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Buscar películas...',
              hintStyle: const TextStyle(color: Colors.white54),
              prefixIcon: const Icon(Icons.search, color: Colors.white54),
              filled: true,
              fillColor: const Color(0xFF161B22),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        
        // Grid de películas
        Expanded(
          child: _isLoading 
              ? _buildSkeletonGrid()
              : _buildMoviesGrid(),
        ),
      ],
    );
  }

  /// Grid de películas
  Widget _buildMoviesGrid() {
    return RefreshIndicator(
      onRefresh: _loadMovies,
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7, // Ratio 2:3 para posters
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: _movies.length,
        itemBuilder: (context, index) {
          final movie = _movies[index];
          return _buildMovieCard(movie);
        },
      ),
    );
  }

  /// Tarjeta de película
  Widget _buildMovieCard(Map<String, String> movie) {
    return Card(
      color: const Color(0xFF161B22),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => _playMovie(movie),
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen carátula (poster 2:3 ratio)
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue.shade600,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                ),
                child: const Icon(
                  Icons.movie,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
            
            // Información
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título (negrita 16sp)
                  Text(
                    movie['title']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // Año y género
                  Text(
                    '${movie['year']} • ${movie['genre']}',
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Skeleton grid placeholder
  Widget _buildSkeletonGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: 8,
      itemBuilder: (context, index) {
        return Card(
          color: const Color(0xFF161B22),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Container(
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 12,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Reproducir película
  void _playMovie(Map<String, String> movie) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reproduciendo ${movie['title']}'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

// SeriesTab: Idéntica a VodsTab pero para series
class SeriesTab extends StatefulWidget {
  const SeriesTab({super.key});

  @override
  State<SeriesTab> createState() => _SeriesTabState();
}

class _SeriesTabState extends State<SeriesTab> {
  bool _isLoading = true;
  List<Map<String, String>> _series = [];

  @override
  void initState() {
    super.initState();
    _loadSeries();
  }

  Future<void> _loadSeries() async {
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      setState(() {
        _series = List.generate(10, (index) => {
          'title': 'Serie ${index + 1}',
          'poster': 'https://via.placeholder.com/300x450',
          'seasons': '${(index % 5) + 1}',
          'genre': index % 3 == 0 ? 'Drama' : index % 3 == 1 ? 'Comedia' : 'Thriller',
        });
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: TextField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Buscar series...',
              hintStyle: const TextStyle(color: Colors.white54),
              prefixIcon: const Icon(Icons.search, color: Colors.white54),
              filled: true,
              fillColor: const Color(0xFF161B22),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        
        Expanded(
          child: _isLoading 
              ? _buildSkeletonGrid()
              : _buildSeriesGrid(),
        ),
      ],
    );
  }

  Widget _buildSeriesGrid() {
    return RefreshIndicator(
      onRefresh: _loadSeries,
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: _series.length,
        itemBuilder: (context, index) {
          final serie = _series[index];
          return _buildSerieCard(serie);
        },
      ),
    );
  }

  Widget _buildSerieCard(Map<String, String> serie) {
    return Card(
      color: const Color(0xFF161B22),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => _showSerieDetail(serie),
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.purple.shade600,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                ),
                child: const Icon(
                  Icons.tv,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    serie['title']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${serie['seasons']} temporadas • ${serie['genre']}',
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkeletonGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: 8,
      itemBuilder: (context, index) {
        return Card(
          color: const Color(0xFF161B22),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Container(
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 12,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSerieDetail(Map<String, String> serie) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF161B22),
        title: Text(
          serie['title']!,
          style: const TextStyle(color: Colors.white),
        ),
        content: Text(
          'Detalle de la serie con ${serie['seasons']} temporadas.\n\nFuncionalidad de detalle con episodios estará disponible próximamente.',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cerrar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Reproduciendo ${serie['title']}'),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text('Ver ahora'),
          ),
        ],
      ),
    );
  }
}

// FavoritesTab: Tab opcional según especificación
class FavoritesTab extends StatelessWidget {
  const FavoritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_outline,
            size: 80,
            color: Colors.white30,
          ),
          SizedBox(height: 24),
          Text(
            'Favoritos',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Tus contenidos favoritos aparecerán aquí',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white54,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// SettingsTab: Configuración según especificación
class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  bool _darkMode = true;
  String _defaultEngine = 'media3';
  double _cacheLimit = 500;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Configuración',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Modo oscuro
        Card(
          color: const Color(0xFF161B22),
          child: SwitchListTile(
            title: const Text(
              'Modo oscuro',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: const Text(
              'Tema oscuro para la aplicación',
              style: TextStyle(color: Colors.white54),
            ),
            value: _darkMode,
            onChanged: (value) {
              setState(() {
                _darkMode = value;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(_darkMode ? 'Modo oscuro activado' : 'Modo claro activado'),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
        ),
        
        const SizedBox(height: 12),
        
        // Motor predeterminado
        Card(
          color: const Color(0xFF161B22),
          child: ListTile(
            title: const Text(
              'Motor predeterminado',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              _defaultEngine == 'media3' ? 'Media3 (Recomendado)' : 'VLC Player',
              style: const TextStyle(color: Colors.white54),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54),
            onTap: () {
              _showEngineSelector();
            },
          ),
        ),
        
        const SizedBox(height: 12),
        
        // Límite cache vídeo
        Card(
          color: const Color(0xFF161B22),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Límite cache vídeo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${_cacheLimit.toInt()} MB',
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 14,
                  ),
                ),
                Slider(
                  value: _cacheLimit,
                  min: 100,
                  max: 2000,
                  divisions: 19,
                  onChanged: (value) {
                    setState(() {
                      _cacheLimit = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 12),
        
        // Limpiar cache
        Card(
          color: const Color(0xFF161B22),
          child: ListTile(
            title: const Text(
              'Limpiar cache & datos',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: const Text(
              'Borrar datos en caché',
              style: TextStyle(color: Colors.white54),
            ),
            trailing: const Icon(Icons.delete_outline, color: Colors.orange),
            onTap: () {
              _showClearCacheDialog();
            },
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Cerrar sesión
        SizedBox(
          height: 52,
          child: ElevatedButton.icon(
            onPressed: () {
              _showLogoutDialog();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.logout),
            label: const Text(
              'Cerrar sesión',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showEngineSelector() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF161B22),
        title: const Text(
          'Motor de reproducción',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text(
                'Media3 (Recomendado)',
                style: TextStyle(color: Colors.white),
              ),
              value: 'media3',
              groupValue: _defaultEngine,
              onChanged: (value) {
                setState(() {
                  _defaultEngine = value!;
                });
                Navigator.of(context).pop();
              },
            ),
            RadioListTile<String>(
              title: const Text(
                'VLC Player',
                style: TextStyle(color: Colors.white),
              ),
              value: 'vlc',
              groupValue: _defaultEngine,
              onChanged: (value) {
                setState(() {
                  _defaultEngine = value!;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showClearCacheDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF161B22),
        title: const Text(
          'Limpiar cache',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          '¿Estás seguro de que quieres limpiar todos los datos en caché?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Cache limpia'),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: const Text('Limpiar'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF161B22),
        title: const Text(
          'Cerrar sesión',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          '¿Estás seguro de que quieres cerrar sesión?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await UserSession.clearSession();
              if (context.mounted) {
                context.go('/login');
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Cerrar sesión'),
          ),
        ],
      ),
    );
  }
}
