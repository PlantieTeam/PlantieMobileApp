import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:plantie/models/Post.dart';
import 'package:plantie/models/diagnosis.dart';

fit(list) async {
  List<Post> posts = [];
  for (var doc in list) {
    List<PostComment> comments = [];
    for (var element in doc['comments']) {
      var user = await getUser(element['owner']);
      comments.add(PostComment(
        body: element['body'],
        owner: user,
      ));
    }
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
      owner: await getUser(doc['owner']),
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

Future<PostUser> getUser(String uid) async {
  final doc = await FirebaseFirestore.instance
      .collection('User')
      .where('id', isEqualTo: uid)
      .get();
  return PostUser(
      id: doc.docs[0]['id'],
      name: doc.docs[0]['name'],
      email: doc.docs[0]['email'],
      imageUrl: doc.docs[0]['imageUrl']);
}

Future<void> addUser(PostUser user) async {
  var doc = FirebaseFirestore.instance.collection("User");
  var isUser = await doc.where('id', isEqualTo: user.id).get();

  if (isUser.docs.isEmpty) {
    await doc.add(user.toJson());
  }
}

Future<List<Post>> getPosts(int limit) async {
  final collection = FirebaseFirestore.instance
      .collection('Post')
      .orderBy("uploadDate", descending: true)
      .limit(limit);
  var querySnapshot = await collection.get();
  List<Post> posts = [];

  posts = await fit(querySnapshot.docs);
  return posts;
}

Future<List<Post>> search(String text) async {
  if (text == "") {
    return await getPosts(5);
  }
  final collection = await FirebaseFirestore.instance.collection('Post').get();
  var querySnapshot = await collection.docs.where((e) {
    return e['body']
            .toString()
            .toLowerCase()
            .contains(text.toLowerCase().trim()) ||
        e['type'].toString().toLowerCase().contains(text.toLowerCase().trim());
  });
  List<Post> posts = [];
  posts = await fit(querySnapshot);
  print(text);
  return posts;
}

Future<List<String>> uploadFiles(List<File> f) async {
  final storage = FirebaseStorage.instance;
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

Future<void> updateUserInfo(String email, String name) async {
  final collection = FirebaseFirestore.instance.collection('User');

  var doc = await collection.where("email", isEqualTo: email).get();
  // ignore: avoid_function_literals_in_foreach_calls
  doc.docs.forEach((doc) async {
    await doc.reference.update({"name": name});
  });
}

Future<void> addDiagnosis(Diagnosis diagnosis) async {
  final collection = FirebaseFirestore.instance.collection('Diagnosis');
  await collection.add(diagnosis.toJson());
}

Future<List<Diagnosis>> getDiagnosis() async {
  final collection = FirebaseFirestore.instance
      .collection('Diagnosis')
      .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid);
  var querySnapshot = await collection.get();
  List<Diagnosis> diagnosis = [];
  querySnapshot.docs.forEach((element) {
    diagnosis.add(Diagnosis(
      uid: element['uid'],
      prediction: element['prediction'],
      dateTime: element['dateTime'].toDate(),
      path: element['path'],
    ));
  });
  return diagnosis;
}
