import 'package:cloud_firestore/cloud_firestore.dart';

class Placement {
  final String id;
  final String companyName;
  final String jobRole;
  final String jobDescription;
  final String applyLink;
  final String imageUrl;

  Placement({
    required this.id,
    required this.companyName,
    required this.jobRole,
    required this.jobDescription,
    required this.applyLink,
    required this.imageUrl,
  });

  factory Placement.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot, options, documentId) {
    final data = snapshot.data();
    return Placement(
      id: documentId,
      companyName: data?['company_name'] ?? '',
      jobRole: data?['job_role'] ?? '',
      jobDescription: data?['job_description'] ?? '',
      applyLink: data?['link'] ?? '',
      imageUrl: data?['logo'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'company_name': companyName,
      'job_role': jobRole,
      'job_description': jobDescription,
      'link': applyLink,
      'logo': imageUrl,
    };
  }
}
