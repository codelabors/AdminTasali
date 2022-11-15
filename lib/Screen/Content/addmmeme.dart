// ignore_for_file: use_build_context_synchronously, avoid_print
import 'package:admintasali/Models/Models/memesmodel.dart';
import 'package:admintasali/Screen/stats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Addmemes extends StatefulWidget {
  const Addmemes({Key? key}) : super(key: key);

  @override
  State<Addmemes> createState() => _AddmemesState();
}

class _AddmemesState extends State<Addmemes> {
  String? downloadurl;
  bool load = false;
  final imagePicker = ImagePicker();
  late Future<Uint8List> _image;

  Future imagePickerMethod() async {
    final pick = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pick != null) {
        _image = pick.readAsBytes();
      } else {
        showSnackbar(
          'No File Selected',
          const Duration(
            milliseconds: 500,
          ),
        );
      }
    });
  }

  showSnackbar(String snackText, Duration d) {
    final snackBar = SnackBar(
      content: Text(snackText),
      backgroundColor: Colors.purple,
      duration: d,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload a Meme'),
        centerTitle: true,
      ),
      body: Center(
        child: load == true
            ? CircularProgressIndicator(
                color: Colors.purple,
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Upload a Meme",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 200,
                    width: 300,
                    child: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/tasali-app.appspot.com/o/logo.png?alt=media&token=e3a44173-df54-491d-a9fb-de2f2cf943c8',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      imagePickerMethod();
                    },
                    child: const Text(
                      'Select Image',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      uploadimageMethod();
                    },
                    child: const Text(
                      'Upload Image',
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  uploadimageMethod() async {
    setState(() {
      load = !load;
    });
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("memes/")
        .child(DateTime.now().toString());
    final TaskSnapshot snapshot = await ref.putData(
      await _image,
      SettableMetadata(
        contentType: "image/jpg",
      ),
    );
    final downloadUrl = await snapshot.ref.getDownloadURL();
    print("URL=> $downloadUrl");
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    mememodel memeMOdels = mememodel();
    memeMOdels.meme = await downloadUrl;
    memeMOdels.islike = false;
    memeMOdels.memeuid = 'adminuid';
    memeMOdels.name = 'Admin';
    memeMOdels.profilepic =
        'https://firebasestorage.googleapis.com/v0/b/tasali-app.appspot.com/o/logo.png?alt=media&token=e3a44173-df54-491d-a9fb-de2f2cf943c8';

    await firebaseFirestore.collection('memes').doc().set(memeMOdels.tomap());

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => const StatsScreen()),
      ),
    );
  }
}
