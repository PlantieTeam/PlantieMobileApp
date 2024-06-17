import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plantie/bloc/auth_bloc.dart';
import 'package:plantie/models/weather.dart';
import 'package:plantie/pages/add_post_page.dart';
import 'package:plantie/pages/camera_capture.dart';
import 'package:plantie/pages/community_page.dart';
import 'package:plantie/pages/diagnosis_page.dart';
import 'package:plantie/pages/home_page.dart';
import 'package:plantie/pages/profile_page.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  State<CustomNavBar> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CustomNavBar> {
  int _currentIndex = 0;
  Weather weatherData = Weather();

  Future<Map<String, dynamic>> fetchWeatherData(double lat, double lon) async {
    const String apiKey =
        '05d0f5b73d3d8032629902e2cbb33870'; // Replace with your actual key
    final String url =
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&units=imperial&exclude=minutely&appid=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Parse the JSON response
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      // Handle error
      throw Exception('Failed to fetch weather data');
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  final PageStorageBucket bucket = PageStorageBucket();

  List<Widget> screens = [];
  Color secondaryColor = const Color(0x7f1A6158);
  Color primaryColor = const Color(0xff47B88A);
  final User user = FirebaseAuth.instance.currentUser!;
  @override
  void initState() {
    super.initState();
    // Fetch weather data or perform any other initialization tasks here
    setState(() {
      screens = [
        HomePage(weatherData: weatherData),
        const CommunityPage(),
        const DiagnosisPage(),
        const ProfilePage(),
      ];
    });

    _determinePosition().then((value) {
      fetchWeatherData(value.latitude, value.longitude).then((val) {
        setState(() {
          weatherData = Weather(
            temperature: val['current']['temp'],
            status: val['current']['weather'][0]['main'],
            humidity: val['current']['humidity'],
            suggestion: "ss",
            location: val['timezone'],
            timeOfRain: val['current']['weather'][0]['description'],
            windSpeed: val['current']['wind_speed'],
          );
          screens = [
            HomePage(weatherData: weatherData),
            const CommunityPage(),
            const DiagnosisPage(),
            const ProfilePage(),
          ];
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentIndex != 3) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
      ));
    }
    return SafeArea(
        child: Scaffold(
      // drawer: const Drawer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Plantie',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          PopupMenuButton(
              popUpAnimationStyle: AnimationStyle.noAnimation,
              position: PopupMenuPosition.under,
              icon: CircleAvatar(
                  backgroundImage: (user.photoURL != null
                      ? NetworkImage(
                          user.photoURL!,
                        )
                      : null)),
              itemBuilder: (context) => [
                    const PopupMenuItem(
                      child: Text('Profile'),
                    ),
                    PopupMenuItem(
                      child: const Row(
                        children: [
                          Icon(Icons.logout),
                          SizedBox(width: 5),
                          Expanded(child: Text('Logout'))
                        ],
                      ),
                      onTap: () {
                        // signOutWithGoogle();
                        BlocProvider.of<AuthBloc>(context).add(LoggedOut());
                      },
                    )
                  ]),
        ],
      ),
      body: PageStorage(
        bucket: bucket,
        child: screens[_currentIndex],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        shape: const CircleBorder(),
        onPressed: () {
          if (_currentIndex == 1) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AddPostPage(),
            ));
          } else {
            setState(() {
              _currentIndex = 3;
            });
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
            SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
              systemNavigationBarColor: Colors.black,
            ));
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CameraCapture()));
          }
        },
        child: _currentIndex == 1
            ? const Icon(
                Icons.add,
                color: Colors.white,
              )
            : SvgPicture.asset(
                'assets/icons/camera.svg',
                // ignore: deprecated_member_use
                color: Colors.white,
                //: Colors.white,
              ),
      ),
      extendBody: true,
      bottomNavigationBar: ClipPath(
        child: BottomAppBar(
            padding: EdgeInsets.zero,
            shape: const CircularNotchedRectangle(),
            notchMargin: 9,
            clipBehavior: Clip.antiAlias,
            child: Container(
              color: Colors.white,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    onPressed: () {
                      setState(() {
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
                    onPressed: () {
                      setState(() {
                        _currentIndex = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                    onPressed: () {
                      setState(() {
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
                  MaterialButton(
                    onPressed: () {
                      setState(() {
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
                ],
              ),
            )),
      ),
    ));
  }
}
