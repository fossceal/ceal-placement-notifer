import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageController {
  final storage = FirebaseStorage.instance;

  final storageRef = FirebaseStorage.instance.ref();
  late final logoRef = storageRef.child("logos");

  Future<String> uploadLogo(File pickedFile, String fileName) async {
    final uploadTask = logoRef.child(fileName).putFile(pickedFile);

    return await (await uploadTask).ref.getDownloadURL();
  }

  Future<void> deleteLogo(String filename) async {
    final strippedFilename =
        filename.split("%2F")[1].split("?")[0].replaceAll(RegExp("%20"), " ");
    final imageRef = logoRef.child(strippedFilename);
    await imageRef.delete();
  }
}

final storage = StorageController();
