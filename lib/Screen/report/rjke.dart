// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class profilejoke extends StatefulWidget {
  const profilejoke({Key? key}) : super(key: key);

  @override
  State<profilejoke> createState() => _profilejokeState();
}

class _profilejokeState extends State<profilejoke> {
  final CollectionReference _jok =
      FirebaseFirestore.instance.collection('joke');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _jok.snapshots(),
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
                    ? Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Card(
                          color: const Color.fromRGBO(255, 255, 255, 1),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  child: Text(
                                    documentSnapshot['joke'],
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                  ),
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
                                        deletejokef(streamSnapshot
                                            .data!.docs[index].id);
                                      },
                                      icon: const Icon(Icons.delete),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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

  void deletejokef(id) {
    FirebaseFirestore.instance.collection("joke").doc(id).delete();
  }
}
