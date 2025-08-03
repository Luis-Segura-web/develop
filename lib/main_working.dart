import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reproductor IPTV',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E88E5),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.tv,
              size: 100,
              color: Color(0xFF1E88E5),
            ),
            SizedBox(height: 20),
            Text(
              'Reproductor IPTV',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Inicializando...',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(
              color: Color(0xFF1E88E5),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _serverController = TextEditingController();
  final _portController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _serverController.dispose();
    _portController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Conectando al servidor...'),
          backgroundColor: Color(0xFF1E88E5),
        ),
      );
      
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conectar Servidor IPTV'),
        backgroundColor: const Color(0xFF1E88E5),
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              const Icon(
                Icons.account_circle,
                size: 80,
                color: Color(0xFF1E88E5),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre de la Conexión',
                  hintText: 'Mi Servidor IPTV',
                  prefixIcon: Icon(Icons.label),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _serverController,
                decoration: const InputDecoration(
                  labelText: 'URL del Servidor',
                  hintText: 'http://ejemplo.com',
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
                  hintText: '8080',
                  prefixIcon: Icon(Icons.settings_ethernet),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el puerto';
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
                    return 'Por favor ingrese el usuario';
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
                    return 'Por favor ingrese la contraseña';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E88E5),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(16),
                ),
                child: const Text(
                  'Conectar',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  // Implementar demo con datos de prueba
                  _navigateToDemoMode();
                },
                child: const Text('Probar Demo'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Navegar al modo demo con datos de prueba
  void _navigateToDemoMode() {
    // Mostrar dialogo de confirmación
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Modo Demo'),
          content: const Text(
            'El modo demo te permitirá probar la interfaz del reproductor '
            'con datos de ejemplo sin necesidad de una conexión real.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              child: const Text('Continuar'),
            ),
          ],
        );
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<String> _recentSearches = ['deportes', 'acción', 'noticias'];

  final List<Widget> _pages = [
    const LiveChannelsPage(),
    const MoviesPage(),
    const SeriesPage(),
    const FavoritesPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reproductor IPTV'),
        backgroundColor: const Color(0xFF1E88E5),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _showSearchDialog();
            },
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: const Color(0xFF1E88E5),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.live_tv),
            label: 'En Vivo',
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
            label: 'Configuración',
          ),
        ],
      ),
    );
  }

  /// Mostrar diálogo de búsqueda
  void _showSearchDialog() {
    String searchQuery = '';
    String searchType = 'Todo';
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: Colors.grey[900],
              title: const Text(
                'Buscar Contenido',
                style: TextStyle(color: Colors.white),
              ),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Campo de búsqueda
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Buscar...',
                        labelStyle: const TextStyle(color: Colors.grey),
                        hintText: _getSearchHint(searchType),
                        hintStyle: const TextStyle(color: Colors.grey),
                        prefixIcon: const Icon(Icons.search, color: Colors.grey),
                        filled: true,
                        fillColor: Colors.grey[800],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                      onChanged: (value) {
                        searchQuery = value;
                      },
                      autofocus: true,
                    ),
                    const SizedBox(height: 16),
                    // Filtros de tipo de contenido
                    const Text(
                      'Buscar en:',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: ['Todo', 'Canales', 'Películas', 'Series', 'Favoritos']
                          .map((type) => FilterChip(
                                label: Text(
                                  type,
                                  style: TextStyle(
                                    color: searchType == type ? Colors.white : Colors.grey,
                                  ),
                                ),
                                selected: searchType == type,
                                onSelected: (selected) {
                                  setDialogState(() {
                                    searchType = type;
                                  });
                                },
                                backgroundColor: Colors.grey[800],
                                selectedColor: const Color(0xFF1E88E5),
                                checkmarkColor: Colors.white,
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 16),
                    // Búsquedas recientes
                    if (_recentSearches.isNotEmpty) ...[
                      const Text(
                        'Búsquedas recientes:',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 4,
                        children: _recentSearches.take(3).map((search) => 
                          ActionChip(
                            label: Text(
                              search,
                              style: const TextStyle(color: Colors.white, fontSize: 10),
                            ),
                            backgroundColor: Colors.grey[700],
                            onPressed: () {
                              searchQuery = search;
                              Navigator.of(context).pop();
                              _performSearch(searchQuery, searchType);
                            },
                          )
                        ).toList(),
                      ),
                    ],
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (searchQuery.isNotEmpty) {
                      _performSearch(searchQuery, searchType);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E88E5),
                  ),
                  child: const Text('Buscar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  String _getSearchHint(String searchType) {
    switch (searchType) {
      case 'Canales':
        return 'Buscar canales en vivo...';
      case 'Películas':
        return 'Buscar películas...';
      case 'Series':
        return 'Buscar series...';
      case 'Favoritos':
        return 'Buscar en favoritos...';
      default:
        return 'Buscar en todo el contenido...';
    }
  }

  /// Realizar búsqueda
  void _performSearch(String query, String type) {
    // Agregar a búsquedas recientes
    if (!_recentSearches.contains(query)) {
      _recentSearches.insert(0, query);
      if (_recentSearches.length > 5) {
        _recentSearches.removeLast();
      }
    }

    // Mostrar resultados según el tipo
    String message = 'Buscando "$query"';
    String actionLabel = 'Ver resultados';
    Color backgroundColor = const Color(0xFF1E88E5);

    switch (type) {
      case 'Canales':
        message += ' en canales en vivo';
        backgroundColor = Colors.green;
        // En implementación real, cambiaríamos a la pestaña de canales y filtrar
        _currentIndex = 0;
        break;
      case 'Películas':
        message += ' en películas';
        backgroundColor = const Color(0xFF1E88E5);
        _currentIndex = 1;
        break;
      case 'Series':
        message += ' en series';
        backgroundColor = const Color(0xFF9C27B0);
        _currentIndex = 2;
        break;
      case 'Favoritos':
        message += ' en favoritos';
        backgroundColor = const Color(0xFFE91E63);
        _currentIndex = 3;
        break;
      default:
        message += ' en todo el contenido';
        actionLabel = 'Filtros avanzados';
    }

    setState(() {}); // Actualizar la pestaña actual

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        action: SnackBarAction(
          label: actionLabel,
          textColor: Colors.white,
          onPressed: () {
            _showSearchResults(query, type);
          },
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  /// Mostrar resultados de búsqueda
  void _showSearchResults(String query, String type) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          'Resultados para "$query"',
          style: const TextStyle(color: Colors.white),
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Buscando en: $type',
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: _getSearchResults(query, type)
                      .map((result) => ListTile(
                            leading: Icon(
                              _getIconForContentType(result['type']),
                              color: _getColorForContentType(result['type']),
                            ),
                            title: Text(
                              result['title'],
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              '${result['type']} • ${result['genre'] ?? 'Sin género'}',
                              style: const TextStyle(color: Colors.grey),
                            ),
                            trailing: const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Reproduciendo: ${result['title']}'),
                                  backgroundColor: _getColorForContentType(result['type']),
                                ),
                              );
                            },
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  IconData _getIconForContentType(String type) {
    switch (type) {
      case 'Canal':
        return Icons.live_tv;
      case 'Película':
        return Icons.movie;
      case 'Serie':
        return Icons.tv;
      default:
        return Icons.play_circle;
    }
  }

  Color _getColorForContentType(String type) {
    switch (type) {
      case 'Canal':
        return Colors.green;
      case 'Película':
        return const Color(0xFF1E88E5);
      case 'Serie':
        return const Color(0xFF9C27B0);
      default:
        return Colors.grey;
    }
  }

  List<Map<String, String>> _getSearchResults(String query, String type) {
    // Simulación de resultados de búsqueda
    List<Map<String, String>> allResults = [
      {'title': 'Canal Deportes HD', 'type': 'Canal', 'genre': 'Deportes'},
      {'title': 'Acción Extrema', 'type': 'Película', 'genre': 'Acción'},
      {'title': 'Detective Nocturno', 'type': 'Serie', 'genre': 'Crime'},
      {'title': 'Noticias 24H', 'type': 'Canal', 'genre': 'Noticias'},
      {'title': 'Comedia Romántica', 'type': 'Película', 'genre': 'Romance'},
      {'title': 'Aventuras Espaciales', 'type': 'Serie', 'genre': 'Sci-Fi'},
    ];

    // Filtrar por tipo si no es "Todo"
    if (type != 'Todo') {
      String filterType;
      switch (type) {
        case 'Canales':
          filterType = 'Canal';
          break;
        case 'Películas':
          filterType = 'Película';
          break;
        case 'Series':
          filterType = 'Serie';
          break;
        default:
          filterType = '';
      }
      
      if (filterType.isNotEmpty) {
        allResults = allResults.where((result) => result['type'] == filterType).toList();
      }
    }

    // Filtrar por query (simulado)
    return allResults.where((result) => 
      result['title']!.toLowerCase().contains(query.toLowerCase()) ||
      result['genre']!.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }
}

class LiveChannelsPage extends StatelessWidget {
  const LiveChannelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Categorías de Canales',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: _demoCategories.length,
              itemBuilder: (context, index) {
                final category = _demoCategories[index];
                return Card(
                  child: InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Abriendo: ${category['name']}')),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            category['icon'] as IconData,
                            size: 32,
                            color: const Color(0xFF1E88E5),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            category['name'] as String,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  List<Map<String, dynamic>> _movies = [];
  List<Map<String, dynamic>> _categories = [];
  String? _selectedCategory;
  bool _isLoading = false;
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredMovies = [];

  @override
  void initState() {
    super.initState();
    _loadMovieData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadMovieData() {
    setState(() {
      _isLoading = true;
    });

    // Simulación de carga de datos
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _categories = _demoMovieCategories;
          _movies = _demoMovies;
          _filteredMovies = _movies;
          _isLoading = false;
        });
      }
    });
  }

  void _filterMovies(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredMovies = _selectedCategory == null 
            ? _movies 
            : _movies.where((movie) => movie['category'] == _selectedCategory).toList();
      } else {
        var filtered = _selectedCategory == null 
            ? _movies 
            : _movies.where((movie) => movie['category'] == _selectedCategory).toList();
        
        _filteredMovies = filtered.where((movie) {
          final title = movie['title'].toString().toLowerCase();
          final genre = movie['genre'].toString().toLowerCase();
          return title.contains(query.toLowerCase()) || 
                 genre.contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  void _selectCategory(String? category) {
    setState(() {
      _selectedCategory = category;
      _filterMovies(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        children: [
          // Header con filtros
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.grey[850],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.movie,
                      color: Color(0xFF1E88E5),
                      size: 28,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Películas',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${_filteredMovies.length} películas',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Barra de búsqueda
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Buscar películas...',
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    filled: true,
                    fillColor: Colors.grey[800],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  onChanged: _filterMovies,
                ),
                const SizedBox(height: 12),
                // Filtros de categoría
                SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildCategoryChip('Todas', null),
                      ..._categories.map((cat) => _buildCategoryChip(
                        cat['name'], 
                        cat['id'],
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Lista/Grid de películas
          Expanded(
            child: _isLoading 
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF1E88E5),
                    ),
                  )
                : _filteredMovies.isEmpty
                    ? _buildEmptyState()
                    : _buildMoviesGrid(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label, String? categoryId) {
    final isSelected = _selectedCategory == categoryId;
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
          ),
        ),
        selected: isSelected,
        onSelected: (selected) => _selectCategory(selected ? categoryId : null),
        backgroundColor: Colors.grey[800],
        selectedColor: const Color(0xFF1E88E5),
        checkmarkColor: Colors.white,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.movie_outlined,
            size: 64,
            color: Colors.grey[600],
          ),
          const SizedBox(height: 16),
          Text(
            'No se encontraron películas',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Intenta cambiar los filtros de búsqueda',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoviesGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
        childAspectRatio: 0.65,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: _filteredMovies.length,
      itemBuilder: (context, index) {
        final movie = _filteredMovies[index];
        return _buildMovieCard(movie);
      },
    );
  }

  Widget _buildMovieCard(Map<String, dynamic> movie) {
    return Card(
      color: Colors.grey[850],
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => _playMovie(movie),
        borderRadius: BorderRadius.circular(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster de la película
            Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(8),
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Icon(
                        Icons.movie,
                        size: 48,
                        color: Colors.grey[500],
                      ),
                    ),
                    // Rating badge
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star,
                              size: 12,
                              color: Colors.black,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              movie['rating'],
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Información de la película
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie['title'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${movie['year']} • ${movie['genre']}',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 10,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      movie['duration'],
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 9,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _playMovie(Map<String, dynamic> movie) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text(
            movie['title'],
            style: const TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Género: ${movie['genre']}',
                style: const TextStyle(color: Colors.grey),
              ),
              Text(
                'Año: ${movie['year']}',
                style: const TextStyle(color: Colors.grey),
              ),
              Text(
                'Duración: ${movie['duration']}',
                style: const TextStyle(color: Colors.grey),
              ),
              Text(
                'Rating: ${movie['rating']}',
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              Text(
                movie['description'],
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cerrar'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Reproduciendo: ${movie['title']}'),
                    backgroundColor: const Color(0xFF1E88E5),
                  ),
                );
              },
              icon: const Icon(Icons.play_arrow),
              label: const Text('Reproducir'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E88E5),
              ),
            ),
          ],
        );
      },
    );
  }
}

