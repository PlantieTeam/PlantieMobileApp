import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantie/bloc/post_bloc.dart';
import 'package:plantie/models/Post.dart';
import 'package:plantie/models/plant.dart';
import 'package:plantie/shared/post_card.dart';

class AddPostConfirm extends StatefulWidget {
  const AddPostConfirm(
      {super.key, required this.body, required this.imagePreview});
  final String body;
  final List<XFile> imagePreview;

  @override
  State<AddPostConfirm> createState() => _AddPostConfirmState();
}

class _AddPostConfirmState extends State<AddPostConfirm> {
  String type = "Tomato";
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final _key = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: const Text("Add Post"),
          actions: [
            TextButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xff47B88A),
                ),
                icon: const Icon(Icons.check),
                label: const Text("Post"),
                onPressed: () {
                  if (!_key.currentState!.validate()) {
                    return;
                  }
                  _key.currentState!.save();

                  BlocProvider.of<PostBloc>(context).add(
                    AddPost(
                      body: widget.body,
                      images:
                          widget.imagePreview.map((e) => File(e.path)).toList(),
                      type: type.toLowerCase(),
                    ),
                  );
                })
          ],
        ),
        body: BlocListener<PostBloc, PostState>(
            listener: (context, state) {
              if (state is PostInitial) {
                setState(() {
                  isLoading = true;
                });
              } else if (state is PostLoaded) {
                setState(() {
                  isLoading = false;
                });
                Navigator.of(context).popUntil((route) => route.isFirst);
                ();
              }
            },
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: Container(
                    height: MediaQuery.of(context).size.height,
                    padding: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                        // color: Colors.white70,
                        ),
                    width: MediaQuery.of(context).size.width,
                    child: Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: _key,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            PostCard(
                                imagePreview: widget.imagePreview,
                                post: Post(
                                  id: "4",
                                  body: widget.body,
                                  imageUrls: widget.imagePreview
                                      .map((e) => e.path)
                                      .toList(),
                                  type: type.toLowerCase(),
                                  uploadDate: DateTime.now(),
                                  owner: PostUser(
                                    name: FirebaseAuth
                                        .instance.currentUser!.displayName!,
                                    imageUrl: FirebaseAuth
                                        .instance.currentUser!.photoURL!,
                                    email: FirebaseAuth
                                        .instance.currentUser!.email!,
                                  ),
                                  likes: [],
                                  comments: [],
                                ),
                                onLikePressed: () {}),
                            DropdownButtonFormField(
                                value: type,
                                hint: const Text("Select Plant"),
                                items: dbPlants
                                    .map((e) => DropdownMenuItem(
                                        value: e.name, child: Text(e.name)))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    type = value.toString();
                                  });
                                })
                          ],
                        ),
                      ),
                    ),
                  ))));
  }
}
