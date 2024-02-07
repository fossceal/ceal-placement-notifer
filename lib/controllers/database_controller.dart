import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseController {
  final db = FirebaseFirestore.instance;

  Future<void> addNotification(String companyName, String jobRole,
      String jobDescription, String link, String logo) async {
    final notification = {
      "company_name": companyName,
      "job_role": jobRole,
      "job_description": jobDescription,
      "link": link,
      "logo": logo,
    };

    await db.collection("notifications").add(notification).then(
          (DocumentReference doc) => print(
            'DocumentSnapshot added with ID: ${doc.id}',
          ),
        );
  }

  Future<void> deleteNotification(String id) async {
    await db.collection("notifications").doc(id).delete().then(
          (value) => print('Notification deleted'),
        );
  }

  Future<void> updateNotification(String id, String companyName, String jobRole,
      String jobDescription, String link, String logo) async {
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
    final notifications = await db
        .collection("notifications")
        .limit(limit)
        .orderBy("company_name")
        .get();

    return notifications.docs;
  }
}
