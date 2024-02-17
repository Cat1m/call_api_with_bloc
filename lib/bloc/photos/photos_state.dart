import 'package:call_api/model/photo_model.dart';
import 'package:call_api/utils/utils.dart';
import 'package:equatable/equatable.dart';

class PhotosState extends Equatable {
  final Status status;
  final List<PhotoModel> photos;
  final String message;
  const PhotosState({
    this.status = Status.initial,
    this.photos = const <PhotoModel>[],
    this.message = '',
  });

  PhotosState copyWith({
    Status? status,
    List<PhotoModel>? photos,
    String? message,
  }) {
    return PhotosState(
      status: status ?? this.status,
      photos: photos ?? this.photos,
      message: message ?? this.message,
    );
  }

  @override
  String toString() {
    return '''PhotosState { status: $status, hasReachedMax: $message, posts: ${photos.length} }''';
  }

  @override
  List<Object> get props => [
        status,
        photos,
        message,
      ];
}





// import 'package:call_api/model/posts_model.dart';
// import 'package:call_api/utils/utils.dart';
// import 'package:equatable/equatable.dart';

// class PostState extends Equatable {
//   const PostState({
//     this.status = Status.initial,
//     this.posts = const <PostModel>[],
//     this.message = '',
//   });

//   final Status status;
//   final List<PostModel> posts;
//   final String message;

//   PostState copyWith({
//     Status? status,
//     List<PostModel>? posts,
//     String? message,
//   }) {
//     return PostState(
//       status: status ?? this.status,
//       posts: posts ?? this.posts,
//       message: message ?? this.message,
//     );
//   }

//   @override
//   String toString() {
//     return '''PostState { status: $status, hasReachedMax: $message, posts: ${posts.length} }''';
//   }

//   @override
//   List<Object> get props => [
//         status,
//         posts,
//         message,
//       ];
// }
