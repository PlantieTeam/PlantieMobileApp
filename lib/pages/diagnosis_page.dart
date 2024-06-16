import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plantie/models/diagnosis.dart';
import 'package:plantie/services/firestore_services.dart';

class DiagnosisPage extends StatefulWidget {
  const DiagnosisPage({super.key});

  @override
  State<DiagnosisPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<DiagnosisPage> {
  String? dropdownValue;
  List<Diagnosis> history = [];
  @override
  void initState() {
    super.initState();
    getDiagnosis().then((value) {
      setState(() {
        history = value;
      });
    });
  }

  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: const Text(
              "Plant Diagnose History ",
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
                          dropdownValue = value;
                        });
                      },
                      dropdownMenuEntries: const [
                        DropdownMenuEntry(
                            value: "latest", label: "Sort By Latest"),
                        DropdownMenuEntry(
                            value: "oldest", label: "Sort By Oldest"),
                      ]),
                  // Spacer(),
                  const SizedBox(width: 10),
                  TextButton.icon(
                      style: TextButton.styleFrom(
                        minimumSize: const Size(140, 55),
                        textStyle: const TextStyle(fontSize: 12),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: const BorderSide(color: Colors.black12)),
                      ),
                      icon: const Icon(Icons.clear_all),
                      onPressed: () {},
                      label: const Text("Clear History"))
                ],
              )),
          SizedBox(
              height: 500,
              width: MediaQuery.of(context).size.width * 0.9,
              child: ListView.builder(
                  itemCount: history.length,
                  itemBuilder: (_, index) {
                    return Container(
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xffEFEFEF)),
                          // elvation: 5,
                        ),
                        child: Row(
                          children: [
                            Text(
                              history[index].prediction,
                              style: TextStyle(
                                  fontSize:
                                      history[index].prediction.length >= 15
                                          ? 11
                                          : 12),
                            ),
                            const Spacer(),
                            Text(
                              DateFormat(" MMM d, yyyy")
                                  .format(history[index].dateTime),
                              style: const TextStyle(fontSize: 12),
                            ),
                            IconButton(
                                color: const Color(0xff47B88A),
                                onPressed: () {},
                                icon: const Icon(Icons.delete))
                          ],
                        ));
                  }))
        ],
      ),
    ));
  }
}
