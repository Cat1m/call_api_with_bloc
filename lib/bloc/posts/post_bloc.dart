import 'package:bloc/bloc.dart';
import 'package:call_api/bloc/posts/post_event.dart';
import 'package:call_api/bloc/posts/post_state.dart';
import 'package:call_api/model/posts_model.dart';
import 'package:call_api/repository/post_repository.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostRepository postRepository = PostRepository();
  List<PostModel> tempPostList = [];

  PostBloc() : super(const PostState()) {
    on<PostFetched>(fetchPostApi);
  }

  Future<void> fetchPostApi(PostFetched event, Emitter<PostState> emit) async {
    await postRepository.fetchPost().then((value) {
      emit(state.copyWith(
        status: PostStatus.success,
        posts: value,
        message: 'success',
      ));
    }).onError((error, stackTrace) {
      emit(state.copyWith(
        status: PostStatus.failure,
        message: error.toString(),
      ));
    });
  }
}
