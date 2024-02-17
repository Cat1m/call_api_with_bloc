import 'package:bloc/bloc.dart';
import 'package:call_api/bloc/photos/photos_state.dart';
import 'package:call_api/model/photo_model.dart';
import 'package:call_api/repository/api_client.dart';
import 'package:call_api/utils/utils.dart';
import 'package:equatable/equatable.dart';

part 'photos_event.dart';

class PhotosBloc extends Bloc<PhotosEvent, PhotosState> {
  final ApiClient _apiClient;

  PhotosBloc(this._apiClient) : super(const PhotosState()) {
    on<PhotosFetched>(fetchPhotos);
  }

  Future<void> fetchPhotos(PhotosFetched event, Emitter<PhotosState> emit) async {
    try {
      final photos = await _apiClient.fetchPhotos();
      emit(state.copyWith(
        status: Status.success,
        photos: photos,
        message: 'success',
      ));
    } catch (error) {
      emit(state.copyWith(
        status: Status.failure,
        message: error.toString(),
      ));
    }
  }
}
