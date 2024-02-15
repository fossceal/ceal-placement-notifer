import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:placement_notifier/controllers/storage_controller.dart';
import 'package:placement_notifier/models/placement.dart';
import 'package:uuid/uuid.dart';

class DatabaseController {
  final db = FirebaseFirestore.instance;

  var uuid = const Uuid();

  Future addNotification(Placement placement, File imageFile) async {
    try {
      final imageurl = await storage.uploadLogo(imageFile, uuid.v1());

      final notification = {
        "company_name": placement.companyName,
        "job_role": placement.jobRole,
        "job_description": placement.jobDescription,
        "link": placement.applyLink,
        "logo": imageurl,
      };

      var url = Uri.https(dotenv.env["SERVER_URL"]!, "sendNotification");

      var body = {
        'company_name': placement.companyName,
        'job_role': placement.jobRole,
        'job_description': placement.jobDescription,
        'apply_link': placement.applyLink,
        'company_logo': imageurl,
      };

      await http.post(
        url,
        body: json.encode(body),
        headers: {
          "Content-Type": "application/json",
        },
      );

      await db.collection("notifications").add(notification);
    } catch (err) {
      rethrow;
    }
  }

  Future<void> deleteNotification(String id, String fileurl) async {
    try {
      await storage.deleteLogo(fileurl);
      await db.collection("notifications").doc(id).delete();
    } catch (err) {
      rethrow;
    }
  }

  Future<void> updateNotification({
    required String id,
    String? companyName,
    String? jobRole,
    String? jobDescription,
    String? link,
    File? imageFile,
  }) async {
    try {
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

      await db.collection("notifications").doc(id).update(notification);
    } catch (err) {
      rethrow;
    }
  }

  Future getPaginatedNotifications(int limit) async {
   try {
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
   } catch (err) {
      rethrow;
   }
  }

  Future<List<dynamic>> getAllAdmins() async {
    try {
      var url = Uri.https(dotenv.env["SERVER_URL"]!, "get-admins");

      var response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "api": dotenv.env["API_KEY"]!,
        },
      );

      var data = json.decode(response.body);

      if (data["success"] = true) {
        return data["admins"];
      } else {
        return [];
      }
    } catch (err) {
      rethrow;
    }
  }
}

final db = DatabaseController();
