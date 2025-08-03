import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Servicio para gestionar favoritos del usuario
class FavoritesService {
  static const String _favoritesKey = 'user_favorites';
  static FavoritesService? _instance;
  
  FavoritesService._internal();
  
  static FavoritesService get instance {
    _instance ??= FavoritesService._internal();
    return _instance!;
  }

  /// Obtener lista de favoritos
  Future<List<String>> getFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesJson = prefs.getStringList(_favoritesKey) ?? [];
      return favoritesJson;
    } catch (e) {
      print('Error al obtener favoritos: $e');
      return [];
    }
  }

  /// Verificar si un canal es favorito
  Future<bool> isFavorite(String streamId) async {
    try {
      final favorites = await getFavorites();
      return favorites.contains(streamId);
    } catch (e) {
      print('Error al verificar favorito: $e');
      return false;
    }
  }

  /// Agregar canal a favoritos
  Future<bool> addToFavorites(Map<String, dynamic> channel) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favorites = await getFavorites();
      final streamId = channel['stream_id']?.toString() ?? '';
      
      if (streamId.isEmpty || favorites.contains(streamId)) {
        return false; // Ya existe o ID inválido
      }
      
      favorites.add(streamId);
      await prefs.setStringList(_favoritesKey, favorites);
      
      // Guardar datos del canal también para referencia futura
      await _saveChannelData(channel);
      
      return true;
    } catch (e) {
      print('Error al agregar a favoritos: $e');
      return false;
    }
  }

  /// Remover canal de favoritos
  Future<bool> removeFromFavorites(String streamId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favorites = await getFavorites();
      
      if (!favorites.contains(streamId)) {
        return false; // No existe
      }
      
      favorites.remove(streamId);
      await prefs.setStringList(_favoritesKey, favorites);
      
      // Remover datos del canal
      await _removeChannelData(streamId);
      
      return true;
    } catch (e) {
      print('Error al remover de favoritos: $e');
      return false;
    }
  }

  /// Alternar estado de favorito
  Future<bool> toggleFavorite(Map<String, dynamic> channel) async {
    final streamId = channel['stream_id']?.toString() ?? '';
    final isFav = await isFavorite(streamId);
    
    if (isFav) {
      return await removeFromFavorites(streamId);
    } else {
      return await addToFavorites(channel);
    }
  }

  /// Obtener canales favoritos completos
  Future<List<Map<String, dynamic>>> getFavoriteChannels() async {
    try {
      final favoriteIds = await getFavorites();
      final List<Map<String, dynamic>> channels = [];
      
      for (final streamId in favoriteIds) {
        final channelData = await _getChannelData(streamId);
        if (channelData != null) {
          channels.add(channelData);
        }
      }
      
      return channels;
    } catch (e) {
      print('Error al obtener canales favoritos: $e');
      return [];
    }
  }

  /// Limpiar todos los favoritos
  Future<void> clearFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_favoritesKey);
      await prefs.remove('favorite_channels_data');
    } catch (e) {
      print('Error al limpiar favoritos: $e');
    }
  }

  /// Guardar datos del canal para referencia
  Future<void> _saveChannelData(Map<String, dynamic> channel) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final streamId = channel['stream_id']?.toString() ?? '';
      final channelsData = prefs.getString('favorite_channels_data') ?? '{}';
      final Map<String, dynamic> allChannels = json.decode(channelsData);
      
      allChannels[streamId] = {
        'stream_id': channel['stream_id'],
        'name': channel['name'],
        'stream_icon': channel['stream_icon'],
        'epg_channel_id': channel['epg_channel_id'],
        'added_at': DateTime.now().toIso8601String(),
      };
      
      await prefs.setString('favorite_channels_data', json.encode(allChannels));
    } catch (e) {
      print('Error al guardar datos del canal: $e');
    }
  }

  /// Obtener datos de un canal específico
  Future<Map<String, dynamic>?> _getChannelData(String streamId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final channelsData = prefs.getString('favorite_channels_data') ?? '{}';
      final Map<String, dynamic> allChannels = json.decode(channelsData);
      
      return allChannels[streamId];
    } catch (e) {
      print('Error al obtener datos del canal: $e');
      return null;
    }
  }

  /// Remover datos de un canal específico
  Future<void> _removeChannelData(String streamId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final channelsData = prefs.getString('favorite_channels_data') ?? '{}';
      final Map<String, dynamic> allChannels = json.decode(channelsData);
      
      allChannels.remove(streamId);
      await prefs.setString('favorite_channels_data', json.encode(allChannels));
    } catch (e) {
      print('Error al remover datos del canal: $e');
    }
  }

  /// Obtener estadísticas de favoritos
  Future<Map<String, dynamic>> getFavoritesStats() async {
    try {
      final favorites = await getFavorites();
      final channels = await getFavoriteChannels();
      
      return {
        'total_favorites': favorites.length,
        'channels_with_data': channels.length,
        'last_updated': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      print('Error al obtener estadísticas: $e');
      return {
        'total_favorites': 0,
        'channels_with_data': 0,
        'last_updated': DateTime.now().toIso8601String(),
      };
    }
  }
}