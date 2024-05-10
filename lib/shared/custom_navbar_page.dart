import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomePage();
  Color secondaryColor = const Color(0x7f1A6158);
  Color primaryColor = const Color(0xff47B88A);

  @override
  Widget build(BuildContext context) {
    const double iconsSize = 10;
    return SafeArea(
        child: Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          setState(() {
            currentScreen = const CameraPage();
          });
        },
        child: SvgPicture.asset(
          'assets/icons/camera.svg',
          color: Colors.white,
          //: Colors.white,
        ),
      ),
      extendBody: true,
      bottomNavigationBar: ClipPath(
        child: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 9,
            clipBehavior: Clip.antiAlias,
            child: SizedBox(
              height: 73.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    minWidth: iconsSize,
                    onPressed: () {
                      setState(() {
                        currentScreen = const HomePage();
                        _currentIndex = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/home.svg',
                          // ignore: deprecated_member_use
                          color: _currentIndex == 0
                              ? primaryColor
                              : secondaryColor,
                        ),
                        Text('Plants',
                            style: TextStyle(
                                color: _currentIndex == 0
                                    ? primaryColor
                                    : secondaryColor,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: iconsSize,
                    onPressed: () {
                      setState(() {
                        currentScreen = const CommunityPage();
                        _currentIndex = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/community.svg', // ignore: deprecated_member_use
                          // ignore: deprecated_member_use
                          color: _currentIndex == 1
                              ? primaryColor
                              : secondaryColor,
                        ),
                        Text('Community',
                            style: TextStyle(
                                color: _currentIndex == 1
                                    ? primaryColor
                                    : secondaryColor,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: iconsSize,
                    onPressed: () {
                      setState(() {
                        currentScreen = const ProfilePage();
                        _currentIndex = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/profile.svg',
                          // ignore: deprecated_member_use
                          color: _currentIndex == 2
                              ? primaryColor
                              : secondaryColor,
                        ),
                        Text('Profile',
                            style: TextStyle(
                                color: _currentIndex == 2
                                    ? primaryColor
                                    : secondaryColor,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: iconsSize,
                    onPressed: () {
                      setState(() {
                        currentScreen = const DiagnosisPage();
                        _currentIndex = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/camera_small.svg', // ignore: deprecated_member_use
                          // ignore: deprecated_member_use
                          color: _currentIndex == 3
                              ? primaryColor
                              : secondaryColor,
                        ),
                        Text('Diagnosis',
                            style: TextStyle(
                                color: _currentIndex == 3
                                    ? primaryColor
                                    : secondaryColor,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    ));
  }
}
