import 'package:flutter/material.dart';
import 'package:plantie/shared/custome_button.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.only(top: 100, bottom: 20),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: 50,
                children: [
                  Image.asset(
                    'assets/images/Landing.png',
                    width: MediaQuery.of(context).size.width * 0.95,
                  ),
                  const Column(
                    children: [
                      Text(
                        'Plantie',
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.w700),
                      ),
                      Text("Get more crops with Planty's help!")
                    ],
                  ),
                  SizedBox(
                    width: 300,
                    child: Wrap(
                      runSpacing: 10,
                      children: [
                        Button(
                            text: "Register",
                            onPressed: () {
                              Navigator.pushNamed(
                                  context,'/signup',);
                            }),
                        Button(
                            text: "Login",
                            onPressed: () {
                              Navigator.pushNamed(
                                  context,
                                  '/login',);
                            }),
                      ],
                    ),
                  ),
                ]),
            const Text(
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
                "By logging in or registering, you agree to our Terms of Service and Privacy Policy"),
          ]),
    ));
  }
}
