import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  const Button({super.key, required this.text, required this.onPressed});
  final String text;
  final VoidCallback onPressed;
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
          minimumSize: const Size.fromHeight(46)),
      onPressed: widget.onPressed,
    );
  }
}
