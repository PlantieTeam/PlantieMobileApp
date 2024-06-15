import 'package:camera/camera.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantie/bloc/auth_bloc.dart';
import 'package:plantie/bloc/plant_bloc.dart';
import 'package:plantie/bloc/post_bloc.dart';
import 'package:plantie/firebase_options.dart';
import 'package:plantie/pages/landing_page.dart';
import 'package:plantie/pages/login_page.dart';
import 'package:plantie/pages/signup_page.dart';
import 'package:plantie/shared/custom_navbar_page.dart';

late CameraDescription firstCamera;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate(
    // You can also use a `ReCaptchaEnterpriseProvider` provider instance as an
    // argument for `webProvider`
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Safety Net provider
    // 3. Play Integrity provider
    androidProvider: AndroidProvider.debug,
    // Default provider for iOS/macOS is the Device Check provider. You can use the "AppleProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Device Check provider
    // 3. App Attest provider
    // 4. App Attest provider with fallback to Device Check provider (App Attest provider is only available on iOS 14.0+, macOS 14.0+)
    appleProvider: AppleProvider.appAttest,
  );
  final cameras = await availableCameras();
  firstCamera = cameras.first;

  runApp(const MainApp());
}
class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PlantBloc()..add(LoadPlants()),
        ),
        BlocProvider(
          create: (context) => AuthBloc()..add(const AppStarted()),
        ),
        BlocProvider(
          create: (context) => PostBloc()..add(GetPosts(limit: 5)),
        )
      ],
      child: MaterialApp(
        routes: {
          // '/': (context) => LandingPage(),
          '/login': (context) => const LoginPage(),
          '/signup': (context) => const SignupPage(),
        },
        title: 'Plantie',
        home: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          if (state is AppStarted) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is Unauthenticated) {
            return const LandingPage();
          }
          if (state is Authenticated) {
            // if (Navigator.of(context).canPop()) Navigator.of(context).pop();
            return const CustomNavBar();
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