class SeriesPage extends StatefulWidget {
  const SeriesPage({super.key});

  @override
  State<SeriesPage> createState() => _SeriesPageState();
}

class _SeriesPageState extends State<SeriesPage> {
  List<Map<String, dynamic>> _series = [];
  List<Map<String, dynamic>> _categories = [];
  String? _selectedCategory;
  bool _isLoading = false;
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredSeries = [];

  @override
  void initState() {
    super.initState();
    _loadSeriesData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadSeriesData() {
    setState(() {
      _isLoading = true;
    });

    // Simulación de carga de datos
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _categories = _demoSeriesCategories;
          _series = _demoSeries;
          _filteredSeries = _series;
          _isLoading = false;
        });
      }
    });
  }

  void _filterSeries(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredSeries = _selectedCategory == null 
            ? _series 
            : _series.where((series) => series['category'] == _selectedCategory).toList();
      } else {
        var filtered = _selectedCategory == null 
            ? _series 
            : _series.where((series) => series['category'] == _selectedCategory).toList();
        
        _filteredSeries = filtered.where((series) {
          final title = series['title'].toString().toLowerCase();
          final genre = series['genre'].toString().toLowerCase();
          return title.contains(query.toLowerCase()) || 
                 genre.contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  void _selectCategory(String? category) {
    setState(() {
      _selectedCategory = category;
      _filterSeries(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        children: [
          // Header con filtros
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.grey[850],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.tv,
                      color: Color(0xFF9C27B0),
                      size: 28,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Series',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${_filteredSeries.length} series',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Barra de búsqueda
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Buscar series...',
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    filled: true,
                    fillColor: Colors.grey[800],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  onChanged: _filterSeries,
                ),
                const SizedBox(height: 12),
                // Filtros de categoría
                SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildCategoryChip('Todas', null),
                      ..._categories.map((cat) => _buildCategoryChip(
                        cat['name'], 
                        cat['id'],
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Lista/Grid de series
          Expanded(
            child: _isLoading 
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF9C27B0),
                    ),
                  )
                : _filteredSeries.isEmpty
                    ? _buildEmptyState()
                    : _buildSeriesGrid(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label, String? categoryId) {
    final isSelected = _selectedCategory == categoryId;
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
          ),
        ),
        selected: isSelected,
        onSelected: (selected) => _selectCategory(selected ? categoryId : null),
        backgroundColor: Colors.grey[800],
        selectedColor: const Color(0xFF9C27B0),
        checkmarkColor: Colors.white,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.tv_outlined,
            size: 64,
            color: Colors.grey[600],
          ),
          const SizedBox(height: 16),
          Text(
            'No se encontraron series',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Intenta cambiar los filtros de búsqueda',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeriesGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
        childAspectRatio: 0.65,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: _filteredSeries.length,
      itemBuilder: (context, index) {
        final series = _filteredSeries[index];
        return _buildSeriesCard(series);
      },
    );
  }

  Widget _buildSeriesCard(Map<String, dynamic> series) {
    return Card(
      color: Colors.grey[850],
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => _showSeriesDetails(series),
        borderRadius: BorderRadius.circular(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster de la serie
            Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(8),
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Icon(
                        Icons.tv,
                        size: 48,
                        color: Colors.grey[500],
                      ),
                    ),
                    // Rating badge
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star,
                              size: 12,
                              color: Colors.black,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              series['rating'],
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Episode count badge
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF9C27B0),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${series['episodes']} ep.',
                          style: const TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Información de la serie
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      series['title'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${series['year']} • ${series['genre']}',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 10,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 10,
                          color: Colors.grey[500],
                        ),
                        const SizedBox(width: 2),
                        Text(
                          series['duration'],
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 9,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSeriesDetails(Map<String, dynamic> series) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.grey[900],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.7,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        series['title'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Información de la serie
                Text(
                  'Género: ${series['genre']} • Año: ${series['year']}',
                  style: const TextStyle(color: Colors.grey),
                ),
                Text(
                  'Episodios: ${series['episodes']} • Duración: ${series['duration']}',
                  style: const TextStyle(color: Colors.grey),
                ),
                Text(
                  'Rating: ${series['rating']}/10',
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 16),
                Text(
                  series['description'],
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 24),
                // Lista de temporadas (simulada)
                const Text(
                  'Temporadas',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    itemCount: series['seasons'],
                    itemBuilder: (context, index) {
                      final season = index + 1;
                      return Card(
                        color: Colors.grey[800],
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: const Color(0xFF9C27B0),
                            child: Text(
                              season.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          title: Text(
                            'Temporada $season',
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            '${(series['episodes'] / series['seasons']).round()} episodios',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          trailing: const Icon(
                            Icons.play_arrow,
                            color: Color(0xFF9C27B0),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Reproduciendo ${series['title']} - Temporada $season',
                                ),
                                backgroundColor: const Color(0xFF9C27B0),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Map<String, dynamic>> _favoriteItems = [];
  bool _isLoading = false;
  String _selectedTab = 'Todos';

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() {
    setState(() {
      _isLoading = true;
    });

    // Simulación de carga de favoritos
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _favoriteItems = _demoFavorites;
          _isLoading = false;
        });
      }
    });
  }

  List<Map<String, dynamic>> get _filteredFavorites {
    if (_selectedTab == 'Todos') {
      return _favoriteItems;
    }
    return _favoriteItems.where((item) => item['type'] == _selectedTab).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.grey[850],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.favorite,
                      color: Color(0xFFE91E63),
                      size: 28,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Favoritos',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert, color: Colors.white),
                      onSelected: (value) {
                        if (value == 'clear_all') {
                          _showClearAllDialog();
                        } else if (value == 'export') {
                          _exportFavorites();
                        } else if (value == 'import') {
                          _importFavorites();
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'export',
                          child: Row(
                            children: [
                              Icon(Icons.download, color: Colors.white),
                              SizedBox(width: 8),
                              Text('Exportar', style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'import',
                          child: Row(
                            children: [
                              Icon(Icons.upload, color: Colors.white),
                              SizedBox(width: 8),
                              Text('Importar', style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'clear_all',
                          child: Row(
                            children: [
                              Icon(Icons.clear_all, color: Colors.red),
                              SizedBox(width: 8),
                              Text('Limpiar Todo', style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                      ],
                      color: Colors.grey[800],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '${_filteredFavorites.length} elementos favoritos',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                // Tabs de filtro
                SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildTabChip('Todos'),
                      _buildTabChip('Canales'),
                      _buildTabChip('Películas'),
                      _buildTabChip('Series'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Lista de favoritos
          Expanded(
            child: _isLoading 
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFFE91E63),
                    ),
                  )
                : _filteredFavorites.isEmpty
                    ? _buildEmptyState()
                    : _buildFavoritesList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabChip(String label) {
    final isSelected = _selectedTab == label;
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
          ),
        ),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            _selectedTab = label;
          });
        },
        backgroundColor: Colors.grey[800],
        selectedColor: const Color(0xFFE91E63),
        checkmarkColor: Colors.white,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 64,
            color: Colors.grey[600],
          ),
          const SizedBox(height: 16),
          Text(
            _selectedTab == 'Todos' 
                ? 'No tienes favoritos aún'
                : 'No tienes ${_selectedTab.toLowerCase()} favoritos',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Toca el ícono ♥ en cualquier contenido para agregarlo a favoritos',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _filteredFavorites.length,
      itemBuilder: (context, index) {
        final item = _filteredFavorites[index];
        return _buildFavoriteItem(item);
      },
    );
  }

  Widget _buildFavoriteItem(Map<String, dynamic> item) {
    return Card(
      color: Colors.grey[850],
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey[700],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            _getIconForType(item['type']),
            color: _getColorForType(item['type']),
            size: 24,
          ),
        ),
        title: Text(
          item['title'],
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item['type'],
              style: TextStyle(
                color: _getColorForType(item['type']),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (item['genre'] != null)
              Text(
                item['genre'],
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            if (item['addedDate'] != null)
              Text(
                'Agregado: ${item['addedDate']}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                ),
              ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert, color: Colors.white),
          onSelected: (value) {
            if (value == 'play') {
              _playItem(item);
            } else if (value == 'remove') {
              _removeFromFavorites(item);
            } else if (value == 'info') {
              _showItemInfo(item);
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'play',
              child: Row(
                children: [
                  Icon(Icons.play_arrow, color: Colors.green),
                  SizedBox(width: 8),
                  Text('Reproducir', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'info',
              child: Row(
                children: [
                  Icon(Icons.info, color: Colors.blue),
                  SizedBox(width: 8),
                  Text('Información', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'remove',
              child: Row(
                children: [
                  Icon(Icons.favorite, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Quitar de favoritos', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
          color: Colors.grey[800],
        ),
        onTap: () => _playItem(item),
      ),
    );
  }

  IconData _getIconForType(String type) {
    switch (type) {
      case 'Canales':
        return Icons.live_tv;
      case 'Películas':
        return Icons.movie;
      case 'Series':
        return Icons.tv;
      default:
        return Icons.favorite;
    }
  }

  Color _getColorForType(String type) {
    switch (type) {
      case 'Canales':
        return Colors.green;
      case 'Películas':
        return const Color(0xFF1E88E5);
      case 'Series':
        return const Color(0xFF9C27B0);
      default:
        return const Color(0xFFE91E63);
    }
  }

  void _playItem(Map<String, dynamic> item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reproduciendo: ${item['title']}'),
        backgroundColor: _getColorForType(item['type']),
      ),
    );
  }

  void _removeFromFavorites(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text(
          'Quitar de favoritos',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          '¿Estás seguro de que quieres quitar "${item['title']}" de tus favoritos?',
          style: const TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _favoriteItems.remove(item);
              });
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Elemento removido de favoritos'),
                  backgroundColor: Colors.orange,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Quitar'),
          ),
        ],
      ),
    );
  }

  void _showItemInfo(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          item['title'],
          style: const TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tipo: ${item['type']}',
              style: const TextStyle(color: Colors.grey),
            ),
            if (item['genre'] != null)
              Text(
                'Género: ${item['genre']}',
                style: const TextStyle(color: Colors.grey),
              ),
            if (item['year'] != null)
              Text(
                'Año: ${item['year']}',
                style: const TextStyle(color: Colors.grey),
              ),
            if (item['rating'] != null)
              Text(
                'Rating: ${item['rating']}',
                style: const TextStyle(color: Colors.grey),
              ),
            if (item['addedDate'] != null)
              Text(
                'Agregado: ${item['addedDate']}',
                style: const TextStyle(color: Colors.grey),
              ),
            if (item['description'] != null) ...[
              const SizedBox(height: 16),
              Text(
                item['description'],
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  void _showClearAllDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text(
          'Limpiar todos los favoritos',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          '¿Estás seguro de que quieres eliminar todos tus favoritos? Esta acción no se puede deshacer.',
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _favoriteItems.clear();
              });
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Todos los favoritos han sido eliminados'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Eliminar todo'),
          ),
        ],
      ),
    );
  }

  void _exportFavorites() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Exportando favoritos... (Funcionalidad simulada)'),
        backgroundColor: Color(0xFF1E88E5),
      ),
    );
  }

  void _importFavorites() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Importando favoritos... (Funcionalidad simulada)'),
        backgroundColor: Color(0xFF1E88E5),
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _autoPlay = true;
  bool _showNotifications = true;
  bool _parentalControl = false;
  double _videoQuality = 2; // 0: Baja, 1: Media, 2: Alta, 3: Auto
  String _playerEngine = 'Auto';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.settings,
                  color: Color(0xFF1E88E5),
                  size: 28,
                ),
                SizedBox(width: 8),
                Text(
                  'Configuración',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Sección: Cuenta y Servidores
          _buildSection(
            'Cuenta y Servidores',
            Icons.account_circle,
            [
              _buildListTile(
                icon: Icons.server,
                title: 'Gestión de Servidores',
                subtitle: 'Agregar, editar y eliminar conexiones IPTV',
                onTap: () => _showServerManagement(),
              ),
              _buildListTile(
                icon: Icons.switch_account,
                title: 'Cambiar Perfil',
                subtitle: 'Conectar con otro servidor IPTV',
                onTap: () => _changeProfile(),
              ),
              _buildListTile(
                icon: Icons.logout,
                title: 'Cerrar Sesión',
                subtitle: 'Desconectar del servidor actual',
                onTap: () => _logout(),
                trailing: const Icon(Icons.arrow_forward_ios, color: Colors.red),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Sección: Reproductor
          _buildSection(
            'Reproductor de Video',
            Icons.video_settings,
            [
              _buildDropdownTile(
                icon: Icons.settings_applications,
                title: 'Motor de Reproducción',
                subtitle: 'Seleccionar el motor de video',
                value: _playerEngine,
                items: ['Auto', 'ExoPlayer', 'VLC', 'IJKPlayer'],
                onChanged: (value) {
                  setState(() {
                    _playerEngine = value!;
                  });
                  _showMessage('Motor cambiado a: $value');
                },
              ),
              _buildSliderTile(
                icon: Icons.high_quality,
                title: 'Calidad de Video',
                subtitle: _getQualityLabel(_videoQuality),
                value: _videoQuality,
                min: 0,
                max: 3,
                divisions: 3,
                onChanged: (value) {
                  setState(() {
                    _videoQuality = value;
                  });
                },
              ),
              _buildSwitchTile(
                icon: Icons.play_arrow,
                title: 'Reproducción Automática',
                subtitle: 'Iniciar reproducción automáticamente',
                value: _autoPlay,
                onChanged: (value) {
                  setState(() {
                    _autoPlay = value;
                  });
                },
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Sección: Control Parental
          _buildSection(
            'Control Parental',
            Icons.child_care,
            [
              _buildSwitchTile(
                icon: Icons.lock,
                title: 'Control Parental',
                subtitle: 'Activar restricciones de contenido',
                value: _parentalControl,
                onChanged: (value) {
                  if (value) {
                    _showParentalControlSetup();
                  } else {
                    setState(() {
                      _parentalControl = value;
                    });
                  }
                },
              ),
              _buildListTile(
                icon: Icons.pin,
                title: 'Cambiar PIN',
                subtitle: 'Modificar PIN de control parental',
                onTap: _parentalControl ? () => _changePIN() : null,
                enabled: _parentalControl,
              ),
              _buildListTile(
                icon: Icons.block,
                title: 'Contenido Bloqueado',
                subtitle: 'Gestionar categorías bloqueadas',
                onTap: _parentalControl ? () => _manageBlockedContent() : null,
                enabled: _parentalControl,
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Sección: Datos y Almacenamiento
          _buildSection(
            'Datos y Almacenamiento',
            Icons.storage,
            [
              _buildSwitchTile(
                icon: Icons.notifications,
                title: 'Notificaciones',
                subtitle: 'Recibir notificaciones de la app',
                value: _showNotifications,
                onChanged: (value) {
                  setState(() {
                    _showNotifications = value;
                  });
                },
              ),
              _buildListTile(
                icon: Icons.download,
                title: 'Gestionar Descargas',
                subtitle: 'Ver y eliminar contenido descargado',
                onTap: () => _manageDownloads(),
              ),
              _buildListTile(
                icon: Icons.cache,
                title: 'Limpiar Cache',
                subtitle: 'Eliminar archivos temporales (245 MB)',
                onTap: () => _clearCache(),
              ),
              _buildListTile(
                icon: Icons.backup,
                title: 'Copia de Seguridad',
                subtitle: 'Exportar/importar configuración',
                onTap: () => _showBackupOptions(),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Sección: Información
          _buildSection(
            'Información',
            Icons.info,
            [
              _buildListTile(
                icon: Icons.help,
                title: 'Ayuda y Soporte',
                subtitle: 'Obtener ayuda sobre la aplicación',
                onTap: () => _showHelp(),
              ),
              _buildListTile(
                icon: Icons.privacy_tip,
                title: 'Política de Privacidad',
                subtitle: 'Ver términos y condiciones',
                onTap: () => _showPrivacyPolicy(),
              ),
              _buildListTile(
                icon: Icons.info_outline,
                title: 'Acerca de',
                subtitle: 'Reproductor IPTV v1.0.0',
                onTap: () => _showAbout(),
              ),
            ],
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSection(String title, IconData icon, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Row(
            children: [
              Icon(icon, color: const Color(0xFF1E88E5), size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF1E88E5),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[850],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
    Widget? trailing,
    bool enabled = true,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: enabled ? const Color(0xFF1E88E5) : Colors.grey,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: enabled ? Colors.white : Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: enabled ? Colors.grey[400] : Colors.grey[600],
        ),
      ),
      trailing: trailing ??
          Icon(
            Icons.arrow_forward_ios,
            color: enabled ? Colors.grey[400] : Colors.grey[600],
            size: 16,
          ),
      onTap: enabled ? onTap : null,
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF1E88E5)),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.grey[400]),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xFF1E88E5),
      ),
    );
  }

  Widget _buildDropdownTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF1E88E5)),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.grey[400]),
      ),
      trailing: DropdownButton<String>(
        value: value,
        dropdownColor: Colors.grey[800],
        style: const TextStyle(color: Colors.white),
        onChanged: onChanged,
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSliderTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required double value,
    required double min,
    required double max,
    int? divisions,
    required ValueChanged<double> onChanged,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF1E88E5)),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subtitle,
            style: TextStyle(color: Colors.grey[400]),
          ),
          Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            activeColor: const Color(0xFF1E88E5),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  String _getQualityLabel(double value) {
    switch (value.round()) {
      case 0:
        return 'Baja (480p)';
      case 1:
        return 'Media (720p)';
      case 2:
        return 'Alta (1080p)';
      case 3:
        return 'Automática';
      default:
        return 'Automática';
    }
  }

  // Métodos de funcionalidad
  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF1E88E5),
      ),
    );
  }

  void _showServerManagement() {
    _showMessage('Funcionalidad: Gestión de servidores IPTV');
  }

  void _changeProfile() {
    _showMessage('Funcionalidad: Cambio de perfil/servidor');
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text('Cerrar Sesión', style: TextStyle(color: Colors.white)),
        content: const Text(
          '¿Estás seguro de que quieres cerrar sesión?',
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _showMessage('Sesión cerrada exitosamente');
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Cerrar Sesión'),
          ),
        ],
      ),
    );
  }

  void _showParentalControlSetup() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text('Configurar Control Parental', style: TextStyle(color: Colors.white)),
        content: const Text(
          'Establece un PIN de 4 dígitos para activar el control parental.',
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _parentalControl = true;
              });
              _showMessage('Control parental activado');
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1E88E5)),
            child: const Text('Configurar'),
          ),
        ],
      ),
    );
  }

  void _changePIN() {
    _showMessage('Funcionalidad: Cambiar PIN de control parental');
  }

  void _manageBlockedContent() {
    _showMessage('Funcionalidad: Gestionar contenido bloqueado');
  }

  void _manageDownloads() {
    _showMessage('Funcionalidad: Gestión de descargas');
  }

  void _clearCache() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text('Limpiar Cache', style: TextStyle(color: Colors.white)),
        content: const Text(
          '¿Quieres eliminar todos los archivos temporales? Esto liberará 245 MB de espacio.',
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _showMessage('Cache limpiado: 245 MB liberados');
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1E88E5)),
            child: const Text('Limpiar'),
          ),
        ],
      ),
    );
  }

  void _showBackupOptions() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text('Copia de Seguridad', style: TextStyle(color: Colors.white)),
        content: const Text(
          'Exporta tu configuración y favoritos, o importa desde un archivo de respaldo.',
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _showMessage('Exportando configuración...');
            },
            child: const Text('Exportar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _showMessage('Seleccionar archivo de respaldo...');
            },
            child: const Text('Importar'),
          ),
        ],
      ),
    );
  }

  void _showHelp() {
    _showMessage('Funcionalidad: Ayuda y soporte');
  }

  void _showPrivacyPolicy() {
    _showMessage('Funcionalidad: Política de privacidad');
  }

  void _showAbout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text('Acerca de', style: TextStyle(color: Colors.white)),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Reproductor IPTV', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Versión: 1.0.0', style: TextStyle(color: Colors.grey)),
            SizedBox(height: 16),
            Text('Un reproductor IPTV completo con soporte para Xtream Codes API.', style: TextStyle(color: Colors.white)),
            SizedBox(height: 8),
            Text('Características:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            Text('• Canales en vivo', style: TextStyle(color: Colors.grey)),
            Text('• Películas y series', style: TextStyle(color: Colors.grey)),
            Text('• Favoritos y control parental', style: TextStyle(color: Colors.grey)),
            Text('• Múltiples motores de reproducción', style: TextStyle(color: Colors.grey)),
          ],
        ),
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

