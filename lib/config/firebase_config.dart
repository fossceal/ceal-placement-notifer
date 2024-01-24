import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

Future <void> initialiseFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
