import 'package:equatable/equatable.dart';
import '../../../core/models/category.dart';
import '../../../core/models/stream_item.dart';

/// Estados para IPTV BLoC
abstract class IptvState extends Equatable {
  const IptvState();

  @override
  List<Object?> get props => [];
}

/// Estado inicial
class IptvInitial extends IptvState {}

/// Cargando categorías en vivo
class LiveCategoriesLoading extends IptvState {}

/// Categorías en vivo cargadas
class LiveCategoriesLoaded extends IptvState {
  final List<Category> categories;
  const LiveCategoriesLoaded(this.categories);

  @override
  List<Object?> get props => [categories];
}

/// Cargando canales en vivo
class LiveStreamsLoading extends IptvState {}

/// Canales en vivo cargados
class LiveStreamsLoaded extends IptvState {
  final List<StreamItem> streams;
  const LiveStreamsLoaded(this.streams);

  @override
  List<Object?> get props => [streams];
}

/// Estado de error
class IptvError extends IptvState {
  final String message;
  const IptvError(this.message);

  @override
  List<Object?> get props => [message];
}
