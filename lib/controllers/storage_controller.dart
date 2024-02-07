import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageController {
  final storage = FirebaseStorage.instance;

  final storageRef = FirebaseStorage.instance.ref();
  late final logoRef = storageRef.child("logos");

  Future<String> uploadLogo(
      File pickedFile, String path, String fileName) async {
    final uploadTask = logoRef.child(fileName).putFile(pickedFile);

    uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
      switch (taskSnapshot.state) {
        case TaskState.running:
          final progress =
              100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
          print("Upload is $progress% complete.");
          break;
        case TaskState.paused:
          print("Upload is paused.");
          break;
        case TaskState.canceled:
          print("Upload was canceled");
          break;
        case TaskState.error:
          break;
        case TaskState.success:
          break;
      }
    });
    return await (await uploadTask).ref.getDownloadURL();
  }

  Future<void> deleteLogo(String fileName) async {
    final imageRef = logoRef.child(fileName);
    await imageRef.delete();
  }
}

final storage = StorageController();
