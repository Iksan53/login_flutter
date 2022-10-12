// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
      title: 'Dashboard',
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Dashboard",
            style: TextStyle(
                fontFamily: 'Poppins Bold', color: Colors.white, fontSize: 25),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.greenAccent.shade700,
          actions: [
            PopupMenuButton(
                // add icon, by default "3 dot" icon
                // icon: Icon(Icons.book)
                itemBuilder: (context) {
              return [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text("Logout"),
                ),
              ];
            }, onSelected: (value) {
              Navigator.of(context).pop();
              if (value == 0) {
                // ignore: avoid_print
                print("Logout menu is selected.");
              }
            }),
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
              onPressed: () {},
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
