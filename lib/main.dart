import 'package:admintasali/Screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _initialize = Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBFon0y73j5MaB-5l8TpKfxUE-82vSjVbY",
      messagingSenderId: "243942451929",
      appId: "1:243942451929:web:f8c1e9411e49f43a1c2cc8",
      projectId: "tasali-app",
      storageBucket: "tasali-app.appspot.com",
    ),
  );
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Tasali Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: FutureBuilder(
        future: _initialize,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            // ignore: avoid_print
            print('Error');
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return const Splash_Screen();
          }
          return const CircularProgressIndicator(
            color: Colors.blue,
          );
        },
      ),
    );
  }
}
