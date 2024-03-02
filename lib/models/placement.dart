
class Placement {
  final String id;
  final String companyName;
  final String jobRole;
  final String jobDescription;
  final String applyLink;
  final DateTime timestamp;
  final int reportCount;
  String? imageUrl;

  Placement({
    required this.timestamp,
    required this.id,
    required this.companyName,
    required this.jobRole,
    required this.jobDescription,
    required this.applyLink,
    required this.imageUrl,
    required this.reportCount,
  });

  factory Placement.fromFirestore(Map<String, dynamic> data, documentId) {
    return Placement(
      id: documentId,
      companyName: data['company_name'] ?? '',
      reportCount: data['report_count'] ?? 0,
      jobRole: data['job_role'] ?? '',
      jobDescription: data['job_description'] ?? '',
      applyLink: data['link'] ?? '',
      imageUrl: data['logo'] ?? '',
      timestamp: DateTime.parse(data['timestamp'],
      
      ),

    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'company_name': companyName,
      'job_role': jobRole,
      'job_description': jobDescription,
      'link': applyLink,
      'timestamp': timestamp,
      'logo': imageUrl,
    };
  }
}
