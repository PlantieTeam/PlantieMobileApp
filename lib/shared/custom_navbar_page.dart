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
import 'package:shared_preferences/shared_preferences.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  State<CustomNavBar> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CustomNavBar> {
  int _currentIndex = 0;
  Weather weatherData = Weather();
  @override
  void initState() {
    super.initState();
    setState(() {
      screens = [
        HomePage(weatherData: weatherData),
        const CommunityPage(),
        const DiagnosisPage(),
        const ProfilePage(),
      ];
    });
    initialize();
  }

  Future<void> initialize() async {
    await getCurrentLocation();
    await fetchWeatherAndUpdateUI();
  }

  Future<void> getCurrentLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check if cached location is available
    double? lat = prefs.getDouble('latitude');
    double? lon = prefs.getDouble('longitude');

    if (lat == null || lon == null) {
      // Get current location
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      lat = position.latitude;
      lon = position.longitude;

      // Save location to SharedPreferences
      await prefs.setDouble('latitude', lat);
      await prefs.setDouble('longitude', lon);
    }
  }

  Future<Map<String, dynamic>> fetchWeatherData(double lat, double lon) async {
    const String apiKey = '05d0f5b73d3d8032629902e2cbb33870';
    final String url =
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&units=imperial&exclude=minutely&appid=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }

  Future<void> fetchWeatherAndUpdateUI() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? lat = prefs.getDouble('latitude');
    double? lon = prefs.getDouble('longitude');

    if (lat != null && lon != null) {
      fetchWeatherData(lat, lon).then((val) {
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
    }
  }

  final PageStorageBucket bucket = PageStorageBucket();

  List<Widget> screens = [];
  Color secondaryColor = const Color(0x7f1A6158);
  Color primaryColor = const Color(0xff47B88A);
  final User user = FirebaseAuth.instance.currentUser!;
  bool loading = false;
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
      backgroundColor: Colors.white,
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
      floatingActionButtonLocation: _currentIndex == 1
          ? FloatingActionButtonLocation.endFloat
          : FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _currentIndex == 1
          ? FloatingActionButton.extended(
              label:
                  const Text('Add Post', style: TextStyle(color: Colors.white)),
              backgroundColor: primaryColor,
              onPressed: () {
                if (_currentIndex == 1) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddPostPage(),
                  ));
                }
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              ))
          : FloatingActionButton(
              backgroundColor: primaryColor,
              shape: const CircleBorder(),
              onPressed: () {
                setState(() {
                  _currentIndex = 3;
                });
                SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
                SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
                  systemNavigationBarColor: Colors.black,
                ));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CameraCapture()));
              },
              child: SvgPicture.asset(
                'assets/icons/camera.svg',
                // ignore: deprecated_member_use
                color: Colors.white,
                //: Colors.white,
              )),
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
                        _currentIndex = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/camera_small.svg', // ignore: deprecated_member_use
                          // ignore: deprecated_member_use
                          color: _currentIndex == 2
                              ? primaryColor
                              : secondaryColor,
                        ),
                        Text('Diagnosis',
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
                    onPressed: () {
                      setState(() {
                        _currentIndex = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/profile.svg',
                          // ignore: deprecated_member_use
                          color: _currentIndex == 3
                              ? primaryColor
                              : secondaryColor,
                        ),
                        Text('Profile',
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
