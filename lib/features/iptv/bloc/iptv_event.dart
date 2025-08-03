import 'package:equatable/equatable.dart';

/// Eventos para la gestión de IPTV (categorías y streams en vivo)
abstract class IptvEvent extends Equatable {
  const IptvEvent();

  @override
  List<Object?> get props => [];
}

/// Evento para cargar categorías de canales en vivo
class LoadLiveCategories extends IptvEvent {
  const LoadLiveCategories();
}

/// Evento para cargar canales en vivo de una categoría
class LoadLiveStreams extends IptvEvent {
  final String categoryId;
  const LoadLiveStreams(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}
