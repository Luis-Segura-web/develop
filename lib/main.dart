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
import 'features/iptv/bloc/content_loader_bloc.dart';
import 'features/iptv/bloc/content_bloc.dart';
import 'features/iptv/bloc/content_event.dart';
import 'features/iptv/bloc/content_state.dart';
import 'models/channel.dart';
import 'models/vod_item.dart';
import 'models/series_item.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<ContentLoaderBloc>(
          create: (context) => ContentLoaderBloc(),
        ),
        BlocProvider<ChannelsBloc>(
          create: (context) => ChannelsBloc(),
        ),
        BlocProvider<VodBloc>(
          create: (context) => VodBloc(),
        ),
        BlocProvider<SeriesBloc>(
          create: (context) => SeriesBloc(),
        ),
      ],
      child: MaterialApp.router(
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
      ),
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
  void initState() {
    super.initState();
    // Cargar contenido inicial al entrar a la pantalla principal
    _loadInitialContent();
  }

  /// Cargar contenido inicial desde las APIs
  void _loadInitialContent() {
    final contentLoaderBloc = context.read<ContentLoaderBloc>();
    contentLoaderBloc.add(LoadInitialContent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContentLoaderBloc, ContentState>(
      builder: (context, state) {
        if (state is ContentLoading) {
          return _buildLoadingScreen();
        } else if (state is ContentError) {
          return _buildErrorScreen(state.message);
        } else {
          return _buildMainScreen();
        }
      },
    );
  }

  /// Pantalla de carga inicial de contenido
  Widget _buildLoadingScreen() {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              strokeWidth: 3,
              color: Colors.blue,
            ),
            SizedBox(height: 24),
            Text(
              'Cargando contenido...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Esto puede tomar unos minutos',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Pantalla de error en carga inicial
  Widget _buildErrorScreen(String message) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 80,
                color: Colors.red,
              ),
              const SizedBox(height: 24),
              const Text(
                'Error al cargar contenido',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                message,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.go('/login');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade600,
                    ),
                    child: const Text('Volver'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _loadInitialContent();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade600,
                    ),
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Pantalla principal con pestañas
  Widget _buildMainScreen() {
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
        context.read<ChannelsBloc>().add(RefreshChannels());
        _showMessage('Actualizando canales...');
        break;
      case 1:
        context.read<VodBloc>().add(RefreshVodItems());
        _showMessage('Actualizando películas...');
        break;
      case 2:
        context.read<SeriesBloc>().add(RefreshSeriesItems());
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
  @override
  void initState() {
    super.initState();
    // Cargar canales al inicializar el tab
    context.read<ChannelsBloc>().add(LoadChannels());
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
        
        // Cuerpo: ListView con BLoC
        Expanded(
          child: BlocBuilder<ChannelsBloc, ContentState>(
            builder: (context, state) {
              if (state is ContentLoading) {
                return _buildSkeletonList();
              } else if (state is ContentLoaded<Channel>) {
                return _buildChannelsList(state.items);
              } else if (state is ContentRefreshing<Channel>) {
                return _buildChannelsList(state.items, isRefreshing: true);
              } else if (state is ContentError) {
                return _buildErrorState(state.message);
              } else {
                return _buildEmptyState();
              }
            },
          ),
        ),
      ],
    );
  }

  /// Lista de canales reales
  Widget _buildChannelsList(List<Channel> channels, {bool isRefreshing = false}) {
    if (channels.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<ChannelsBloc>().add(RefreshChannels());
      },
      child: Stack(
        children: [
          ListView.builder(
            itemCount: channels.length,
            itemBuilder: (context, index) {
              final channel = channels[index];
              return _buildChannelTile(channel);
            },
          ),
          if (isRefreshing)
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: LinearProgressIndicator(),
            ),
        ],
      ),
    );
  }

  /// Tile de canal con datos reales
  Widget _buildChannelTile(Channel channel) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.blue.shade600,
          borderRadius: BorderRadius.circular(30),
        ),
        child: channel.streamIcon.isNotEmpty
            ? ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  channel.streamIcon,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.live_tv,
                      color: Colors.white,
                      size: 30,
                    );
                  },
                ),
              )
            : const Icon(
                Icons.live_tv,
                color: Colors.white,
                size: 30,
              ),
      ),
      title: Text(
        channel.name,
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
            'EN VIVO • ${channel.streamType.toUpperCase()}',
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

  /// Estado vacío
  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.tv_off,
            size: 80,
            color: Colors.white30,
          ),
          SizedBox(height: 24),
          Text(
            'No hay canales disponibles',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white70,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Intenta refrescar la lista',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }

  /// Estado de error
  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 80,
            color: Colors.red,
          ),
          const SizedBox(height: 24),
          Text(
            'Error al cargar canales',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            message,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              context.read<ChannelsBloc>().add(LoadChannels());
            },
            child: const Text('Reintentar'),
          ),
        ],
      ),
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
  void _playChannel(Channel channel) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reproduciendo ${channel.name}'),
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
  @override
  void initState() {
    super.initState();
    // Cargar VOD al inicializar el tab
    context.read<VodBloc>().add(LoadVodItems());
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
          child: BlocBuilder<VodBloc, ContentState>(
            builder: (context, state) {
              if (state is ContentLoading) {
                return _buildSkeletonGrid();
              } else if (state is ContentLoaded<VodItem>) {
                return _buildMoviesGrid(state.items);
              } else if (state is ContentRefreshing<VodItem>) {
                return _buildMoviesGrid(state.items, isRefreshing: true);
              } else if (state is ContentError) {
                return _buildErrorState(state.message);
              } else {
                return _buildEmptyState();
              }
            },
          ),
        ),
      ],
    );
  }

  /// Grid de películas reales
  Widget _buildMoviesGrid(List<VodItem> movies, {bool isRefreshing = false}) {
    if (movies.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<VodBloc>().add(RefreshVodItems());
      },
      child: Stack(
        children: [
          GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7, // Ratio 2:3 para posters
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return _buildMovieCard(movie);
            },
          ),
          if (isRefreshing)
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: LinearProgressIndicator(),
            ),
        ],
      ),
    );
  }

  /// Tarjeta de película con datos reales
  Widget _buildMovieCard(VodItem movie) {
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
                child: movie.streamIcon.isNotEmpty
                    ? ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        child: Image.network(
                          movie.streamIcon,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.movie,
                              size: 50,
                              color: Colors.white,
                            );
                          },
                        ),
                      )
                    : const Icon(
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
                    movie.name,
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
                    '${movie.releaseDate?.year ?? 'N/A'} • ${movie.genre.isNotEmpty ? movie.genre : 'General'}',
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                    ),
                  ),
                  if (movie.rating > 0) ...[
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 12,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          movie.rating.toStringAsFixed(1),
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Estado vacío
  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.movie_outlined,
            size: 80,
            color: Colors.white30,
          ),
          SizedBox(height: 24),
          Text(
            'No hay películas disponibles',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white70,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Intenta refrescar la lista',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }

  /// Estado de error
  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 80,
            color: Colors.red,
          ),
          const SizedBox(height: 24),
          Text(
            'Error al cargar películas',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            message,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              context.read<VodBloc>().add(LoadVodItems());
            },
            child: const Text('Reintentar'),
          ),
        ],
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
  void _playMovie(VodItem movie) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reproduciendo ${movie.name}'),
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
  @override
  void initState() {
    super.initState();
    // Cargar series al inicializar el tab
    context.read<SeriesBloc>().add(LoadSeriesItems());
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
          child: BlocBuilder<SeriesBloc, ContentState>(
            builder: (context, state) {
              if (state is ContentLoading) {
                return _buildSkeletonGrid();
              } else if (state is ContentLoaded<SeriesItem>) {
                return _buildSeriesGrid(state.items);
              } else if (state is ContentRefreshing<SeriesItem>) {
                return _buildSeriesGrid(state.items, isRefreshing: true);
              } else if (state is ContentError) {
                return _buildErrorState(state.message);
              } else {
                return _buildEmptyState();
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSeriesGrid(List<SeriesItem> series, {bool isRefreshing = false}) {
    if (series.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<SeriesBloc>().add(RefreshSeriesItems());
      },
      child: Stack(
        children: [
          GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: series.length,
            itemBuilder: (context, index) {
              final serie = series[index];
              return _buildSerieCard(serie);
            },
          ),
          if (isRefreshing)
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: LinearProgressIndicator(),
            ),
        ],
      ),
    );
  }

  Widget _buildSerieCard(SeriesItem serie) {
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
                child: serie.cover.isNotEmpty
                    ? ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        child: Image.network(
                          serie.cover,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.tv,
                              size: 50,
                              color: Colors.white,
                            );
                          },
                        ),
                      )
                    : const Icon(
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
                    serie.name,
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
                    '${serie.releaseDate?.year ?? 'N/A'} • ${serie.genre.isNotEmpty ? serie.genre : 'General'}',
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                    ),
                  ),
                  if (serie.rating > 0) ...[
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 12,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          serie.rating.toStringAsFixed(1),
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Estado vacío
  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.tv_off,
            size: 80,
            color: Colors.white30,
          ),
          SizedBox(height: 24),
          Text(
            'No hay series disponibles',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white70,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Intenta refrescar la lista',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }

  /// Estado de error
  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 80,
            color: Colors.red,
          ),
          const SizedBox(height: 24),
          Text(
            'Error al cargar series',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            message,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              context.read<SeriesBloc>().add(LoadSeriesItems());
            },
            child: const Text('Reintentar'),
          ),
        ],
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

  void _showSerieDetail(SeriesItem serie) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF161B22),
        title: Text(
          serie.name,
          style: const TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (serie.plot.isNotEmpty) ...[
              Text(
                serie.plot,
                style: const TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 12),
            ],
            if (serie.cast.isNotEmpty) ...[
              Text(
                'Reparto: ${serie.cast}',
                style: const TextStyle(color: Colors.white54, fontSize: 12),
              ),
              const SizedBox(height: 8),
            ],
            if (serie.director.isNotEmpty) ...[
              Text(
                'Director: ${serie.director}',
                style: const TextStyle(color: Colors.white54, fontSize: 12),
              ),
              const SizedBox(height: 8),
            ],
            Text(
              'Funcionalidad de detalle con episodios estará disponible próximamente.',
              style: const TextStyle(color: Colors.white70),
            ),
          ],
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
                  content: Text('Reproduciendo ${serie.name}'),
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
