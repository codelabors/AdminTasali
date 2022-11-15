// ignore_for_file: camel_case_types

import 'package:admintasali/Screen/Content/addjokess.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class Jokes_screen extends StatefulWidget {
  const Jokes_screen({Key? key}) : super(key: key);

  @override
  State<Jokes_screen> createState() => _Jokes_screenState();
}

class _Jokes_screenState extends State<Jokes_screen> {
  final CollectionReference _jokes =
      FirebaseFirestore.instance.collection('joke');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _jokes.snapshots(),
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
                Get.to(
                  const Add_jokes(),
                );
              },
              backgroundColor: Colors.orange.shade400,
              child: const Icon(Icons.add),
            ),
            body: ListView.builder(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SizedBox(
                        child: Column(
                          children: [
                            Text(
                              documentSnapshot['joke'],
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    deletejokef(
                                        streamSnapshot.data!.docs[index].id);
                                  },
                                  icon: Icon(Icons.delete),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
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

  void deletejokef(id) {
    FirebaseFirestore.instance.collection("joke").doc(id).delete();
    Fluttertoast.showToast(msg: "Joke deleted Successfully");
  }
}
