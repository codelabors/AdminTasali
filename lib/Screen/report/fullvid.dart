// ignore_for_file: camel_case_types

import 'package:admintasali/Screen/widget/videowidget.dart';
import 'package:flutter/material.dart';

class fullpagevid extends StatelessWidget {
  const fullpagevid({Key? key, required this.vidurrl}) : super(key: key);
  final String vidurrl;
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
      body: Stack(
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: VideoPlayerItem(
                videoUrl: vidurrl,
              )),
        ],
      ),
    );
  }
}
