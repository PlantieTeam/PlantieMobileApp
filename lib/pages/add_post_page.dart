import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:plantie/bloc/post_bloc.dart';
import 'package:plantie/models/plantEn.dart';
import 'package:plantie/shared/custome_button.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  String? _menuValue;
  String? _textValue;
  final _key = GlobalKey<FormState>();
  int? tappedIndex;
  List<XFile> imagePreview = [];
  Future<XFile?> compressImage(XFile file) async {
    final result = await FlutterImageCompress.compressAndGetFile(
        file.path, file.path + "compressed${timeDilation}.jpg",
        quality: 80);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(leading: const BackButton(), title: const Text("Add Post")),
        body: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    minLines: 4,
                    maxLines: 8,
                    onSaved: (value) {
                      _textValue = value;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Body',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                      menuMaxHeight: 200,
                      decoration: const InputDecoration(
                        hintText: "Category",
                      ),
                      onChanged: (value) {
                        setState(() {
                          _menuValue = value as String;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please choose one category';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        _menuValue = value as String;
                      },
                      items: dbPlants
                          .map((e) => DropdownMenuItem(
                                value: e.name,
                                child: Text(e.name),
                              ))
                          .toList()),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                        iconColor: const Color(0xff47B88A),
                        textStyle: const TextStyle(color: Colors.black)),
                    onPressed: () {
                      ImagePicker picker = ImagePicker();
                      picker
                          .pickImage(source: ImageSource.gallery)
                          .then((value) {
                        if (value != null) {
                          compressImage(value).then((value) {
                            print(value!.path);
                            setState(() {
                              imagePreview.add(value);
                            });
                          }).catchError((e) {
                            print(e);
                          });
                        }
                      });
                    },
                    label: const Text("Photos"),
                    icon: const Icon(Icons.photo_library),
                  ),
                  SizedBox(
                    height: 150,
                    // width: 300,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: imagePreview.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                if (tappedIndex == index) {
                                  setState(() {
                                    tappedIndex = null;
                                    imagePreview.removeAt(index);
                                  });
                                } else {
                                  setState(() {
                                    tappedIndex = index;
                                  });
                                }
                              },
                              child: Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    Image.file(
                                      File(imagePreview[index].path),
                                      width: 150,
                                      height: 150,
                                      opacity: index == tappedIndex
                                          ? const AlwaysStoppedAnimation(0.5)
                                          : null,
                                    ),
                                    index == tappedIndex
                                        ? const Icon(Icons.delete,
                                            color: Colors.redAccent)
                                        : const SizedBox(),
                                  ]));
                        }),
                  ),
                  Button(
                      text: "Post",
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          _key.currentState!.save();

                          BlocProvider.of<PostBloc>(context).add(AddPost(
                            body: _textValue!,
                            type: _menuValue!,
                            images:
                                imagePreview.map((e) => File(e.path)).toList(),
                          ));
                        }
                        // print("Post");
                      })
                ],
              ),
            ),
          ),
        ));
  }
}
