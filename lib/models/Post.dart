import 'package:equatable/equatable.dart';

class PostUser {
  final String name;
  final String email;
  final String imageUrl;
  final String id;
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email, 'imageUrl': imageUrl};
  }

  PostUser(
      {required this.name,
      required this.email,
      required this.imageUrl,
      required this.id});

  copyWith({
    String? name,
  }) {
    return PostUser(
        name: name ?? this.name, email: email, imageUrl: imageUrl, id: id);
  }
}

class PostComment extends Equatable {
  final String body;
  final PostUser owner;
  Map<String, dynamic> toJson() {
    return {
      'body': body,
      'owner': owner.id,
    };
  }

  const PostComment({required this.body, required this.owner});
  copyWith({PostUser? owner, String? body}) {
    return PostComment(body: body ?? this.body, owner: owner ?? this.owner);
  }

  @override
  List<Object?> get props => [body, owner];
}

class Post extends Equatable {
  final String id;
  final String body;
  final PostUser owner;
  final List<String> imageUrls;
  final List<String> likes;
  final List<PostComment> comments;
  final String type;
  final DateTime uploadDate;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'body': body,
      'owner': owner.id,
      'imageUrls': imageUrls,
      'likes': likes,
      'comments': comments.map((e) => e.toJson()).toList(),
      'type': type,
      'uploadDate': uploadDate
    };
  }

  copyWith({List<String>? likes, List<PostComment>? comments}) {
    return Post(
        id: id,
        body: body,
        owner: owner,
        imageUrls: imageUrls,
        likes: likes ?? this.likes,
        comments: comments ?? this.comments,
        type: type,
        uploadDate: uploadDate);
  }

  const Post(
      {required this.comments,
      required this.type,
      required this.uploadDate,
      required this.id,
      required this.body,
      required this.owner,
      required this.imageUrls,
      required this.likes});
  @override
  List<Object?> get props =>
      [id, body, owner, imageUrls, likes, comments, type, uploadDate];
}
