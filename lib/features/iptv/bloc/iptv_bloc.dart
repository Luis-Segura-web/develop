import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/xtream_api_service.dart';
import 'iptv_event.dart';
import 'iptv_state.dart';

/// BLoC para gestionar IPTV (categorías y streams en vivo)
class IptvBloc extends Bloc<IptvEvent, IptvState> {
  final XtreamApiService _apiService;

  IptvBloc({required XtreamApiService apiService})
      : _apiService = apiService,
        super(IptvInitial()) {
    on<LoadLiveCategories>(_onLoadLiveCategories);
    on<LoadLiveStreams>(_onLoadLiveStreams);
  }

  Future<void> _onLoadLiveCategories(
      LoadLiveCategories event, Emitter<IptvState> emit) async {
    emit(LiveCategoriesLoading());
    try {
      final categories = await _apiService.getLiveCategories();
      emit(LiveCategoriesLoaded(categories));
    } catch (e) {
      emit(IptvError('Error al cargar categorías: ${e.toString()}'));
    }
  }

  Future<void> _onLoadLiveStreams(
      LoadLiveStreams event, Emitter<IptvState> emit) async {
    emit(LiveStreamsLoading());
    try {
      final streams =
          await _apiService.getLiveStreams(event.categoryId);
      emit(LiveStreamsLoaded(streams));
    } catch (e) {
      emit(IptvError('Error al cargar streams: ${e.toString()}'));
    }
  }
}