// Datos de demostración
final List<Map<String, dynamic>> _demoCategories = [
  {'name': 'Deportes', 'icon': Icons.sports_soccer},
  {'name': 'Noticias', 'icon': Icons.newspaper},
  {'name': 'Entretenimiento', 'icon': Icons.theater_comedy},
  {'name': 'Música', 'icon': Icons.music_note},
  {'name': 'Infantil', 'icon': Icons.child_friendly},
  {'name': 'Documentales', 'icon': Icons.school},
];

final List<Map<String, String>> _demoMovies = [
  {
    'title': 'Acción Extrema',
    'year': '2024',
    'genre': 'Acción',
    'rating': '8.2',
    'duration': '2h 15min',
    'category': 'accion',
    'description': 'Una película llena de adrenalina con secuencias de acción espectaculares.',
  },
  {
    'title': 'Comedia Romántica',
    'year': '2023',
    'genre': 'Romance',
    'rating': '7.5',
    'duration': '1h 45min',
    'category': 'romance',
    'description': 'Una historia de amor llena de momentos divertidos y emotivos.',
  },
  {
    'title': 'Thriller Nocturno',
    'year': '2024',
    'genre': 'Thriller',
    'rating': '8.7',
    'duration': '2h 5min',
    'category': 'thriller',
    'description': 'Un thriller psicológico que te mantendrá al borde de tu asiento.',
  },
  {
    'title': 'Drama Familiar',
    'year': '2023',
    'genre': 'Drama',
    'rating': '7.8',
    'duration': '1h 50min',
    'category': 'drama',
    'description': 'Una emotiva historia sobre los lazos familiares y la superación.',
  },
  {
    'title': 'Ciencia Ficción',
    'year': '2024',
    'genre': 'Sci-Fi',
    'rating': '8.9',
    'duration': '2h 30min',
    'category': 'scifi',
    'description': 'Una épica aventura en el espacio con efectos visuales impresionantes.',
  },
  {
    'title': 'Horror Psicológico',
    'year': '2023',
    'genre': 'Horror',
    'rating': '7.3',
    'duration': '1h 35min',
    'category': 'horror',
    'description': 'Una película de terror que juega con tu mente.',
  },
];

