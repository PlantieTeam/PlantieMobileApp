import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:plantie/models/Post.dart';

fit(list) {
  List<Post> posts = [];
  for (var doc in list) {
    List<PostComment> comments = [];
    doc['comments'].forEach((element) {
      comments.add(PostComment(
          body: element['body'],
          owner: PostUser(
              name: element["owner"]["name"],
              email: element["owner"]["email"],
              imageUrl: element["owner"]["imageUrl"])));
    });
    List<String> imageUrls = [];
    doc['imageUrls'].forEach((element) {
      imageUrls.add(element);
    });
    List<String> likes = [];
    doc['likes'].forEach((element) {
      likes.add(element);
    });
    posts.add(Post(
      id: doc.id,
      owner: PostUser(
          name: doc['owner']['name'],
          imageUrl: doc['owner']['imageUrl'],
          email: doc['owner']['email']),
      type: doc['type'],
      body: doc['body'],
      comments: comments,
      imageUrls: imageUrls,
      likes: likes,
      uploadDate: doc['uploadDate'].toDate(),
    ));
  }
  return posts;
}

Future<List<Post>> getPosts(int limit) async {
  final collection = FirebaseFirestore.instance
      .collection('Post')
      // .orderBy("uploadDate", descending: true)
      .limit(limit);
  var querySnapshot = await collection.get();
  List<Post> posts = [];

  posts = fit(querySnapshot.docs);
  print(posts.length);
  return posts;
}

Future<List<String>> uploadFiles(List<File> f) async {
  final storage = FirebaseStorage.instance;
  // storageRef.putFile(f[0]);
  List<String> urls = [];
  for (int i = 0; i < f.length; i++) {
    try {
      final ref = storage.ref(
          "images/${FirebaseAuth.instance.currentUser!.uid}-$i-${DateTime.now().millisecondsSinceEpoch}");
      final uploadTask = ref.putFile(f[i]);
      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();
      urls.add(downloadUrl);
      print('File uploaded. Download URL: $downloadUrl');
      print("Uploaded");
    } catch (e) {
      print(e);
    }
  }
  return urls;
}

Future<void> addPost(Post post) async {
  final collection = FirebaseFirestore.instance.collection('Post');
  await collection.add(post.toJson());
}

Future<void> likePost(String id) async {
  final collection = FirebaseFirestore.instance.collection('Post');
  var doc = collection.doc(id);
  var value = await doc.get();
  if (value['likes'].contains(FirebaseAuth.instance.currentUser!.uid)) {
    await doc.update({
      "likes": value['likes']..remove(FirebaseAuth.instance.currentUser!.uid)
    });
  } else {
    await doc.update(
        {"likes": value['likes']..add(FirebaseAuth.instance.currentUser!.uid)});
  }
}

Future<List<Post>> updatePost(String id, Post post) async {
  final collection = FirebaseFirestore.instance.collection('Post');
  var doc = collection.doc(id);
  await doc.update(post.toJson());
  var posts = await getPosts(5);
  return posts;
}
