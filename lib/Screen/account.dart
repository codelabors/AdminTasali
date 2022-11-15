// ignore_for_file: camel_case_types

import 'package:admintasali/Screen/SignIn.dart';
import 'package:admintasali/Screen/stats.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class accountscreen extends StatefulWidget {
  const accountscreen({Key? key}) : super(key: key);

  @override
  State<accountscreen> createState() => _accountscreenState();
}

class _accountscreenState extends State<accountscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset('assets/logo.png'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Icon(
                Icons.home_filled,
                color: Colors.purple,
                size: 35,
              ),
              title: const Text('HOME'),
              onTap: () {
                Get.to(
                  StatsScreen(),
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.purple,
                size: 35,
              ),
              title: const Text('ACCOUNT'),
              onTap: () {
                Get.to(
                  accountscreen(),
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Icon(
                Icons.report,
                color: Colors.purple,
                size: 35,
              ),
              title: const Text('REPORT'),
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                loggout(context);
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              )),
        ],
        backgroundColor: const Color.fromARGB(255, 111, 12, 180),
        title: Image.asset(
          'assets/logo.png',
          width: 52,
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            'assets/logo.png',
            width: 120,
          )),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Center(
              child: Text(
                'Admin',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const Center(
            child: Text(
              'admin@gmail.com',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
  Future<void> loggout(BuildContext context) async {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Sign_In()));
  }
}
