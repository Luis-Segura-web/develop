import 'package:flutter/material.dart';
import '../services/xtream_auth_service.dart';

class TestConnectionScreen extends StatefulWidget {
  const TestConnectionScreen({super.key});

  @override
  State<TestConnectionScreen> createState() => _TestConnectionScreenState();
}

class _TestConnectionScreenState extends State<TestConnectionScreen> {
  final _authService = XtreamAuthService();
  bool _isLoading = false;
  String _status = 'Listo para probar conexión';
  bool _isConnected = false;

  // Controladores de texto
  final _serverController = TextEditingController(text: 'http://gzytv.vip');
  final _portController = TextEditingController(text: '8880');
  final _usernameController = TextEditingController(text: 'DMWyCAxket');
  final _passwordController = TextEditingController(text: 'kfvRWYajJJ');

  @override
  void dispose() {
    _serverController.dispose();
    _portController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _testConnection() async {
    setState(() {
      _isLoading = true;
      _status = 'Conectando al servidor...';
    });

    try {
      final success = await _authService.connect(
        url: _serverController.text.trim(),
        port: _portController.text.trim(),
        username: _usernameController.text.trim(),
        password: _passwordController.text.trim(),
      );

      setState(() {
        _isConnected = success;
        _status = success
            ? '✅ Conexión exitosa!\nServidor: ${_authService.currentServer?.url}\nUsuario: ${_authService.currentServer?.username}'
            : '❌ Error: No se pudo conectar al servidor';
      });

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('¡Conexión exitosa al servidor IPTV!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isConnected = false;
        _status = '❌ Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _testCategories() async {
    if (!_authService.isConnected) return;

    setState(() {
      _isLoading = true;
      _status = 'Obteniendo categorías...';
    });

    try {
      final categories = await _authService.getLiveCategories();
      
      setState(() {
        _status = '📺 Categorías encontradas: ${categories.length}\n'
            'Ejemplos:\n${categories.take(3).map((c) => '- ${c['category_name'] ?? 'Sin nombre'}').join('\n')}';
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${categories.length} categorías cargadas'),
            backgroundColor: Colors.blue,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _status = '❌ Error obteniendo categorías: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _disconnect() {
    _authService.disconnect();
    setState(() {
      _isConnected = false;
      _status = 'Desconectado del servidor';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prueba Xtream Code Client'),
        backgroundColor: const Color(0xFF1E88E5),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Estado de conexión
            Card(
              color: _isConnected ? Colors.green.shade50 : Colors.red.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Icon(
                      _isConnected ? Icons.wifi : Icons.wifi_off,
                      size: 48,
                      color: _isConnected ? Colors.green : Colors.red,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _isConnected ? 'CONECTADO' : 'DESCONECTADO',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _isConnected ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Formulario
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Datos del Servidor Xtream',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    
                    TextField(
                      controller: _serverController,
                      decoration: const InputDecoration(
                        labelText: 'URL del Servidor',
                        prefixIcon: Icon(Icons.link),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    TextField(
                      controller: _portController,
                      decoration: const InputDecoration(
                        labelText: 'Puerto',
                        prefixIcon: Icon(Icons.settings_ethernet),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Usuario',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Contraseña',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Botones
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _testConnection,
                    icon: _isLoading 
                        ? const SizedBox(
                            width: 20, height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.wifi),
                    label: const Text('Conectar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E88E5),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(16),
                    ),
                  ),
                ),
                
                if (_isConnected) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _isLoading ? null : _testCategories,
                      icon: const Icon(Icons.list),
                      label: const Text('Probar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.all(16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: _disconnect,
                    icon: const Icon(Icons.wifi_off),
                    label: const Text('Desconectar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(12),
                    ),
                  ),
                ],
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Estado
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Estado de la Conexión',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _status,
                      style: const TextStyle(fontSize: 14),
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
}
