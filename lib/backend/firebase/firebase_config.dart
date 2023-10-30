import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCt5gVL5A1xTDOe7bo4gihgVAQXA203x7A",
            authDomain: "fifthpint-common-dev.firebaseapp.com",
            projectId: "fifthpint-common-dev",
            storageBucket: "fifthpint-common-dev.appspot.com",
            messagingSenderId: "80251260068",
            appId: "1:80251260068:web:4fdc3f1e5947524a36aa31",
            measurementId: "G-RDZ9GMHSCY"));
  } else {
    await Firebase.initializeApp();
  }
}
