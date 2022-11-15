// ignore_for_file: camel_case_types, avoid_print, use_build_context_synchronously
import 'package:admintasali/Screen/stats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../Models/Models/vidoemodel.dart';

class addvideo extends StatefulWidget {
  const addvideo({Key? key}) : super(key: key);

  @override
  State<addvideo> createState() => _addvideoState();
}

class _addvideoState extends State<addvideo> {
  late Future<Uint8List> _image;
  String? downloadurl;
  bool load = false;
  final imagePicker = ImagePicker();

  Future imagePickerMethod() async {
    final pick = await imagePicker.pickVideo(source: ImageSource.gallery);

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
        title: const Text('Upload a Video'),
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
                    "Upload a Video",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      height: 300,
                      width: 400,
                      child: Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/tasali-app.appspot.com/o/logo.png?alt=media&token=e3a44173-df54-491d-a9fb-de2f2cf943c8',
                        fit: BoxFit.contain,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      imagePickerMethod();
                    },
                    child: const Text(
                      'Select Video',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      uploadimageMethod();
                    },
                    child: const Text(
                      'Upload Video',
                    ),
                  ),
                ],
              ),
      ),
    );
  }
  String urrl = DateTime.now().toString();
  uploadimageMethod() async {
    setState(() {
      load == !load;
    });
    Reference ref = FirebaseStorage.instance.ref().child("videos/").child(urrl);
    final TaskSnapshot snapshot = await ref.putData(
      await _image,
      SettableMetadata(
        contentType: "video/mp4",
      ),
    );
    final downloadUrl = await snapshot.ref.getDownloadURL();
print("URL=> $downloadUrl");
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    videomodel videooomoo = videomodel();
    videooomoo.video = await downloadUrl;
    videooomoo.name = 'admin';
    videooomoo.islike = false;
    videooomoo.profilepic =
        'https://firebasestorage.googleapis.com/v0/b/tasali-app.appspot.com/o/logo.png?alt=media&token=e3a44173-df54-491d-a9fb-de2f2cf943c8';
    videooomoo.viduid = 'Admin';
    await firebaseFirestore.collection('videos').doc().set(videooomoo.tomap());
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => const StatsScreen()),
      ),
    );
  }
}