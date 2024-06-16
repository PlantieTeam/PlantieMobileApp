import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:plantie/bloc/post_bloc.dart';
import 'package:plantie/models/Post.dart';
import 'package:plantie/shared/comment_card.dart';
import 'package:plantie/shared/image_preview.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key, required this.post});
  final Post post;

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final _textController = TextEditingController();
  final _listController = ScrollController();
  double height = 50;
  bool fontLess = false;
  void _showImagePreview(BuildContext context, String imagePath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImagePreviewScreen(imagePath: imagePath),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state is PostLoaded) {
          Post post = state.posts.firstWhere((e) => e.id == widget.post.id);
          return Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  width: MediaQuery.of(context).size.width,
                  child: Column(children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.32,
                          width: MediaQuery.of(context).size.width * 0.95,
                        ),
                        Container(
                          height: 215 + 50 - height,
                          width: MediaQuery.of(context).size.width,
                          child: SingleChildScrollView(
                              physics: const PageScrollPhysics(),
                              controller: PageController(
                                viewportFraction:
                                    1 - (1 / MediaQuery.of(context).size.width),
                              ),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  children: post.imageUrls.map((image) {
                                return GestureDetector(
                                    onTap: () =>
                                        _showImagePreview(context, image),
                                    child: CachedNetworkImage(
                                      imageUrl: image,
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width,
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              const SpinKitFadingFour(
                                        color: Colors.green,
                                        size: 20,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ));
                              }).toList()
                                  //     : ,
                                  )),
                        ),
                        IconButton(
                          iconSize: 25,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                        Positioned(
                            top: 200 + 50 - height,
                            left: 10,
                            child: Row(
                              children: [
                                CircleAvatar(
                                    radius: 35,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.white,
                                      backgroundImage: NetworkImage(
                                          widget.post.owner.imageUrl),
                                    )),
                                Text(widget.post.owner.name)
                              ],
                            ))
                      ],
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.90,
                        child: Text(widget.post.body)),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        TextButton.icon(
                            style: TextButton.styleFrom(
                                foregroundColor: const Color(0xff00796A),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(50),
                                      topLeft: Radius.circular(50)),
                                )),
                            onPressed: () {
                              context
                                  .read<PostBloc>()
                                  .add(LikePost(id: widget.post.id));
                            },
                            icon: post.likes.contains(
                                    FirebaseAuth.instance.currentUser!.uid)
                                ? const Icon(Icons.favorite)
                                : const Icon(Icons.favorite_border_outlined),
                            label: Text(post.likes.length.toString())),
                        Container(
                          width: 1,
                          padding: const EdgeInsets.all(10),
                          color: const Color(0xffDADADA),
                        ),
                        TextButton.icon(
                          style: TextButton.styleFrom(
                              foregroundColor: const Color(0xff00796A),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(50),
                                    topRight: Radius.circular(50)),
                              )),
                          onPressed: () {},
                          label: const Icon(Icons.heart_broken),
                        ),
                      ],
                    ),
                  ]),
                ),
                Expanded(
                    child: ListView.builder(
                        controller: _listController,
                        itemCount: post.comments.length,
                        itemBuilder: (context, index) {
                          return CommentCard(
                              direction: FirebaseAuth.instance.currentUser!.email == post.comments[post.comments.length - 1 - index].owner.email
                                  ? TextDirection.ltr
                                  : TextDirection.rtl,
                              color: FirebaseAuth.instance.currentUser!.email ==
                                      post
                                          .comments[
                                              post.comments.length - 1 - index]
                                          .owner
                                          .email
                                  ? const Color.fromARGB(255, 252, 255, 253)
                                  : Colors.white,
                              comment: FirebaseAuth.instance.currentUser!.email ==
                                      post
                                          .comments[
                                              post.comments.length - 1 - index]
                                          .owner
                                          .email
                                  ? post.comments[post.comments.length - 1 - index].copyWith(
                                      owner: post
                                          .comments[post.comments.length - 1 - index]
                                          .owner
                                          .copyWith(name: "you"))
                                  : post.comments[post.comments.length - 1 - index]);
                        })),
                Container(
                    margin: const EdgeInsets.only(bottom: 5, top: 5),
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    height: height,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CircleAvatar(
                            backgroundImage:
                                (FirebaseAuth.instance.currentUser?.photoURL !=
                                        null
                                    ? NetworkImage(
                                        FirebaseAuth
                                            .instance.currentUser!.photoURL!,
                                      )
                                    : null)),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: TextField(
                          controller: _textController,
                          minLines: 3,
                          maxLines: 10,
                          maxLength: height > 50 ? 550 : null,
                          showCursor: true,
                          onTapOutside: (e) {
                            SystemChannels.textInput
                                .invokeMethod('TextInput.hide');
                            setState(() {
                              height = 50;
                            });
                          },
                          onTap: () {
                            setState(() {
                              height = 120;
                            });
                          },
                          onChanged: (value) {
                            if (value.length > 10) {
                              setState(() {
                                fontLess = true;
                              });
                            } else {
                              setState(() {
                                fontLess = false;
                              });
                            }
                          },
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: fontLess ? 12 : 15),
                          decoration: InputDecoration(
                            fillColor: const Color(0xffffffff),
                            filled: true,
                            hintText: 'Comment',
                            suffixIcon: const Icon(Icons.attach_file),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xffE6E6E6)),
                                borderRadius: BorderRadius.circular(50)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xffE6E6E6)),
                                borderRadius: BorderRadius.circular(2)),
                          ),
                        )),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                            onPressed: () {
                              if (_textController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Comment cannot be empty'),
                                  ),
                                );
                              } else {
                                context.read<PostBloc>().add(CommentOnPost(
                                    id: widget.post.id,
                                    comment: PostComment(
                                      body: _textController.text,
                                      owner: PostUser(
                                        id: FirebaseAuth
                                            .instance.currentUser!.uid,
                                        name: FirebaseAuth
                                            .instance.currentUser!.displayName!,
                                        email: FirebaseAuth
                                            .instance.currentUser!.email!,
                                        imageUrl: FirebaseAuth
                                            .instance.currentUser!.photoURL!,
                                      ),
                                    )));
                              }
                              _listController.position.moveTo(0);
                              _textController.clear();
                              SystemChannels.textInput
                                  .invokeMethod('TextInput.hide');
                            },
                            icon: const Icon(Icons.send))
                      ],
                    )),
              ]));
        }
        return const Center(
          child: Text('Something went wrong'),
        );
      },
    )));
  }
}
