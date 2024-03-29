import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:placement_notifier/controllers/database_controller.dart';
import 'package:placement_notifier/models/placement.dart';

class AdminAddPlacementScreen extends StatefulWidget {
  const AdminAddPlacementScreen({super.key});

  // final bool fromData;

  @override
  State<AdminAddPlacementScreen> createState() =>
      _AdminAddPlacementScreenState();
}

class _AdminAddPlacementScreenState extends State<AdminAddPlacementScreen> {
  late TextEditingController _companyNameController;
  late TextEditingController _jobRoleController;
  late TextEditingController _jobDescriptionController;
  late TextEditingController _applyLinkController;

  bool isLogoPicked = false;
  late File? pickedImage;
  bool isLoading = false;

  @override
  void initState() {
    _companyNameController = TextEditingController();
    _jobRoleController = TextEditingController();
    _jobDescriptionController = TextEditingController();
    _applyLinkController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _companyNameController.dispose();
    _jobRoleController.dispose();
    _jobDescriptionController.dispose();
    _applyLinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Push Placement Notification"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: _companyNameController,
                  decoration: const InputDecoration(
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
                    isLogoPicked
                        ? SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.file(pickedImage!))
                        : const Text("Pick Logo of the Company"),
                    const SizedBox(
                      width: 20,
                    ),
                    isLogoPicked
                        ? ElevatedButton.icon(
                            onPressed: () {
                              setState(() {
                                isLogoPicked = false;
                                pickedImage = null;
                              });
                            },
                            icon: const Icon(Icons.delete),
                            label: const Text("Delete"),
                          )
                        : ElevatedButton(
                            onPressed: () async {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles();

                              if (result != null) {
                                File file = File(result.files.single.path!);
                                setState(() {
                                  pickedImage = file;
                                  isLogoPicked = true;
                                });
                              } else {
                                // User canceled the picker
                              }
                            },
                            child: const Text(
                              "Upload",
                            ),
                          ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _jobRoleController,
                  decoration: const InputDecoration(
                    labelText: "Job Role",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _jobDescriptionController,
                  decoration: const InputDecoration(
                    labelText: "Job Description",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _applyLinkController,
                  decoration: const InputDecoration(
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
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ElevatedButton.icon(
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            await db
                                .addNotification(
                              Placement(
                                  id: "",
                                  companyName: _companyNameController.text,
                                  jobRole: _jobRoleController.text,
                                  jobDescription:
                                      _jobDescriptionController.text,
                                  applyLink: _applyLinkController.text,
                                  reportCount: 0,
                                  timestamp: DateTime.now(),
                                  imageUrl: ""),
                              pickedImage!,
                            )
                                .then(
                              (_) {
                                setState(() {
                                  isLoading = false;
                                });
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content:
                                      Text("Notification sent successfully"),
                                ));
                              },
                            ).catchError((err) {
                              setState(() {
                                isLoading = false;
                              });
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Error: $err"),
                              ));
                            });
                          },
                          icon: const Icon(Icons.send),
                          label: const Text("Send Push Notification"),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