final List<Map<String, dynamic>> _demoMovieCategories = [
  {'name': 'Acción', 'id': 'accion'},
  {'name': 'Romance', 'id': 'romance'},
  {'name': 'Thriller', 'id': 'thriller'},
  {'name': 'Drama', 'id': 'drama'},
  {'name': 'Sci-Fi', 'id': 'scifi'},
  {'name': 'Horror', 'id': 'horror'},
];

final List<Map<String, dynamic>> _demoSeries = [
  {
    'title': 'Detective Nocturno',
    'year': '2024',
    'genre': 'Crime/Drama',
    'rating': '9.1',
    'duration': '45min',
    'episodes': 24,
    'seasons': 2,
    'category': 'crime',
    'description': 'Un detective trabaja en casos complejos durante las horas nocturnas de la ciudad.',
  },
  {
    'title': 'Aventuras Espaciales',
    'year': '2023',
    'genre': 'Sci-Fi',
    'rating': '8.7',
    'duration': '50min',
    'episodes': 36,
    'seasons': 3,
    'category': 'scifi',
    'description': 'Una tripulación explora galaxias lejanas en busca de nuevos mundos.',
  },
  {
    'title': 'Comedia de Oficina',
    'year': '2024',
    'genre': 'Comedia',
    'rating': '8.3',
    'duration': '25min',
    'episodes': 48,
    'seasons': 4,
    'category': 'comedy',
    'description': 'Las divertidas situaciones de un grupo de trabajadores de oficina.',
  },
  {
    'title': 'Drama Histórico',
    'year': '2023',
    'genre': 'Drama/Historia',
    'rating': '9.4',
    'duration': '55min',
    'episodes': 18,
    'seasons': 2,
    'category': 'drama',
    'description': 'Una serie ambientada en el siglo XVIII que narra eventos históricos.',
  },
  {
    'title': 'Thriller Médico',
    'year': '2024',
    'genre': 'Thriller/Drama',
    'rating': '8.6',
    'duration': '42min',
    'episodes': 32,
    'seasons': 3,
    'category': 'thriller',
    'description': 'Médicos enfrentan casos médicos complejos mientras lidian con misterios.',
  },
  {
    'title': 'Fantasía Épica',
    'year': '2023',
    'genre': 'Fantasía',
    'rating': '9.2',
    'duration': '60min',
    'episodes': 20,
    'seasons': 2,
    'category': 'fantasy',
    'description': 'Una épica aventura en un mundo de magia y criaturas fantásticas.',
  },
];

