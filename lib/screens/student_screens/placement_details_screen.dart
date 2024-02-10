import 'package:flutter/material.dart';
import 'package:placement_notifier/models/placement.dart';
import 'package:url_launcher/url_launcher.dart';

class PlacementDetailsScreen extends StatelessWidget {
  const PlacementDetailsScreen({super.key, required this.placement});

  final Placement placement;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Placement Details"),
      ),
      //show all the details in a beautiful way
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //show all the details in a beautiful way
                // show circular logo
                const SizedBox(
                  height: 20,
                ),
                CircleAvatar(
                  backgroundColor: Colors.black87,
                  radius: 90,
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(placement.imageUrl),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 25,
                      child: Icon(Icons.apartment),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      placement.companyName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 25,
                      child: Icon(
                        Icons.work,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      placement.jobRole,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 25,
                      child: Icon(
                        Icons.info,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      placement.jobDescription,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 70,
                ),
                SizedBox(
                  height: 60,
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      _launchUrl(Uri.parse(placement.applyLink));
                    },
                    child: const Text("Apply Now"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
