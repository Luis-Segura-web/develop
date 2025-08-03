import 'package:flutter/material.dart';
import '../services/xtream_auth_service.dart';
import '../../channels/screens/live_channels_screen.dart';

class TestConnectionScreen extends StatefulWidget {
  const TestConnectionScreen({super.key});

  @override
  State<TestConnectionScreen> createState() => _TestConnectionScreenState();
}

class _TestConnectionScreenState extends State<TestConnectionScreen> {
  final _authService = XtreamAuthService();
  
  // Estados
  bool _isLoading = false;
  String _status = 'Sin conexión';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prueba de Conexión Xtream'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Servidor Demo',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    const Text('URL: gzytv.vip'),
                    const Text('Puerto: 8880'),
                    const Text('Usuario: DMWyCAxket'),
                    const Text('Contraseña: kfvRWYajJJ'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Estado de Conexión',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(_status),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _testConnection,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Probar Conexión'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: (_authService.isConnected && !_isLoading)
                  ? _loadChannels
                  : null,
              child: const Text('Cargar Canales'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: (_authService.isConnected && !_isLoading)
                  ? _loadVod
                  : null,
              child: const Text('Cargar Películas'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: (_authService.isConnected && !_isLoading)
                  ? _loadSeries
                  : null,
              child: const Text('Cargar Series'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: (_authService.isConnected && !_isLoading)
                  ? () => _navigateToChannels()
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text('Ir a Canales en Vivo'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _testConnection() async {
    setState(() {
      _isLoading = true;
      _status = 'Conectando al servidor...';
    });

    try {
      final success = await _authService.connect(
        url: 'http://gzytv.vip',
        port: '8880',
        username: 'DMWyCAxket',
        password: 'kfvRWYajJJ',
      );

      setState(() {
        _status = success
            ? '✅ Conectado exitosamente!'
            : '❌ Error de conexión';
      });
    } catch (e) {
      setState(() {
        _status = '❌ Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadChannels() async {
    setState(() {
      _isLoading = true;
      _status = 'Cargando canales en vivo...';
    });

    try {
      final categories = await _authService.getLiveCategories();
      final channels = await _authService.getLiveStreams();

      setState(() {
        _status = '📺 Cargados ${categories.length} categorías y ${channels.length} canales en vivo';
      });
    } catch (e) {
      setState(() {
        _status = '❌ Error cargando canales: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadVod() async {
    setState(() {
      _isLoading = true;
      _status = 'Cargando películas...';
    });

    try {
      final categories = await _authService.getVodCategories();
      final movies = await _authService.getVodStreams();

      setState(() {
        _status = '🎬 Cargadas ${categories.length} categorías y ${movies.length} películas';
      });
    } catch (e) {
      setState(() {
        _status = '❌ Error cargando películas: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadSeries() async {
    setState(() {
      _isLoading = true;
      _status = 'Cargando series...';
    });

    try {
      final categories = await _authService.getSeriesCategories();
      final series = await _authService.getSeries();

      setState(() {
        _status = '📺 Cargadas ${categories.length} categorías y ${series.length} series';
      });
    } catch (e) {
      setState(() {
        _status = '❌ Error cargando series: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _navigateToChannels() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LiveChannelsScreen(),
      ),
    );
  }
}
