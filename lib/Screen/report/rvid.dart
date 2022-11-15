// ignore_for_file: camel_case_types, file_names
import 'package:admintasali/Screen/report/fullvid.dart';
import 'package:admintasali/Screen/widget/videowidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RVideo_Screen extends StatefulWidget {
  const RVideo_Screen({Key? key}) : super(key: key);

  @override
  State<RVideo_Screen> createState() => _RVideo_ScreenState();
}

class _RVideo_ScreenState extends State<RVideo_Screen> {
  final CollectionReference _video =
      FirebaseFirestore.instance.collection('videos');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _video.snapshots(),
        builder: (
          context,
          AsyncSnapshot<QuerySnapshot> streamSnapshot,
        ) {
          if (streamSnapshot.hasData) {
            return Scaffold(
              body: ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  return documentSnapshot['report'] ==
                         true
                      ? GestureDetector(
                          onTap: () {
                            Get.to(
                              fullpagevid(
                                vidurrl: documentSnapshot['video'],
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    SizedBox(
                                        height: 270,
                                        width: 350,
                                        child: VideoPlayerItem(
                                          videoUrl: documentSnapshot['video'],
                                        )),
                                         Positioned(
                                    bottom: 15,
                                    right: 10,
                                    child: Image.asset('assets/tlogo.png', width: 50,),
                                  ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(documentSnapshot['name'], style: const TextStyle(fontSize: 18, color: Colors.black),),
                                    Text(documentSnapshot['reportdesc'], style: const TextStyle(fontSize: 18, color: Colors.black),),
                                    IconButton(
                                      onPressed: () {
                                        deletevidf(streamSnapshot
                                            .data!.docs[index].id);
                                      },
                                      icon: const Icon(Icons.delete),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox(
                          width: 0,
                        );
                },
                scrollDirection: Axis.vertical,
              ),
            );
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.deepPurple,
              ),
            ),
          );
        });
  }

  void deletevidf(id) {
    FirebaseFirestore.instance.collection("videos").doc(id).delete();
  }
}
