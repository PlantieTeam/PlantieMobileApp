import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantie/bloc/auth_bloc.dart';
import 'package:plantie/shared/custome_button.dart';
import 'package:plantie/shared/loader.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _passwordInputVisablity = true;
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is Unauthenticated) {
        return Wrap(
          alignment: WrapAlignment.center,
          runSpacing: 20,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.90,
              margin: const EdgeInsets.only(bottom: 20),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome",
                    style: TextStyle(color: Color(0xff00796A), fontSize: 24),
                  ),
                  Text("Hello, welcome back to Plantie"),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.95,
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Wrap(
                  alignment: WrapAlignment.start,
                  runSpacing: 20,
                  children: [
                    state.message == "none"
                        ? Container()
                        : Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Text(
                              state.message,
                              style: const TextStyle(color: Colors.red),
                            )),
                    ConstrainedBox(
                        constraints: const BoxConstraints.tightFor(height: 44),
                        child: TextFormField(
                          onSaved: (value) => email = value!,
                          decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                    color: state.message == "none"
                                        ? Colors.black12
                                        : Colors.red),
                              ),
                              hintText: "Email",
                              hintTextDirection: TextDirection.ltr,
                              hintStyle: const TextStyle(color: Colors.black26),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                    color: state.message == "none"
                                        ? const Color(0xff00796A)
                                        : Colors.red),
                              )),
                        )),
                    ConstrainedBox(
                        constraints: const BoxConstraints.tightFor(height: 44),
                        child: TextFormField(
                          onSaved: (value) => password = value!,
                          obscureText: _passwordInputVisablity,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(_passwordInputVisablity
                                    ? (Icons.visibility_off)
                                    : (Icons.visibility)),
                                onPressed: () {
                                  setState(() {
                                    _passwordInputVisablity =
                                        !_passwordInputVisablity;
                                  });
                                },
                              ),
                              contentPadding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                    color: state.message == "none"
                                        ? Colors.black12
                                        : Colors.red),
                              ),
                              hintText: "Password",
                              hintTextDirection: TextDirection.ltr,
                              hintStyle: const TextStyle(color: Colors.black26),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                    color: state.message == "none"
                                        ? const Color(0xff00796A)
                                        : Colors.red),
                              )),
                        )),
                    TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xff00796A),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Forgot your password?",
                          style: TextStyle(fontSize: 12),
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              child: Column(
                children: [
                  Button(
                      text: "Login",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          debugPrint("email: $email, password: $password");
                          BlocProvider.of<AuthBloc>(context).add(LoggedIn(
                            email: email,
                            password: password,
                          ));
                                      Navigator.pushReplacementNamed(context, '/');

                        }
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("create an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/signup');
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xff00796A),
                        ),
                        child: const Text(
                          "Sign In",
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Row(children: <Widget>[
              Expanded(
                  child: Container(
                height: 1,
                decoration: const BoxDecoration(color: Colors.black26),
                margin: const EdgeInsets.all(20),
              )),
              const Text(
                "Or register by",
                style: TextStyle(fontSize: 12),
              ),
              Expanded(
                  child: Container(
                height: 1,
                decoration: const BoxDecoration(color: Colors.black26),
                margin: const EdgeInsets.all(20),
              )),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton.filled(
                  splashColor: Colors.white30,
                  padding: const EdgeInsets.all(10),
                  style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      focusColor: Colors.black26,
                      elevation: 1,
                      shadowColor: Colors.white30),
                  icon: SvgPicture.asset(
                    'assets/icons/google_icon.svg',
                  ),
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context)
                        .add(const LoggedInWithGoogle());
                                    Navigator.pushReplacementNamed(context, '/');

                  },
                ),
              ],
            ),
          ],
        );
      }
      if (state is Loading) {
        return const Center(
          child: Loader(),
        );
      }
      return Center(
        child: TextButton(
          child: const Text("ERROR in LOGIN"),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/');
          },
        ),
      );
    }));
  }
}
