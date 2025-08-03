# Instrucciones para Copilot - Reproductor IPTV Flutter

<!-- Use this file to provide workspace-specific custom instructions to Copilot. For more details, visit https://code.visualstudio.com/docs/copilot/copilot-customization#_use-a-githubcopilotinstructionsmd-file -->

## Contexto del Proyecto

Este es un reproductor IPTV completo desarrollado en Flutter con las siguientes características:

### Arquitectura Principal
- **Lenguaje**: Español Latino (toda la interfaz y comunicación)
- **Reproductor**: `awesome_video_player` como motor principal
- **Protocolo**: Soporte completo para APIs Xtream Codes
- **Contenido**: Canales en vivo, VOD, series y EPG

### Tecnologías Clave
- `xtream_code_client` para conectividad con servidores
- `awesome_video_player` para reproducción HLS/TS
- `hive` para almacenamiento local
- `flutter_secure_storage` para credenciales

### Funcionalidades Principales
1. **Autenticación múltiple**: Soporte para varios servidores Xtream Codes
2. **Gestión de perfiles**: Múltiples usuarios con PIN parental
3. **Reproductor avanzado**: HLS, TS, subtítulos, PiP, cambio de bitrate
4. **EPG interactivo**: Guía de programación completa
5. **Cache inteligente**: Portadas, datos EPG, historial
6. **Búsqueda unificada**: Across canales, VOD y series

### Estándares de Código
- Toda la interfaz de usuario debe estar en español latino
- Usar arquitectura BLoC para gestión de estado
- Implementar manejo robusto de errores y reconexión
- Seguir Material Design 3 con tema personalizado IPTV
- Optimizar para rendimiento y uso de memoria

### APIs Xtream Codes Soportadas
- `get_live_categories`, `get_live_streams`
- `get_vod_categories`, `get_vod_streams`, `get_vod_info`
- `get_series_categories`, `get_series`, `get_series_info`
- `get_epg`, `get_short_epg`, `get_simple_data_table`

### Notas de Desarrollo
- Priorizar la experiencia de usuario fluida
- Implementar fallbacks para conectividad inestable
- Manejar diferentes formatos de stream (.ts, .m3u8)
- Soporte para control parental con PIN
- Exportar/importar configuraciones y favoritos
