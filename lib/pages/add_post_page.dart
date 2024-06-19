import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:plantie/pages/add_post_confirm.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  String? _textValue;
  final _textController = TextEditingController();
  TextDirection _textDirection = TextDirection.ltr;
  final _key = GlobalKey<FormState>();
  int? tappedIndex;
  List<XFile> imagePreview = [];
  Future<XFile?> compressImage(XFile file) async {
    final result = await FlutterImageCompress.compressAndGetFile(
        file.path, file.path + "compressed${timeDilation}.jpg",
        quality: 80);
    return result;
  }

  void _handleTextChange() {
    String? text = _textController.text;
    if (text.isNotEmpty) {
      // Check if the last character is Arabic
      bool isArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(text[0]);
      setState(() {
        _textDirection = isArabic ? TextDirection.rtl : TextDirection.ltr;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
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
                label: const Text("Next"),
                onPressed: () {
                  if (!_key.currentState!.validate()) {
                    return;
                  }
                  _key.currentState!.save();
                  if (imagePreview.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please select image"),
                    ));
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddPostConfirm(
                            body: _textValue!, imagePreview: imagePreview)));
                  }
                })
          ],
        ),
        body: Center(
            child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: const BoxDecoration(
              // color: Colors.white70,
              ),
          width: MediaQuery.of(context).size.width * 0.9,
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _key,
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,

                      // height:MediaQuery.,
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        onChanged: (value) {
                          _handleTextChange();
                        },
                        controller: _textController,
                        textDirection: _textDirection,
                        onSaved: (value) {
                          _textValue = value;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Write something here',
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          } else {
                            return null;
                          }
                        },
                      )),
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
                  Container(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
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
                                if (imagePreview.length >= 4) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text(
                                        "You can't upload more than 4 images"),
                                  ));
                                  return;
                                }
                                setState(() {
                                  imagePreview.add(value);
                                });
                              }).catchError((e) {
                                print(e);
                              });
                            }
                          });
                        },
                        icon: const Icon(Icons.photo),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        )));
  }
}
