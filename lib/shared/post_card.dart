import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plantie/models/Post.dart';

class PostCard extends StatefulWidget {
  const PostCard(
      {super.key,
      required this.post,
      required this.onLikePressed,
      this.onCommentPressed = null,
      this.enableMedia = true});
  final Post post;
  final VoidCallback onLikePressed;
  final VoidCallback? onCommentPressed;
  final enableMedia;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLiked = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLiked =
        widget.post.likes.contains(FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
      ),
      child: Center(
          child: Column(children: [
        Container(
            margin: const EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width * 0.90,
            child: Row(
              children: [
                CircleAvatar(
                    backgroundImage: NetworkImage(widget.post.owner.imageUrl)),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Text(widget.post.owner.name),
                    Row(
                      children: [
                        const Text(
                          "1 d   •   ",
                          style: TextStyle(
                              color: Color(0xff777777),
                              fontSize: 10,
                              fontWeight: FontWeight.w400),
                        ),
                        Image(
                          image: AssetImage(
                              "assets/icons/${widget.post.type.toLowerCase()}.png"),
                          width: 10,
                          height: 10,
                        ),
                        Text(
                          " ${widget.post.type}",
                          style: const TextStyle(
                              color: Color(0xff777777),
                              fontSize: 10,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            )),
        const SizedBox(height: 10),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.90,
            child: Text(
              widget.post.body,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            )),
        const SizedBox(height: 10),
        widget.enableMedia
            ? Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    image: DecorationImage(
                      image: NetworkImage(widget.post.imageUrls[0]),
                      fit: BoxFit.cover,
                    )),
              )
            : Container(),
        const SizedBox(height: 10),
        Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: 40,
            width: MediaQuery.of(context).size.width * 0.90,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffF0EFEF),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    children: [
                      TextButton.icon(
                          style: TextButton.styleFrom(
                              foregroundColor: const Color(0xff00796A),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(50),
                                    topLeft: Radius.circular(50)),
                              )),
                          onPressed: widget.onLikePressed,
                          icon: widget.post.likes.contains(
                                  FirebaseAuth.instance.currentUser!.uid)
                              ? const Icon(Icons.favorite)
                              : const Icon(Icons.favorite_border_outlined),
                          label: Text(widget.post.likes.length.toString())),
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
                ),
                const Spacer(),
                widget.onCommentPressed != null
                    ? TextButton.icon(
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xff00796A),
                        ),
                        onPressed: widget.onCommentPressed,
                        icon: const Icon(Icons.message),
                        label: Text(widget.post.comments.length.toString()),
                      )
                    : const Text("")
              ],
            ))
      ])),
    );
  }
}