final List<Map<String, dynamic>> _demoSeriesCategories = [
  {'name': 'Crime', 'id': 'crime'},
  {'name': 'Sci-Fi', 'id': 'scifi'},
  {'name': 'Comedia', 'id': 'comedy'},
  {'name': 'Drama', 'id': 'drama'},
  {'name': 'Thriller', 'id': 'thriller'},
  {'name': 'Fantasía', 'id': 'fantasy'},
];

final List<Map<String, dynamic>> _demoFavorites = [
  {
    'title': 'Canal Deportes HD',
    'type': 'Canales',
    'genre': 'Deportes',
    'addedDate': '15 Dic 2024',
    'description': 'Canal de deportes en alta definición con cobertura 24/7.',
  },
  {
    'title': 'Acción Extrema',
    'type': 'Películas',
    'genre': 'Acción',
    'year': '2024',
    'rating': '8.2',
    'addedDate': '14 Dic 2024',
    'description': 'Una película llena de adrenalina con secuencias de acción espectaculares.',
  },
  {
    'title': 'Detective Nocturno',
    'type': 'Series',
    'genre': 'Crime/Drama',
    'year': '2024',
    'rating': '9.1',
    'addedDate': '13 Dic 2024',
    'description': 'Un detective trabaja en casos complejos durante las horas nocturnas.',
  },
  {
    'title': 'Noticias 24H',
    'type': 'Canales',
    'genre': 'Noticias',
    'addedDate': '12 Dic 2024',
    'description': 'Canal de noticias con cobertura continua de eventos mundiales.',
  },
  {
    'title': 'Ciencia Ficción',
    'type': 'Películas',
    'genre': 'Sci-Fi',
    'year': '2024',
    'rating': '8.9',
    'addedDate': '11 Dic 2024',
    'description': 'Una épica aventura en el espacio con efectos visuales impresionantes.',
  },
  {
    'title': 'Aventuras Espaciales',
    'type': 'Series',
    'genre': 'Sci-Fi',
    'year': '2023',
    'rating': '8.7',
    'addedDate': '10 Dic 2024',
    'description': 'Una tripulación explora galaxias lejanas en busca de nuevos mundos.',
  },
];
