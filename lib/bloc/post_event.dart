part of 'post_bloc.dart';

sealed class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class GetPosts extends PostEvent {
  const GetPosts();
  @override
  List<Object> get props => [];
}

class GetMorePosts extends PostEvent {
  final int limit;

  GetMorePosts({required this.limit});
  @override
  List<Object> get props => [limit];
}

// ignore: must_be_immutable
class Search extends PostEvent {
  String text;
  Search({required this.text});
  @override
  List<Object> get props => [text];
}

class AddPost extends PostEvent {
  final String body;
  final String type;
  final List<File> images;
  AddPost({required this.body, required this.type, required this.images});

  @override
  List<Object> get props => [body, type, images];
}

class CommentOnPost extends PostEvent {
  final PostComment comment;
  final String id;

  CommentOnPost({required this.comment, required this.id});
  @override
  List<Object> get props => [comment, id];
}

class LikePost extends PostEvent {
  final String id;

  LikePost({required this.id});

  @override
  List<Object> get props => [id];
}
