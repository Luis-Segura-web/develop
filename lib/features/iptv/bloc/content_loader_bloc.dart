import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repositories/content_repository.dart';
import '../../../models/service_profile.dart';
import 'content_event.dart';
import 'content_state.dart';

/// BLoC principal para manejo de carga inicial de contenido
class ContentLoaderBloc extends Bloc<ContentEvent, ContentState> {
  final ContentRepository _repository;

  ContentLoaderBloc({ContentRepository? repository})
      : _repository = repository ?? ContentRepository.instance,
        super(ContentInitial()) {
    on<LoadInitialContent>(_onLoadInitialContent);
    on<ClearContentCache>(_onClearContentCache);
  }

  /// Cargar todo el contenido inicial después del login
  Future<void> _onLoadInitialContent(LoadInitialContent event, Emitter<ContentState> emit) async {
    try {
      emit(ContentLoading());
      
      // Cargar todo el contenido desde las APIs Xtream
      await _repository.loadInitialContent();
      
      emit(ContentLoaded(items: [], categories: []));
    } catch (e) {
      emit(ContentError('Error al cargar contenido inicial: ${e.toString()}'));
    }
  }

  /// Limpiar cache de contenido
  Future<void> _onClearContentCache(ClearContentCache event, Emitter<ContentState> emit) async {
    try {
      await _repository.clearCache();
      emit(ContentInitial());
    } catch (e) {
      emit(ContentError('Error al limpiar cache: ${e.toString()}'));
    }
  }

  /// Inicializar repositorio con perfil activo
  Future<void> initializeWithProfile(ServiceProfile profile) async {
    await _repository.initialize(profile);
  }

  @override
  Future<void> close() {
    _repository.dispose();
    return super.close();
  }
}