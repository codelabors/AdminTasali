// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class fullpagememe extends StatelessWidget {
  const fullpagememe({Key? key, required this.memeurrl}) : super(key: key);
  final String memeurrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/logo.png',
          width: 52,
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Image.network(memeurrl),
            Positioned(
              bottom: 15,
              right: 10,
              child: Image.asset(
                'assets/tlogo.png',
                width: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
