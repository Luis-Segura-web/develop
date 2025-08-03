import 'package:equatable/equatable.dart';

/// Estados base para el manejo de contenido
abstract class ContentState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Estado inicial
class ContentInitial extends ContentState {}

/// Estado de carga
class ContentLoading extends ContentState {}

/// Estado de carga exitosa
class ContentLoaded<T> extends ContentState {
  final List<T> items;
  final List<Map<String, dynamic>> categories;

  ContentLoaded({
    required this.items,
    this.categories = const [],
  });

  @override
  List<Object?> get props => [items, categories];
}

/// Estado de error
class ContentError extends ContentState {
  final String message;

  ContentError(this.message);

  @override
  List<Object?> get props => [message];
}

/// Estado de refresco (mantiene datos anteriores)
class ContentRefreshing<T> extends ContentState {
  final List<T> items;
  final List<Map<String, dynamic>> categories;

  ContentRefreshing({
    required this.items,
    this.categories = const [],
  });

  @override
  List<Object?> get props => [items, categories];
}