import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plantie/bloc/auth_bloc.dart';
import 'package:plantie/pages/login_page.dart';
import 'package:plantie/shared/custome_button.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _passwordInputVisablity = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Wrap(
          alignment: WrapAlignment.center,
          runSpacing: 20,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.90,
              margin: EdgeInsets.only(bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Create Account",
                    style: TextStyle(color: Color(0xff00796A), fontSize: 24),
                  ),
                  Text("Complete your information to get started"),
                ],
              ),
            ),
            Container(
              // margin: EdgeInsets.only(top: 50, bottom: 200),
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.95,
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Wrap(
                  alignment: WrapAlignment.start,
                  runSpacing: 20,
                  children: [
                    ConstrainedBox(
                        constraints: BoxConstraints.tightFor(height: 44),
                        child: TextFormField(
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(left: 20, right: 20),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(color: Colors.black12),
                              ),
                              hintText: "Usermame",
                              hintTextDirection: TextDirection.ltr,
                              hintStyle: TextStyle(color: Colors.black26),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide:
                                    BorderSide(color: Color(0xff00796A)),
                              )),
                        )),
                    ConstrainedBox(
                        constraints: BoxConstraints.tightFor(height: 44),
                        child: TextFormField(
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(left: 20, right: 20),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(color: Colors.black12),
                              ),
                              hintText: "Email",
                              hintTextDirection: TextDirection.ltr,
                              hintStyle: TextStyle(color: Colors.black26),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide:
                                    BorderSide(color: Color(0xff00796A)),
                              )),
                        )),
                    ConstrainedBox(
                        constraints: BoxConstraints.tightFor(height: 44),
                        child: TextFormField(
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
                                  EdgeInsets.only(left: 20, right: 20),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(color: Colors.black12),
                              ),
                              hintText: "Password",
                              hintTextDirection: TextDirection.ltr,
                              hintStyle: TextStyle(color: Colors.black26),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide:
                                    BorderSide(color: Color(0xff00796A)),
                              )),
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              child: Column(
                children: [
                  Button(text: "Sign up", onPressed: () {}),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("do you have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: Text(
                          "Login",
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: Color(0xff00796A),
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
                decoration: BoxDecoration(color: Colors.black26),
                margin: EdgeInsets.all(20),
              )),
              Text(
                "Or register by",
                style: TextStyle(fontSize: 12),
              ),
              Expanded(
                  child: Container(
                height: 1,
                decoration: BoxDecoration(color: Colors.black26),
                margin: EdgeInsets.all(20),
              )),
            ]),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton.filled(
                    splashColor: Colors.white30,
                    padding: EdgeInsets.all(10),
                    style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
                        focusColor: Colors.black26,
                        elevation: 1,
                        shadowColor: Colors.white30),
                    icon: SvgPicture.asset(
                      'assets/icons/google_icon.svg',
                    ),
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context).add(LoggedIn());
                    },
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
