// ignore_for_file: camel_case_types, file_names

import 'package:admintasali/Screen/Content/addvideo.dart';
import 'package:admintasali/Screen/report/fullvid.dart';
import 'package:admintasali/Screen/widget/videowidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class Video_Screen extends StatefulWidget {
  const Video_Screen({Key? key}) : super(key: key);

  @override
  State<Video_Screen> createState() => _Video_ScreenState();
}

class _Video_ScreenState extends State<Video_Screen> {
  final CollectionReference _video =
      FirebaseFirestore.instance.collection('videos');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _video.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.hasData) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: const Color.fromARGB(255, 111, 12, 180),
                title: Image.asset(
                  'assets/logo.png',
                  width: 52,
                ),
                centerTitle: true,
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Get.to(const addvideo());
                },
                backgroundColor: Colors.orange.shade400,
                child: const Icon(Icons.add),
              ),
              body: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    childAspectRatio: 3 / 5,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0),
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  return Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(
                              fullpagevid(
                                vidurrl: documentSnapshot['video'],
                              ),
                            );
                          },
                          child: SizedBox(
                            height: 500,
                            width: 240,
                            child: VideoPlayerItem(
                              videoUrl: documentSnapshot['video'],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 15,
                          left: 10,
                          child: IconButton(
                            onPressed: () {
                              deletejokef(streamSnapshot.data!.docs[index].id);
                            },
                            icon: Icon(Icons.delete, color: Colors.red,),
                          ),
                        ),
                        Positioned(
                          top: 15,
                          left: 10,
                          child: CircleAvatar(
                            radius: 25,
                            child: Image.network(
                              documentSnapshot['profilepic'],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                scrollDirection: Axis.vertical,
              ));
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              color: Colors.deepPurple,
            ),
          ),
        );
      },
    );
  }

  void deletejokef(id) {
    FirebaseFirestore.instance.collection("videos").doc(id).delete();
    Fluttertoast.showToast(msg: "Video deleted Successfully");
  }
}
