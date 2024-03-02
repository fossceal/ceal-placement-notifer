import 'package:flutter/material.dart';
import 'package:placement_notifier/controllers/database_controller.dart';
import 'package:placement_notifier/models/placement.dart';
import 'package:url_launcher/url_launcher.dart';

class PlacementDetailsScreen extends StatefulWidget {
  const PlacementDetailsScreen({super.key, required this.placement});

  final Placement placement;

  @override
  State<PlacementDetailsScreen> createState() => _PlacementDetailsScreenState();
}

class _PlacementDetailsScreenState extends State<PlacementDetailsScreen> {
  bool isReported = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Placement Details",
          style: TextStyle(
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Center(
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.8,
            child: Card(
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    //border
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 4,
                      ),
                    ),
                    child: Image(
                      image: NetworkImage(widget.placement.imageUrl!),
                      height: 180,
                      width: 180,
                      //border
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    widget.placement.companyName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.placement.jobRole,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.placement.jobDescription,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          await _launchUrl(
                            Uri.parse(
                              widget.placement.applyLink,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          side: const BorderSide(color: Colors.black, width: 1),
                        ),
                        child: const Text(
                          'Apply Now',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (isReported) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Link already reported",
                                ),
                              ),
                            );
                            return;
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext alertContext) {
                                  return AlertDialog(
                                    title: const Text("Report Link Expired"),
                                    content: const Text(
                                      "Are you sure you want to report this link as expired?",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(alertContext).pop();
                                        },
                                        child: const Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(alertContext).pop();
                                          setState(() {
                                            isReported = true;
                                          });
                                          db
                                              .reportNotification(
                                                  widget.placement.id)
                                              .then((value) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "Link reported",
                                                ),
                                              ),
                                            );
                                          }).onError((error, stackTrace) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  "Error: $error",
                                                ),
                                              ),
                                            );
                                          });
                                        },
                                        child: const Text("Report"),
                                      ),
                                    ],
                                  );
                                });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          side: const BorderSide(color: Colors.black, width: 1),
                        ),
                        child: const Text(
                          'Report Expired Link',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
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
