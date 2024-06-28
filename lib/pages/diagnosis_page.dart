import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:plantie/models/diagnosis.dart';
import 'package:plantie/services/file_services.dart';
import 'package:plantie/shared/image_preview.dart';
import 'package:plantie/shared/loader.dart';

class DiagnosisPage extends StatefulWidget {
  const DiagnosisPage({Key? key}) : super(key: key);

  @override
  State<DiagnosisPage> createState() => _DiagnosisPageState();
}

class _DiagnosisPageState extends State<DiagnosisPage> {
  String? dropdownValue;
  List<Diagnosis> history = [];

  @override
  void initState() {
    super.initState();
    loadDiagnosisHistory().then((v) {});
  }

  Future<void> loadDiagnosisHistory() async {
    List<Diagnosis> loadedHistory = await FileStorageService.readDiagnosis();
    setState(() {
      history = loadedHistory;
    });
  }

  void sortHistory(String sortBy) {
    switch (sortBy) {
      case 'latest':
        history.sort((a, b) => b.dateTime.compareTo(a.dateTime));
        break;
      case 'oldest':
        history.sort((a, b) => a.dateTime.compareTo(b.dateTime));
        break;
      default:
        // Default to sorting by latest if invalid value is provided
        history.sort((a, b) => b.dateTime.compareTo(a.dateTime));
        break;
    }
  }

  void _showImagePreview(BuildContext context, String imagePath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImagePreviewScreen(
          imagePath: imagePath,
          local: true,
        ),
      ),
    );
  }

  void clearHistory() async {
    setState(() {
      history = [];
    });
    await FileStorageService.clearDiagnosis();
  }

  @override
  Widget build(BuildContext context) {
    return history.isEmpty
        ? const Loader()
        : Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        _showImagePreview(context, history.last.path);
                      },
                      child: Stack(children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(File(history.last.path)),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 100,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: [
                                  Color(0xff00796A),
                                  Color.fromARGB(16, 0, 121, 107)
                                ]),
                          ),
                          child: Text(
                            history.last.prediction,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ])),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: const Text(
                      "Plant Diagnose History",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff00796A)),
                    ),
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Row(
                        children: [
                          DropdownMenu(
                              hintText: "Sorting by",
                              initialSelection: "Sorting By",
                              width: 180,
                              textStyle: const TextStyle(fontSize: 12),
                              onSelected: (value) {
                                setState(() {
                                  sortHistory(value!);
                                  dropdownValue = value;
                                });
                              },
                              dropdownMenuEntries: const [
                                DropdownMenuEntry(
                                    value: "latest", label: "Sort By Latest"),
                                DropdownMenuEntry(
                                    value: "oldest", label: "Sort By Oldest"),
                              ]),
                          const SizedBox(width: 10),
                          TextButton.icon(
                              style: TextButton.styleFrom(
                                minimumSize: const Size(140, 55),
                                textStyle: const TextStyle(fontSize: 12),
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: const BorderSide(
                                        color: Colors.black12)),
                              ),
                              icon: const Icon(Icons.clear_all),
                              onPressed: clearHistory,
                              label: const Text("Clear History"))
                        ],
                      )),
                  SizedBox(
                      height: 500,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ListView.builder(
                          itemCount: history.length,
                          itemBuilder: (_, index) {
                            return GestureDetector(
                                onTap: () => _showImagePreview(
                                    context, history[index].path),
                                child: Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xffEFEFEF)),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          history[index].prediction.length >= 30
                                              ? history[index]
                                                  .prediction
                                                  .substring(0, 30)
                                              : history[index].prediction,
                                          style: TextStyle(
                                              fontSize: history[index]
                                                          .prediction
                                                          .length >=
                                                      15
                                                  ? 11
                                                  : 12),
                                        ),
                                        const Spacer(),
                                        Text(
                                          DateFormat("MMM d, yyyy")
                                              .format(history[index].dateTime),
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        IconButton(
                                            color: const Color(0xff47B88A),
                                            onPressed: () async {
                                              setState(() {
                                                history.removeAt(index);
                                              });
                                              // await saveDiagnosis(history);
                                              await FileStorageService
                                                  .writeDiagnosis(history);
                                            },
                                            icon: const Icon(Icons.delete))
                                      ],
                                    )));
                          }))
                ],
              ),
            ),
          );
  }
}
