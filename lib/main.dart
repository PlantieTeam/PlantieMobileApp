import 'package:flutter/material.dart';
import 'package:plantie/pages/landing_page.dart';
import 'package:plantie/pages/landing_page.dart';
import 'package:plantie/shared/custom_listView.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home:Scaffold(body: SafeArea(child: Center(child: CustomListView()))));
  }
}
