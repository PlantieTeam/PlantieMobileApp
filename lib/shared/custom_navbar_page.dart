import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plantie/pages/camera.dart';
import 'package:plantie/pages/community_page.dart';
import 'package:plantie/pages/diagnosis_page.dart';
import 'package:plantie/pages/home_page.dart';
import 'package:plantie/pages/profile_page.dart';
import 'package:plantie/shared/custom_clipper_navbar.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  State<CustomNavBar> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CustomNavBar> {
  int _currentIndex = 0;

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomePage();
  Color secondaryColor = const Color(0xff00796A);
  Color primaryColor = const Color(0xff47B88A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          //: Colors.white,
        ),
        //mini: true,
      ),
      bottomNavigationBar: ClipPath(
        //clipper: CustomBottomNavBarClipper(),
        child: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 9,
            clipBehavior: Clip.antiAlias,
            child: SizedBox(
              height: 73.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 23, 0, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MaterialButton(
                          minWidth: 40.0,
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
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                child: Text('Plants',
                                    style: TextStyle(
                                        color: _currentIndex == 0
                                            ? primaryColor
                                            : secondaryColor,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400)),
                              )
                            ],
                          ),
                        ),
                        MaterialButton(
                          minWidth: 40.0,
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
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                child: Text('Community',
                                    style: TextStyle(
                                        color: _currentIndex == 1
                                            ? primaryColor
                                            : secondaryColor,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400)),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 23, 0, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MaterialButton(
                          minWidth: 40.0,
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
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                child: Text('Profile',
                                    style: TextStyle(
                                        color: _currentIndex == 2
                                            ? primaryColor
                                            : secondaryColor,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400)),
                              )
                            ],
                          ),
                        ),
                        MaterialButton(
                          minWidth: 40.0,
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
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                child: Text('Diagnosis',
                                    style: TextStyle(
                                        color: _currentIndex == 3
                                            ? primaryColor
                                            : secondaryColor,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400)),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

// class CustomCurvedNavBar extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = Colors.white
//       ..style = PaintingStyle.fill;
//     Path path = Path()..moveTo(0, 20);
//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     // TODO: implement shouldRepaint
//     throw UnimplementedError();
//   }
// }
