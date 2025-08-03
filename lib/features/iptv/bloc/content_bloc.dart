import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repositories/content_repository.dart';
import '../../../models/channel.dart';
import '../../../models/vod_item.dart';
import '../../../models/series_item.dart';
import 'content_event.dart';
import 'content_state.dart';

/// BLoC para manejo de canales en vivo
class ChannelsBloc extends Bloc<ContentEvent, ContentState> {
  final ContentRepository _repository;

  ChannelsBloc({ContentRepository? repository})
      : _repository = repository ?? ContentRepository.instance,
        super(ContentInitial()) {
    on<LoadChannels>(_onLoadChannels);
    on<RefreshChannels>(_onRefreshChannels);
  }

  Future<void> _onLoadChannels(LoadChannels event, Emitter<ContentState> emit) async {
    try {
      emit(ContentLoading());
      
      final channels = await _repository.getChannels(categoryId: event.categoryId);
      final categories = _repository.getLiveCategories();
      
      emit(ContentLoaded<Channel>(
        items: channels,
        categories: categories,
      ));
    } catch (e) {
      emit(ContentError('Error al cargar canales: ${e.toString()}'));
    }
  }

  Future<void> _onRefreshChannels(RefreshChannels event, Emitter<ContentState> emit) async {
    try {
      // Mostrar estado de refresco manteniendo datos anteriores
      if (state is ContentLoaded<Channel>) {
        final currentState = state as ContentLoaded<Channel>;
        emit(ContentRefreshing<Channel>(
          items: currentState.items,
          categories: currentState.categories,
        ));
      }
      
      await _repository.refreshChannels();
      
      final channels = await _repository.getChannels();
      final categories = _repository.getLiveCategories();
      
      emit(ContentLoaded<Channel>(
        items: channels,
        categories: categories,
      ));
    } catch (e) {
      emit(ContentError('Error al refrescar canales: ${e.toString()}'));
    }
  }
}

/// BLoC para manejo de contenido VOD
class VodBloc extends Bloc<ContentEvent, ContentState> {
  final ContentRepository _repository;

  VodBloc({ContentRepository? repository})
      : _repository = repository ?? ContentRepository.instance,
        super(ContentInitial()) {
    on<LoadVodItems>(_onLoadVodItems);
    on<RefreshVodItems>(_onRefreshVodItems);
  }

  Future<void> _onLoadVodItems(LoadVodItems event, Emitter<ContentState> emit) async {
    try {
      emit(ContentLoading());
      
      final vodItems = await _repository.getVodItems(categoryId: event.categoryId);
      final categories = _repository.getVodCategories();
      
      emit(ContentLoaded<VodItem>(
        items: vodItems,
        categories: categories,
      ));
    } catch (e) {
      emit(ContentError('Error al cargar películas: ${e.toString()}'));
    }
  }

  Future<void> _onRefreshVodItems(RefreshVodItems event, Emitter<ContentState> emit) async {
    try {
      if (state is ContentLoaded<VodItem>) {
        final currentState = state as ContentLoaded<VodItem>;
        emit(ContentRefreshing<VodItem>(
          items: currentState.items,
          categories: currentState.categories,
        ));
      }
      
      await _repository.refreshVod();
      
      final vodItems = await _repository.getVodItems();
      final categories = _repository.getVodCategories();
      
      emit(ContentLoaded<VodItem>(
        items: vodItems,
        categories: categories,
      ));
    } catch (e) {
      emit(ContentError('Error al refrescar películas: ${e.toString()}'));
    }
  }
}

/// BLoC para manejo de series
class SeriesBloc extends Bloc<ContentEvent, ContentState> {
  final ContentRepository _repository;

  SeriesBloc({ContentRepository? repository})
      : _repository = repository ?? ContentRepository.instance,
        super(ContentInitial()) {
    on<LoadSeriesItems>(_onLoadSeriesItems);
    on<RefreshSeriesItems>(_onRefreshSeriesItems);
  }

  Future<void> _onLoadSeriesItems(LoadSeriesItems event, Emitter<ContentState> emit) async {
    try {
      emit(ContentLoading());
      
      final seriesItems = await _repository.getSeriesItems(categoryId: event.categoryId);
      final categories = _repository.getSeriesCategories();
      
      emit(ContentLoaded<SeriesItem>(
        items: seriesItems,
        categories: categories,
      ));
    } catch (e) {
      emit(ContentError('Error al cargar series: ${e.toString()}'));
    }
  }

  Future<void> _onRefreshSeriesItems(RefreshSeriesItems event, Emitter<ContentState> emit) async {
    try {
      if (state is ContentLoaded<SeriesItem>) {
        final currentState = state as ContentLoaded<SeriesItem>;
        emit(ContentRefreshing<SeriesItem>(
          items: currentState.items,
          categories: currentState.categories,
        ));
      }
      
      await _repository.refreshSeries();
      
      final seriesItems = await _repository.getSeriesItems();
      final categories = _repository.getSeriesCategories();
      
      emit(ContentLoaded<SeriesItem>(
        items: seriesItems,
        categories: categories,
      ));
    } catch (e) {
      emit(ContentError('Error al refrescar series: ${e.toString()}'));
    }
  }
}