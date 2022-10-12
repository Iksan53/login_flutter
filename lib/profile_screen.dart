// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_flutter/booking.dart';
import 'package:login_flutter/main.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Dashboard',
            style: TextStyle(
                fontFamily: 'Poppins Bold', color: Colors.white, fontSize: 25),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.greenAccent.shade700,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.logout_outlined),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ));
              },
            ),
          ],
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            // An enabled button
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Container(
                width: 5.0,
                height: 5.0,
              ), //Container
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                'List Property',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  fixedSize: const Size(400, 100),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Container(
                width: 5.0,
                height: 5.0,
              ), //Container
            ), //
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => BookingPage()));
              },
              child: const Text(
                'List Booking',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  fixedSize: const Size(400, 100),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ],
        )),
      ),
    );
  }

  Card buildCard(IconData iconData, String text) {
    return Card(
      elevation: 5,
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(35),
            child: Icon(iconData),
          ),
          Text(
            text,
            style: TextStyle(
                fontFamily: 'Poppins Regular',
                color: Colors.black,
                fontSize: 20),
          )
        ],
      ),
    );
  }
}
