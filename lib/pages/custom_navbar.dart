import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:plantie/pages/camera.dart';
import 'package:plantie/pages/community_page.dart';
import 'package:plantie/pages/diagnosis_page.dart';
import 'package:plantie/pages/home_page.dart';
import 'package:plantie/pages/profile_page.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  State<CustomNavBar> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CustomNavBar> {
  int _currentIndex = 0;
  List<Widget> pageTitles = const [
    HomePage(),
    CommunityPage(),
    CameraPage(),
    ProfilePage(),
    DiagnosisPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageTitles[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: const Color.fromARGB(255, 84, 220, 166),
        backgroundColor: const Color.fromARGB(27, 255, 255, 255),
        
        index: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: const [
          CurvedNavigationBarItem(
            child: Icon(Icons.home_outlined),
            label: "Plants",
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.chat_bubble_outline_outlined),
            label: ("Community"),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.camera_alt_outlined),
            label: 'Camera',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.person_2_outlined),
            label: 'Profile',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.camera_alt_outlined),
            label: 'Diagnosis',
          ),
        ],
      ),
    );
  }
}
