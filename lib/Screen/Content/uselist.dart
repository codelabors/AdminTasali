import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Userlist extends StatefulWidget {
  const Userlist({Key? key}) : super(key: key);

  @override
  State<Userlist> createState() => _UserlistState();
}

class _UserlistState extends State<Userlist> {
  final CollectionReference _useers =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _useers.snapshots(),
      builder: (
        context,
        AsyncSnapshot<QuerySnapshot> streamSnapshot,
      ) {
        if (streamSnapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Users'),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  return ListTile(
                    title: Text(documentSnapshot['firstName']),
                    subtitle: Text(documentSnapshot['email']),
                    trailing: IconButton(
                        onPressed: () {
                          deletemf(streamSnapshot.data!.docs[index].id);
                        },
                        icon: const Icon(Icons.delete)),
                  );
                },
              ),
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
    FirebaseFirestore.instance.collection("users").doc(id).delete();
    Fluttertoast.showToast(msg: 'User Deleted Sucessfully');
  }
}
