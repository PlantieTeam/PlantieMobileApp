import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 100.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 176.0,
                width: 176.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black87.withOpacity(0.4),
                      spreadRadius: 0.1,
                      blurRadius: 20,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/profileTest.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 80.0,
          ),
          Text(
            'Name',
            style: TextStyle(fontSize: 16.0),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                'ahmad qasem',
                style: TextStyle(fontSize: 15),
              ),
            ),
            height: 35.0,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Email',
            style: const TextStyle(fontSize: 16.0),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                'ahmad.h.qasem@gmail.com',
                style: TextStyle(fontSize: 15.0),
              ),
            ),
            height: 35.0,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
          )
        ],
      ),
    );
  }
}
