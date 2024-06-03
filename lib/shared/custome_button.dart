import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  const Button(
      {super.key,
      required this.text,
      required this.onPressed,
      this.width = double.infinity});
  final String text;
  final VoidCallback onPressed;
  final double width;
  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      // ignore: sort_child_properties_last
      child: Text(widget.text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
      style: TextButton.styleFrom(
          backgroundColor: const Color.fromRGBO(71, 184, 138, 1),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          minimumSize: Size(widget.width, 46)),
      onPressed: widget.onPressed,
    );
  }
}
