import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:placement_notifier/controllers/storage_controller.dart';
import 'package:placement_notifier/models/placement.dart';
import 'package:uuid/uuid.dart';

class DatabaseController {
  final db = FirebaseFirestore.instance;

  var uuid = const Uuid();

  Future addNotification(Placement placement, File imageFile) async {
    final imageurl = await storage.uploadLogo(imageFile, uuid.v1());

    final notification = {
      "company_name": placement.companyName,
      "job_role": placement.jobRole,
      "job_description": placement.jobDescription,
      "link": placement.applyLink,
      "logo": imageurl,
    };

    await db.collection("notifications").add(notification).then(
          (DocumentReference doc) => print(
            'DocumentSnapshot added with ID: ${doc.id}',
          ),
        );

    var url = Uri.http('10.0.2.2:5270', 'sendNotification');
    var body = {
      'company_name': placement.companyName,
      'job_role': placement.jobRole,
      'job_description': placement.jobDescription,
      'apply_link': placement.applyLink,
      'company_logo': imageurl,
    };

    var response = await http.post(
      url,
      body: json.encode(body),
      headers: {
        "Content-Type": "application/json",
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  Future<void> deleteNotification(String id, String fileurl) async {
    await storage.deleteLogo(fileurl);
    await db.collection("notifications").doc(id).delete().then(
          (value) => print('Notification deleted'),
        );
  }

  Future<void> updateNotification({
    required String id,
    String? companyName,
    String? jobRole,
    String? jobDescription,
    String? link,
    File? imageFile,
  }) async {
    final docRef = db.collection("notifications").doc(id);
    final previousNotification = (await docRef.get()).data();

    if (imageFile != null) {
      await storage.deleteLogo(previousNotification!["logo"]);
    }

    final logo = imageFile != null
        ? await storage.uploadLogo(imageFile, uuid.v1())
        : previousNotification!["logo"];

    final notification = {
      "company_name": companyName,
      "job_role": jobRole,
      "job_description": jobDescription,
      "link": link,
      "logo": logo,
    };

    await db.collection("notifications").doc(id).update(notification).then(
          (value) => print('Notification updated'),
        );
  }

  Future getPaginatedNotifications(int limit) async {
    List<Placement> placements = [];
    await db
        .collection("notifications")
        .limit(limit)
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      for (var doc in querySnapshot.docs) {
        placements.add(Placement.fromFirestore(doc, null, doc.id));
      }
    });
    return placements;
  }
}

final db = DatabaseController();
