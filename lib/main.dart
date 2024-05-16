import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantie/bloc/auth_bloc.dart';
import 'package:plantie/bloc/plant_bloc.dart';
import 'package:plantie/firebase_options.dart';
import 'package:plantie/pages/landing_page.dart';
import 'package:plantie/shared/custom_navbar_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white,
  ));
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
          create: (context) => AuthBloc()..add(AppStarted()),
        ),
      ],
      child: MaterialApp(
        title: 'Plantie',
        home: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          if (state is Unauthenticated) {
            return LandingPage();
          }
          if (state is Authenticated) {
            return CustomNavBar();
          }
          return Container(
            child: const Text("ERROR"),
          );
        }),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
