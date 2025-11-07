import 'package:flutter/material.dart';
import 'data/repository.dart';
import 'data/service_fastapi.dart';
import 'data/service_firestore.dart';
import 'screens/todo_screen.dart';

//Flutter's entry
// right now, this doesn't initialize firebase
// to initialize firebase we need to call Firebase.initializeApp() before runApp
// but right now I am just trying to get it to run

void main() {
  runApp(const MyApp()); // boots and runs flutter app
}

// root application widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // set up the Repository object that links Flutter to FastAPI
  //(and eventually Firestore)
  @override
  Widget build(BuildContext context) {
    // this is how we tie to Wyatt's FastAPI framework
    final repository = Repository(
      //Fast API is a dart object thatt points to Wyatt's fast API link and can host get/post
      fastAPI: ServiceFastAPI(baseUrl: "http://127.0.0.1:8000"),
      firestore: ServiceFirestore(),
    );
    //widget root - here we create a theme and a screen
    // screens can contain more widgets
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TodoScreen(repository: repository),
    );
  }
}
