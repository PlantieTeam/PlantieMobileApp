import 'package:flutter/material.dart';
import 'package:plantie/models/Post.dart';

class CommentCard extends StatefulWidget {
  const CommentCard(
      {super.key,
      required this.comment,
      this.direction = TextDirection.rtl,
      this.color = Colors.white});
  final PostComment comment;
  final TextDirection direction;
  final Color color;
  // final

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: widget.color,
      ),
      child: Center(
          child: Column(children: [
        Container(
            margin: const EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width * 0.90,
            child: Row(
              textDirection: widget.direction,
              children: [
                CircleAvatar(
                    backgroundImage:
                        NetworkImage(widget.comment.owner.imageUrl)),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Text(widget.comment.owner.name),
                  ],
                )
              ],
            )),
        const SizedBox(height: 10),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.90,
            child: Text(
              // textDirection: widget.direction,
              widget.comment.body,
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
            )),
        const SizedBox(height: 10),
      ])),
    );
  }
}
