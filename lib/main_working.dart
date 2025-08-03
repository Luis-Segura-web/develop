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
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Buscar Contenido'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Buscar canales, películas o series...',
                  hintText: 'Escribe aquí para buscar',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  searchQuery = value;
                },
                autofocus: true,
              ),
              const SizedBox(height: 16),
              const Text(
                'Sugerencias: Ingresa el nombre del canal, película o serie que deseas encontrar.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
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
                  _performSearch(searchQuery);
                }
              },
              child: const Text('Buscar'),
            ),
          ],
        );
      },
    );
  }

  /// Realizar búsqueda
  void _performSearch(String query) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Buscando: "$query"'),
        action: SnackBarAction(
          label: 'Ver resultados',
          onPressed: () {
            // En una implementación real, navegaría a una pantalla de resultados
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Se encontraron resultados para "$query"'),
                duration: const Duration(seconds: 2),
              ),
            );
          },
        ),
      ),
    );
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

class MoviesPage extends StatelessWidget {
  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Películas Populares',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.7,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: _demoMovies.length,
              itemBuilder: (context, index) {
                final movie = _demoMovies[index];
                return Card(
                  child: InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Reproduciendo: ${movie['title']}')),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(4),
                              ),
                            ),
                            child: const Icon(
                              Icons.movie,
                              size: 48,
                              color: Color(0xFF2196F3),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movie['title'] as String,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  movie['year'] as String,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
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
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SeriesPage extends StatelessWidget {
  const SeriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.tv,
            size: 64,
            color: Color(0xFF9C27B0),
          ),
          SizedBox(height: 16),
          Text(
            'Series',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'En construcción...',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite,
            size: 64,
            color: Color(0xFFFFD700),
          ),
          SizedBox(height: 16),
          Text(
            'Favoritos',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Agrega contenido a tus favoritos',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const ListTile(
          leading: Icon(Icons.account_circle, color: Color(0xFF1E88E5)),
          title: Text('Gestión de Servidores'),
          subtitle: Text('Agregar, editar y eliminar conexiones'),
        ),
        const Divider(),
        const ListTile(
          leading: Icon(Icons.video_settings, color: Color(0xFF1E88E5)),
          title: Text('Configuración de Video'),
          subtitle: Text('Calidad, subtítulos y reproducción'),
        ),
        const Divider(),
        const ListTile(
          leading: Icon(Icons.child_care, color: Color(0xFF1E88E5)),
          title: Text('Control Parental'),
          subtitle: Text('PIN y restricciones de contenido'),
        ),
        const Divider(),
        const ListTile(
          leading: Icon(Icons.storage, color: Color(0xFF1E88E5)),
          title: Text('Almacenamiento'),
          subtitle: Text('Cache y datos locales'),
        ),
        const Divider(),
        const ListTile(
          leading: Icon(Icons.info, color: Color(0xFF1E88E5)),
          title: Text('Acerca de'),
          subtitle: Text('Reproductor IPTV v1.0.0'),
        ),
      ],
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
  {'title': 'Acción Extrema', 'year': '2024'},
  {'title': 'Comedia Romántica', 'year': '2023'},
  {'title': 'Thriller Nocturno', 'year': '2024'},
  {'title': 'Drama Familiar', 'year': '2023'},
  {'title': 'Ciencia Ficción', 'year': '2024'},
  {'title': 'Horror Psicológico', 'year': '2023'},
];
