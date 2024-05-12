import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:plantie/bloc/plant_bloc.dart';
import 'package:plantie/shared/custom_listView.dart';
import 'package:plantie/shared/custome_button.dart';

class FertilizerCalculatorPage extends StatefulWidget {
  const FertilizerCalculatorPage({super.key});

  @override
  State<FertilizerCalculatorPage> createState() =>
      _FertilizerCalculatorPageState();
}

class _FertilizerCalculatorPageState extends State<FertilizerCalculatorPage> {
  int area = 1;
  bool inhectare = true;
  var formater = NumberFormat("###.0#", "en_US");
  var NPK = [150, 75, 50];
  Map<String, String> coll1 = {
    'Urea': "0.0",
    'MOP': "0.0",
    'SSP': "0.0",
  };
  void calculate() {
    setState(() {
      if (inhectare) {
        coll1['Urea'] = (((100 * NPK[0]) / 46) * area).toStringAsFixed(2);
        coll1['SSP'] = (((100 * NPK[1]) / 16) * area).toStringAsFixed(2);
        coll1['MOP'] = (((100 * NPK[2]) / 60) * area).toStringAsFixed(2);
      } else {
        coll1['Urea'] = (((100 * NPK[0]) / 46) * area * 0.1).toStringAsFixed(2);
        coll1['SSP'] = (((100 * NPK[1]) / 16) * area * 0.1).toStringAsFixed(2);
        coll1['MOP'] = (((100 * NPK[2]) / 60) * area * 0.1).toStringAsFixed(2);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Fertilizer Calculator'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: BlocBuilder<PlantBloc, PlantState>(builder: (context, state) {
          if (state is PlantInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is PlantLoaded) {
            return SingleChildScrollView(
                child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      // height: 100,
                      margin: const EdgeInsets.only(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text("Choose Your Plant",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              )),
                          const SizedBox(height: 10),
                          CustomListView(
                            selectedIndex: state.selectedPlant,
                            onTap: (int index) {
                              context
                                  .read<PlantBloc>()
                                  .add(SelectPlant(selectedPlant: index));
                            },
                          )
                        ],
                      )),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      margin: const EdgeInsets.only(top: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "N-P-K",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                              ),
                              child: const Text("150 - 75 - 50"),
                            )
                          ])),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    margin: const EdgeInsets.only(top: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text("Unit",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              )),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.90,
                              margin: const EdgeInsets.only(top: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          inhectare = false;
                                        });
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.42,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: inhectare
                                              ? Colors.grey[50]
                                              : Colors.grey[200],
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Acres",
                                          ),
                                        ),
                                      )),
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          inhectare = true;
                                        });
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.42,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: inhectare
                                              ? Colors.grey[200]
                                              : Colors.grey[50],
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Hectare",
                                          ),
                                        ),
                                      )),
                                ],
                              )),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Text(inhectare
                                ? "The land Area in Acres"
                                : "The land Area in Hectare"),
                          ),
                          Card(
                              child: SizedBox(
                            height: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    FilledButton(
                                        style: FilledButton.styleFrom(
                                          minimumSize: const Size(50, 50),
                                          shape: const CircleBorder(),
                                          backgroundColor: Colors.grey[200],
                                          foregroundColor: Colors.black,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            if (area > 0) {
                                              area--;
                                            }
                                          });
                                        },
                                        child: const Icon(Icons.remove)),
                                    Container(
                                        width: 150,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                        ),
                                        child: Center(
                                          child: Text(
                                            area.toString(),
                                          ),
                                        )),
                                    IconButton.filled(
                                        onPressed: () {
                                          setState(() {
                                            area++;
                                          });
                                        },
                                        icon: const Icon(Icons.add)),
                                  ],
                                ),
                                Button(
                                    text: "Calculate",
                                    onPressed: () {
                                      calculate();
                                    })
                              ],
                            ),
                          )),
                          Card(
                            child: SizedBox(
                              height: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text("SSP"),
                                      Text("UREA"),
                                      Text("MOP"),
                                    ],
                                  ),
                                  Center(
                                      child: Container(
                                    height: 1,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                  )),
                                  SizedBox(
                                    height: 100,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text('${coll1['SSP']!} kg'),
                                        Text('${coll1['Urea']!} kg'),
                                        Text('${coll1['MOP']!} kg'),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ]),
                  )
                ],
              ),
            ));
          }
          return const Center(child: Text('404 Not Found'));
        }));
  }
}
