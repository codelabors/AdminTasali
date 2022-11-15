// ignore_for_file: use_build_context_synchronously, camel_case_types
import 'package:admintasali/Models/Models/jokemodel.dart';
import 'package:admintasali/Screen/stats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Add_jokes extends StatefulWidget {
  const Add_jokes({Key? key}) : super(key: key);

  @override
  State<Add_jokes> createState() => _Add_jokesState();
}

class _Add_jokesState extends State<Add_jokes> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController jokecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload a joke'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: SizedBox(
                  height: 120,
                  child: Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  maxLines: 5,
                  controller: jokecontroller,
                  autofocus: false,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Please Enter Joke");
                    }
                    return null;
                  },
                  onSaved: (value) {
                    jokecontroller.text = value!;
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Upload Jokes in your own language",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(30),
                  color: const Color.fromARGB(255, 111, 12, 180),
                  child: MaterialButton(
                    splashColor: Colors.black,
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    minWidth: MediaQuery.of(context).size.width,
                    onPressed: () {
                      jokeaddfire();
                    },
                    child: const Text(
                      "Upload",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  jokeaddfire() {
    if (_formKey.currentState!.validate()) {
      postDetailsToFirebase();
    }
  }

  postDetailsToFirebase() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    jokemodel jokemodelfire = jokemodel();
    jokemodelfire.joke = jokecontroller.text;
    jokemodelfire.islike = false;
    jokemodelfire.name = 'Admin';
    jokemodelfire.jokeuid = 'admin';
    jokemodelfire.profilepic =
        'https://firebasestorage.googleapis.com/v0/b/tasali-app.appspot.com/o/logo.png?alt=media&token=e3a44173-df54-491d-a9fb-de2f2cf943c8';
    await firebaseFirestore.collection('joke').doc().set(jokemodelfire.tomap());
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => const StatsScreen()),
      ),
    );
  }
}
