import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plantie/models/Post.dart';
import 'package:plantie/services/firestore_services.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<GetPosts>((event, emit) async {
      emit(PostInitial());
      // TODO: implement event handler
      var posts = await getPosts();
      emit(PostLoaded(posts: posts));
    });
    on<LikePost>((event, emit) async {
      List<Post> posts = [];
      for (Post post in (state as PostLoaded).posts) {
        List<String> likes = List.from(post.likes);

        if (post.id == event.id) {
          if (likes.contains(FirebaseAuth.instance.currentUser!.uid)) {
            likes.remove(FirebaseAuth.instance.currentUser!.uid);
          } else {
            likes.add(FirebaseAuth.instance.currentUser!.uid);
          }
        }
        posts.add(post.copyWith(likes: likes));
      }
      emit(PostLoaded(posts: posts));
      await likePost(event.id);
    });
    on<CommentOnPost>((event, emit) async {
      List<Post> posts = [];
      for (Post post in (state as PostLoaded).posts) {
        List<PostComment> comments = List.from(post.comments);

        if (post.id == event.id) {
          comments.add(event.comment);
        }
        posts.add(post.copyWith(comments: comments));
      }
      emit(PostLoaded(posts: posts));
      await updatePost(event.id, posts.firstWhere((e) => e.id == event.id));
    });
    on<AddPost>((event, emit) async {
      // TODO: implement event handler
      emit(PostInitial());
      var auth = FirebaseAuth.instance.currentUser;
      var imageUrls = await uploadFiles(event.images);
      await addPost(Post(
          comments: const [],
          type: event.type,
          uploadDate: DateTime.now(),
          id: "",
          body: event.body,
          owner: PostUser(
              name: auth!.displayName!,
              email: auth.email!,
              imageUrl: auth.photoURL!),
          imageUrls: imageUrls,
          likes: const []));

      emit(PostLoaded(posts: await getPosts()));
    });
  }
}
