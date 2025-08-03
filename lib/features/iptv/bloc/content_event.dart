import 'package:equatable/equatable.dart';

/// Eventos para el manejo de contenido
abstract class ContentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Cargar contenido inicial
class LoadInitialContent extends ContentEvent {}

/// Cargar canales
class LoadChannels extends ContentEvent {
  final int? categoryId;
  
  LoadChannels({this.categoryId});
  
  @override
  List<Object?> get props => [categoryId];
}

/// Cargar películas VOD
class LoadVodItems extends ContentEvent {
  final int? categoryId;
  
  LoadVodItems({this.categoryId});
  
  @override
  List<Object?> get props => [categoryId];
}

/// Cargar series
class LoadSeriesItems extends ContentEvent {
  final int? categoryId;
  
  LoadSeriesItems({this.categoryId});
  
  @override
  List<Object?> get props => [categoryId];
}

/// Refrescar canales
class RefreshChannels extends ContentEvent {}

/// Refrescar VOD
class RefreshVodItems extends ContentEvent {}

/// Refrescar series
class RefreshSeriesItems extends ContentEvent {}

/// Limpiar cache
class ClearContentCache extends ContentEvent {}