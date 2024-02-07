import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:placement_notifier/controllers/storage_controller.dart';

class AdminAddPlacementScreen extends StatefulWidget {
  const AdminAddPlacementScreen({super.key});

  @override
  State<AdminAddPlacementScreen> createState() =>
      _AdminAddPlacementScreenState();
}

class _AdminAddPlacementScreenState extends State<AdminAddPlacementScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Add a placement notification",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const TextField(
                decoration: InputDecoration(
                  labelText: "Company Name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              //image upload
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Pick Logo of the Company"),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();

                      if (result != null) {
                        File file = File(result.files.single.path!);
                        // storage.uploadLogo();
                      } else {
                        // User canceled the picker
                      }
                    },
                    child: const Text("Upload"),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const TextField(
                decoration: InputDecoration(
                  labelText: "Job Role",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const TextField(
                decoration: InputDecoration(
                  labelText: "Job Description",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const TextField(
                decoration: InputDecoration(
                  labelText: "Link for applying",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              //submit button
              SizedBox(
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.send),
                  label: const Text("Send Push Notification"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
