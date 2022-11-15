// ignore_for_file: camel_case_types

import 'package:admintasali/Screen/report/fm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class profilememe extends StatefulWidget {
  const profilememe({
    Key? key,
  }) : super(key: key);

  @override
  State<profilememe> createState() => _profilememeState();
}

class _profilememeState extends State<profilememe> {
  final CollectionReference _memmme =
      FirebaseFirestore.instance.collection('memes');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _memmme.snapshots(),
      builder: (
        context,
        AsyncSnapshot<QuerySnapshot> streamSnapshot,
      ) {
        if (streamSnapshot.hasData) {
          return Scaffold(
            body: ListView.builder(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return documentSnapshot['report'] == true
                    ? GestureDetector(
                        onTap: () {
                          Get.to(
                            fullpagememe(
                              memeurrl: documentSnapshot['meme'],
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: FancyShimmerImage(
                                      boxFit: BoxFit.fill,
                                      errorWidget: Image.network(
                                          'https://i0.wp.com/www.dobitaobyte.com.br/wp-content/uploads/2016/02/no_image.png?ssl=1'),
                                      imageUrl: documentSnapshot['meme'],
                                    ),
                                  ),
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
                                  Text(
                                    documentSnapshot['name'],
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                  Text(
                                    documentSnapshot['reportdesc'],
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      deletemf(
                                          streamSnapshot.data!.docs[index].id);
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
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.deepPurple,
          ),
        );
      },
    );
  }

  void deletemf(id) {
    FirebaseFirestore.instance.collection("memes").doc(id).delete();
  }
}
