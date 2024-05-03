import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // return const Center(
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       Text('Home Page'),
    //     ],
    //   ),
    // )
    return const MaterialApp(
      home: Center(child: Text('Home Page',style: TextStyle(color: Colors.black87,),)),
    );
  }
}
