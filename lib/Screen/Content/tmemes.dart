// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types

import 'package:admintasali/Screen/Content/addmmeme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class home_Screen extends StatefulWidget {
  const home_Screen({Key? key}) : super(key: key);

  @override
  State<home_Screen> createState() => _home_ScreenState();
}

class _home_ScreenState extends State<home_Screen> {
  final CollectionReference _memes =
      FirebaseFirestore.instance.collection('memes');
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _memes.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.hasData) {
          return Scaffold(
            backgroundColor: Colors.grey.shade300,
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
                Get.to(Addmemes());
              },
              backgroundColor: Colors.orange.shade400,
              child: Icon(Icons.add),
            ),
            body: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  childAspectRatio: 3 / 5,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0),
              padding: EdgeInsets.fromLTRB(3, 3, 3, 3),
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage(
                                      documentSnapshot['profilepic']),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    documentSnapshot['name'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '1d',
                              style:
                                  TextStyle(fontSize: 17, color: Colors.grey),
                            ),
                          )
                        ],
                      ),
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
                            child: IconButton(
                              onPressed: () {
                                deletejokef(
                                    streamSnapshot.data!.docs[index].id);
                              },
                              icon: Icon(Icons.delete),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        height: 8,
                        thickness: 9,
                        color: Colors.grey.shade500,
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(
            color: Colors.deepPurple,
          ),
        );
      },
    );
  }

  void deletejokef(id) {
    FirebaseFirestore.instance.collection("memes").doc(id).delete();
    Fluttertoast.showToast(msg: "Meme deleted Successfully");
  }

  void updatefeild(id) {
    FirebaseFirestore.instance
        .collection('memes')
        .doc(id)
        .update({'islike': true});
  }
}
