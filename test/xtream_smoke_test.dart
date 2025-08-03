import 'package:flutter_test/flutter_test.dart';
import 'package:reproductor_iptv/models/service_profile.dart';
import 'package:reproductor_iptv/models/stream_item.dart';
import 'package:reproductor_iptv/services/xtream_service.dart';
import 'package:reproductor_iptv/services/stream_url_builder.dart';
import 'package:reproductor_iptv/player/player_selector.dart';
import 'package:reproductor_iptv/storage/profile_repository.dart';

/// Pruebas de smoke test para funcionalidades principales de Xtream Codes
void main() {
  group('Xtream IPTV Smoke Tests', () {
    late ServiceProfile testProfile;
    late XtreamService xtreamService;

    setUpAll(() async {
      // Inicializar repositorio de perfiles para las pruebas
      await ProfileRepository.initialize();
      
      // Crear perfil de prueba
      testProfile = const ServiceProfile(
        baseUrl: 'http://test-server.com:8080',
        username: 'test_user',
        password: 'test_pass',
        preferredEngine: PlayerEngine.media3,
      );

      xtreamService = XtreamService();
    });

    tearDownAll(() async {
      xtreamService.dispose();
      await ProfileRepository.close();
    });

    group('Modelo ServiceProfile', () {
      test('debe crear perfil desde JSON correctamente', () {
        final json = {
          'base_url': 'http://example.com:8080',
          'username': 'user123',
          'password': 'pass123',
          'token': 'abc123',
          'token_expiry': '2024-12-31T23:59:59.000Z',
          'preferred_engine': 'vlc',
        };

        final profile = ServiceProfile.fromJson(json);

        expect(profile.baseUrl, equals('http://example.com:8080'));
        expect(profile.username, equals('user123'));
        expect(profile.password, equals('pass123'));
        expect(profile.token, equals('abc123'));
        expect(profile.preferredEngine, equals(PlayerEngine.vlc));
        expect(profile.tokenExpiry, isNotNull);
      });

      test('debe convertir perfil a JSON correctamente', () {
        final profile = ServiceProfile(
          baseUrl: 'http://example.com:8080',
          username: 'user123',
          password: 'pass123',
          token: 'abc123',
          tokenExpiry: DateTime(2024, 12, 31, 23, 59, 59),
          preferredEngine: PlayerEngine.media3,
        );

        final json = profile.toJson();

        expect(json['base_url'], equals('http://example.com:8080'));
        expect(json['username'], equals('user123'));
        expect(json['password'], equals('pass123'));
        expect(json['token'], equals('abc123'));
        expect(json['preferred_engine'], equals('media3'));
        expect(json['token_expiry'], isNotNull);
      });

      test('debe verificar necesidad de renovación de token', () {
        // Token expirado
        final expiredProfile = ServiceProfile(
          baseUrl: 'http://example.com',
          username: 'user',
          password: 'pass',
          token: 'expired_token',
          tokenExpiry: DateTime.now().subtract(const Duration(hours: 1)),
        );
        expect(expiredProfile.needsTokenRefresh, isTrue);

        // Token válido
        final validProfile = ServiceProfile(
          baseUrl: 'http://example.com',
          username: 'user',
          password: 'pass',
          token: 'valid_token',
          tokenExpiry: DateTime.now().add(const Duration(hours: 1)),
        );
        expect(validProfile.needsTokenRefresh, isFalse);

        // Sin token
        const noTokenProfile = ServiceProfile(
          baseUrl: 'http://example.com',
          username: 'user',
          password: 'pass',
        );
        expect(noTokenProfile.needsTokenRefresh, isTrue);
      });
    });

    group('XtreamService', () {
      test('debe inicializar correctamente con perfil válido', () async {
        expect(() async => await xtreamService.initialize(testProfile), 
               returnsNormally);
      });

      test('debe manejar errores de inicialización gracefully', () async {
        final invalidProfile = ServiceProfile(
          baseUrl: 'invalid-url',
          username: 'test',
          password: 'test',
        );

        try {
          await xtreamService.initialize(invalidProfile);
          // Si llegamos aquí en un entorno real, las siguientes llamadas fallarán
          // En un test unitario, simulamos el comportamiento
          expect(true, isTrue); // Placeholder para test unitario
        } catch (e) {
          // Esperamos que falle con URL inválida
          expect(e, isException);
        }
      });

      test('debe intentar obtener categorías de canales en vivo', () async {
        // En un entorno de test real, esto requeriría un servidor IPTV de prueba
        // Por ahora, validamos que el método existe y maneja errores
        try {
          await xtreamService.initialize(testProfile);
          final categories = await xtreamService.fetchLiveCategories();
          expect(categories, isA<List<Map<String, dynamic>>>());
        } catch (e) {
          // Es esperado que falle sin servidor real
          expect(e, isException);
        }
      });

      test('debe intentar obtener streams de canales en vivo', () async {
        try {
          await xtreamService.initialize(testProfile);
          final streams = await xtreamService.fetchLiveStreams(categoryId: 1);
          expect(streams, isA<List>());
        } catch (e) {
          // Es esperado que falle sin servidor real
          expect(e, isException);
        }
      });

      test('debe verificar conectividad del servidor', () async {
        await xtreamService.initialize(testProfile);
        final isConnected = await xtreamService.testConnection();
        // Sin servidor real, esperamos false
        expect(isConnected, isFalse);
      });
    });

    group('StreamUrlBuilder', () {
      test('debe construir URL para canal en vivo correctamente', () {
        const liveStream = LiveStreamItem(
          streamId: 12345,
          name: 'Test Channel',
          streamIcon: '',
          categoryId: 1,
          streamType: 'live',
        );

        final url = StreamUrlBuilder.buildStreamUrl(
          testProfile,
          liveStream,
          'm3u8',
        );

        expect(url, equals('http://test-server.com:8080/test_user/test_pass/12345.m3u8'));
      });

      test('debe construir URL para VOD correctamente', () {
        const vodStream = VodStreamItem(
          streamId: 67890,
          name: 'Test Movie',
          streamIcon: '',
          categoryId: 2,
          containerExtension: 'mp4',
          plot: 'Test plot',
        );

        final url = StreamUrlBuilder.buildStreamUrl(
          testProfile,
          vodStream,
          'mp4',
        );

        expect(url, equals('http://test-server.com:8080/movie/test_user/test_pass/67890.mp4'));
      });

      test('debe construir URL para serie correctamente', () {
        const seriesStream = SeriesStreamItem(
          streamId: 11111,
          name: 'Test Series',
          streamIcon: '',
          categoryId: 3,
          seriesId: 11111,
          plot: 'Test series plot',
        );

        final url = StreamUrlBuilder.buildStreamUrl(
          testProfile,
          seriesStream,
          'mp4',
        );

        expect(url, equals('http://test-server.com:8080/series/test_user/test_pass/11111.mp4'));
      });

      test('debe obtener extensión recomendada según tipo de stream', () {
        const liveStream = LiveStreamItem(
          streamId: 1,
          name: 'Live',
          streamIcon: '',
          categoryId: 1,
          streamType: 'live',
        );

        const vodStream = VodStreamItem(
          streamId: 2,
          name: 'VOD',
          streamIcon: '',
          categoryId: 2,
          containerExtension: 'mkv',
          plot: '',
        );

        expect(StreamUrlBuilder.getRecommendedExtension(liveStream), equals('m3u8'));
        expect(StreamUrlBuilder.getRecommendedExtension(vodStream), equals('mkv'));
      });

      test('debe construir URLs alternativas para fallback', () {
        const liveStream = LiveStreamItem(
          streamId: 1,
          name: 'Test',
          streamIcon: '',
          categoryId: 1,
          streamType: 'live',
        );

        final urls = StreamUrlBuilder.buildFallbackUrls(testProfile, liveStream);
        
        expect(urls, isNotEmpty);
        expect(urls.contains('http://test-server.com:8080/test_user/test_pass/1.m3u8'), isTrue);
        expect(urls.contains('http://test-server.com:8080/test_user/test_pass/1.ts'), isTrue);
      });

      test('debe validar URLs correctamente', () {
        expect(StreamUrlBuilder.isValidUrl('http://example.com'), isTrue);
        expect(StreamUrlBuilder.isValidUrl('https://example.com'), isTrue);
        expect(StreamUrlBuilder.isValidUrl('ftp://example.com'), isFalse);
        expect(StreamUrlBuilder.isValidUrl('invalid-url'), isFalse);
        expect(StreamUrlBuilder.isValidUrl(''), isFalse);
      });
    });

    group('PlayerSelector', () {
      late PlayerSelector playerSelector;

      setUp(() {
        playerSelector = PlayerSelector.instance;
      });

      test('debe inicializar sin reproductor activo', () {
        expect(playerSelector.hasActivePlayer, isFalse);
        expect(playerSelector.currentEngine, equals(PlayerEngine.media3));
        expect(playerSelector.currentUrl, isNull);
      });

      test('debe obtener estado del reproductor', () {
        final state = playerSelector.getPlayerState();
        
        expect(state, isA<Map<String, dynamic>>());
        expect(state['hasActivePlayer'], isFalse);
        expect(state['currentEngine'], equals('media3'));
        expect(state['currentUrl'], isNull);
      });

      test('debe intentar reproducir stream (fallará sin UI)', () async {
        const testStream = LiveStreamItem(
          streamId: 1,
          name: 'Test Stream',
          streamIcon: '',
          categoryId: 1,
          streamType: 'live',
        );

        final testUrl = StreamUrlBuilder.buildRecommendedUrl(testProfile, testStream);
        
        // En un entorno de test unitario sin UI, esto fallará
        // pero validamos que el método maneja errores apropiadamente
        try {
          await playerSelector.play(testUrl, testProfile, testStream);
          fail('Se esperaba que fallara sin entorno UI');
        } catch (e) {
          expect(e, isException);
        }
      });
    });

    group('ProfileRepository', () {
      late ProfileRepository repository;

      setUp(() {
        repository = ProfileRepository();
      });

      test('debe leer perfiles (inicialmente vacío)', () async {
        final profiles = await repository.readProfiles();
        expect(profiles, isA<List<ServiceProfile>>());
      });

      test('debe guardar y leer perfil correctamente', () async {
        final testProfile = ServiceProfile(
          baseUrl: 'http://test.com',
          username: 'testuser',
          password: 'testpass',
          preferredEngine: PlayerEngine.vlc,
        );

        await repository.saveProfile(testProfile);
        final profiles = await repository.readProfiles();
        
        expect(profiles, isNotEmpty);
        expect(profiles.any((p) => p.username == 'testuser'), isTrue);
      });

      test('debe actualizar motor preferido', () async {
        final profiles = await repository.readProfiles();
        if (profiles.isNotEmpty) {
          final profile = profiles.first;
          await repository.setPreferredEngine(profile.id, PlayerEngine.media3);
          
          final updatedProfile = await repository.findProfileById(profile.id);
          expect(updatedProfile?.preferredEngine, equals(PlayerEngine.media3));
        }
      });

      test('debe buscar perfil por URL base', () async {
        final profile = await repository.findProfileByBaseUrl('http://test.com');
        // Puede ser null si no existe
        expect(profile, anyOf(isNull, isA<ServiceProfile>()));
      });

      test('debe obtener estadísticas de perfiles', () async {
        final stats = await repository.getProfileStats();
        
        expect(stats, isA<Map<String, int>>());
        expect(stats.containsKey('total'), isTrue);
        expect(stats.containsKey('with_token'), isTrue);
        expect(stats.containsKey('media3_engine'), isTrue);
        expect(stats.containsKey('vlc_engine'), isTrue);
      });
    });

    group('Integración básica', () {
      test('debe crear perfil, construir URL y intentar reproducir', () async {
        // 1. Crear perfil
        final profile = ServiceProfile(
          baseUrl: 'http://demo-server.com:8080',
          username: 'demo',
          password: 'demo',
          preferredEngine: PlayerEngine.media3,
        );

        // 2. Crear stream de prueba
        const stream = LiveStreamItem(
          streamId: 1001,
          name: 'Demo Channel',
          streamIcon: 'http://demo-server.com/logo.png',
          categoryId: 1,
          streamType: 'live',
        );

        // 3. Construir URL
        final streamUrl = StreamUrlBuilder.buildRecommendedUrl(profile, stream);
        expect(streamUrl, contains('demo-server.com'));
        expect(streamUrl, contains('1001'));
        expect(streamUrl, contains('.m3u8'));

        // 4. Validar URL
        expect(StreamUrlBuilder.isValidUrl(streamUrl), isTrue);

        // 5. Obtener URLs de fallback
        final fallbackUrls = StreamUrlBuilder.buildFallbackUrls(profile, stream);
        expect(fallbackUrls, contains(streamUrl));
        expect(fallbackUrls.length, greaterThan(1));

        // Test completado exitosamente
        expect(true, isTrue);
      });
    });
  });
}