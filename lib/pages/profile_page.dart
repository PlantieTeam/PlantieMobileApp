import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ProfilePage> {
  String _selectedLanguage = 'English';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40.0,
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
                      offset: const Offset(0, 0),
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
          const Text(
            'Select Language',
            style: TextStyle(fontSize: 16.0),
          ),
          DropdownButton<String>(
            value: _selectedLanguage,
            onChanged: (String? newValue) {
              setState(() {
                _selectedLanguage = newValue!;
              });
            },
            items: <String>['English', 'Arabic']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          const SizedBox(
            height: 30.0,
          ),
          const Text(
            'Name',
            style: TextStyle(fontSize: 16.0),
          ),
          Container(
            height: 35.0,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Text(
                'ahmad qasem',
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Email',
            style: TextStyle(fontSize: 16.0),
          ),
          Container(
            height: 35.0,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Text(
                'ahmad.h.qasem@gmail.com',
                style: TextStyle(fontSize: 15.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
