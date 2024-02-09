import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageController {
  final storage = FirebaseStorage.instance;

  final storageRef = FirebaseStorage.instance.ref();
  late final logoRef = storageRef.child("logos");

  Future<String> uploadLogo(File pickedFile, String fileName) async {
    final uploadTask = logoRef.child(fileName).putFile(pickedFile);

    // uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
    //   switch (taskSnapshot.state) {
    //     case TaskState.running:
    //       final progress =
    //           100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
    //       print("Upload is $progress% complete.");
    //       break;
    //     case TaskState.paused:
    //       print("Upload is paused.");
    //       break;
    //     case TaskState.canceled:
    //       print("Upload was canceled");
    //       break;
    //     case TaskState.error:
    //       break;
    //     case TaskState.success:
    //       break;
    //   }
    // });

    return await (await uploadTask).ref.getDownloadURL();
  }

  // Future<void> deleteLogo(String id, String filename, bool fromAdd) async {
  //   final strippedFilename =
  //       filename.split("%2F")[1].split("?")[0].replaceAll(RegExp("%20"), " ");
  //   print(strippedFilename);
  //   final imageRef = logoRef.child(strippedFilename);
  //   await imageRef.delete();
  //   if (!fromAdd) {
  //     await db.updateNotification(id: id, logo: null);
  //   }
  // }

  Future<void> deleteLogo(String filename) async {
    final strippedFilename =
        filename.split("%2F")[1].split("?")[0].replaceAll(RegExp("%20"), " ");
    final imageRef = logoRef.child(strippedFilename);
    await imageRef.delete();
  }
}

final storage = StorageController();
