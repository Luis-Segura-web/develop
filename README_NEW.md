# Reproductor IPTV - Flutter

Un reproductor IPTV completo desarrollado en Flutter con soporte total para APIs Xtream Codes. Diseñado para proporcionar una experiencia de usuario fluida y robusta para ver canales en vivo, películas y series.

## 🚀 Características Principales

### 🔐 Autenticación Múltiple
- Soporte para múltiples servidores Xtream Codes
- Gestión segura de credenciales con cifrado
- Cambio rápido entre diferentes proveedores
- Validación automática de tokens y expiración

### 📺 Contenido Completo
- **Canales en Vivo**: Stream HLS y TS con EPG completo
- **Películas (VOD)**: Catálogo completo con información detallada
- **Series**: Gestión de temporadas y episodios
- **EPG Interactivo**: Guía de programación con recordatorios

### 🎥 Reproductor Avanzado
- Motor de reproducción `awesome_video_player` basado en ExoPlayer
- Soporte HLS (.m3u8) y Transport Stream (.ts)
- Cambio dinámico de calidad y bitrate
- Subtítulos SRT/WEBVTT con estilos personalizables
- Picture-in-Picture (PiP) para Android 12+
- Control de velocidad de reproducción (0.5x - 2.0x)

### 👥 Gestión de Perfiles
- Múltiples perfiles de usuario con PIN parental
- Historial de reproducción individual
- Listas de favoritos personalizadas
- Control parental por contenido y clasificación

### 🎨 Interfaz de Usuario
- Diseño Material Design 3 optimizado para TV/móvil
- Tema oscuro especializado para entretenimiento
- Navegación fluida con animaciones suaves
- Búsqueda unificada across todo el contenido
- Grillas adaptativas y responsivas

### 💾 Cache Inteligente
- Cache local de portadas y metadatos
- Almacenamiento offline de EPG
- Optimización de ancho de banda
- Limpieza automática de cache

## 🛠️ Tecnologías Utilizadas

- **Flutter**: Framework principal (SDK 3.8.1+)
- **awesome_video_player**: Motor de reproducción avanzado
- **xtream_code_client**: Cliente especializado para APIs Xtream Codes
- **Hive**: Base de datos local NoSQL para cache
- **BLoC**: Gestión de estado reactiva
- **GoRouter**: Navegación declarativa
- **flutter_secure_storage**: Almacenamiento seguro de credenciales

## 📋 APIs Xtream Codes Soportadas

### Canales en Vivo
- `get_live_categories` - Categorías de canales
- `get_live_streams` - Lista de canales por categoría
- `get_short_epg` - EPG específico de canal

### Video On Demand
- `get_vod_categories` - Categorías de películas
- `get_vod_streams` - Lista de películas
- `get_vod_info` - Información detallada de película

### Series
- `get_series_categories` - Categorías de series
- `get_series` - Lista de series
- `get_series_info` - Información de temporadas y episodios

### EPG y Datos
- `xmltv.php` - EPG completo en formato XMLTV
- `get_simple_data_table` - Datos tabulares con tiempos base64

## 🏗️ Arquitectura del Proyecto

```
lib/
├── core/                     # Configuraciones principales
│   ├── constants.dart        # Constantes de la aplicación
│   └── theme.dart           # Tema y estilos
├── features/                 # Funcionalidades por módulos
│   ├── auth/                # Autenticación y servidores
│   ├── channels/            # Canales en vivo
│   ├── movies/              # Películas y VOD
│   ├── series/              # Series y episodios
│   ├── player/              # Reproductor de video
│   └── settings/            # Configuraciones
├── shared/                   # Componentes compartidos
│   ├── models/              # Modelos de datos
│   ├── widgets/             # Widgets reutilizables
│   └── services/            # Servicios y APIs
└── l10n/                    # Localizaciones (español)
```

## 🚦 Instalación y Uso

### Prerrequisitos
- Flutter SDK 3.8.1 o superior
- Dart 3.0 o superior
- Android Studio / VS Code con extensiones Flutter

### Pasos de Instalación

1. **Instalar dependencias**
   ```bash
   flutter pub get
   ```

2. **Generar archivos Hive**
   ```bash
   flutter packages pub run build_runner build
   ```

3. **Generar localizaciones**
   ```bash
   flutter gen-l10n
   ```

4. **Ejecutar la aplicación**
   ```bash
   flutter run
   ```

## 📱 Configuración de Servidor

Para conectarse a un servidor Xtream Codes:

1. Abrir la aplicación
2. Tocar "Agregar Servidor"
3. Ingresar los datos del servidor:
   - **URL**: Dirección del servidor (ej: `http://tv.ejemplo.com`)
   - **Puerto**: Puerto del servidor (ej: `8080`)
   - **Usuario**: Nombre de usuario proporcionado
   - **Contraseña**: Contraseña del servicio
   - **Nombre**: Alias para identificar la conexión

4. Tocar "Conectar" para validar y guardar

## 🔧 Configuraciones Avanzadas

### Calidad de Video
- **Auto**: Adaptación automática según conexión
- **HD (1080p)**: Calidad alta para conexiones estables
- **SD (720p)**: Calidad media para conexiones limitadas
- **Low (480p)**: Calidad baja para conexiones lentas

### Configuraciones de Cache
- **Tamaño máximo**: 100MB por defecto
- **Expiración EPG**: 2 horas
- **Expiración general**: 6 horas
- **Limpieza automática**: Activada

### Control Parental
- **PIN de 4 dígitos**: Protección de contenido adulto
- **Filtros por edad**: Basado en clasificaciones del proveedor

## 🐛 Solución de Problemas

### Error de Conexión
- Verificar URL y puerto del servidor
- Comprobar conexión a internet
- Validar credenciales con el proveedor

### Problemas de Reproducción
- Verificar formato de stream soportado
- Probar cambio entre HLS (.m3u8) y TS (.ts)
- Reiniciar la aplicación si persiste

### Cache Lleno
- Ir a Configuración > Almacenamiento
- Tocar "Limpiar Cache"
- Reiniciar la aplicación

## 📄 Licencia

Este proyecto está bajo la Licencia MIT.

---

**Nota**: Este reproductor está diseñado para ser usado únicamente con servicios IPTV legítimos y contenido al cual el usuario tiene derecho legal de acceso.
