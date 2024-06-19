import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:plantie/bloc/plant_bloc.dart';
import 'package:plantie/shared/custom_listView.dart';
import 'package:plantie/shared/custome_button.dart';
import 'package:plantie/shared/loader.dart';

enum Fertilizer { urea, mOP, sSP, dAP }

enum Unit { Acre, Hectare, SquareMeter }

class FertilizerCalculatorPage extends StatefulWidget {
  const FertilizerCalculatorPage({super.key});

  @override
  State<FertilizerCalculatorPage> createState() =>
      _FertilizerCalculatorPageState();
}

class _FertilizerCalculatorPageState extends State<FertilizerCalculatorPage> {
  TextEditingController areaController = TextEditingController(text: "0.0");
  int area = 0;
  Unit unit = Unit.Hectare;
  var formater = NumberFormat("###.0#", "en_US");

  Map<String, String> coll1 = {
    'Urea': "0.0",
    'MOP': "0.0",
    'SSP': "0.0",
  };
  Map<String, String> coll2 = {
    'DAP': "0.0",
    "Urea": "0.0",
    "MOP": "0.0",
  };
  String fertilizer131313 = "0.0";
  void calculate(npk) {
    setState(() {
      double totArea = area * 1.0;

      if (unit == Unit.Acre) {
        totArea = area * 0.1;
      }
      if (unit == Unit.SquareMeter) {
        totArea = area * 0.0001;
      }
      coll1['Urea'] = (((100 * npk[0]) / 46) * totArea).toStringAsFixed(2);
      coll1['SSP'] = (((100 * npk[1]) / 16) * totArea).toStringAsFixed(2);
      coll1['MOP'] = (((100 * npk[2]) / 60) * totArea).toStringAsFixed(2);

      double amountOfDapP = (100 * npk[1]) / 46;
      double amountOfDapN = (18 * amountOfDapP) / npk[0];
      double amountOfUreaN = npk[0] - amountOfDapN;

      coll2['DAP'] = (amountOfDapP * totArea).toStringAsFixed(2);
      coll2['Urea'] =
          (((100 * amountOfUreaN) / 46) * totArea).toStringAsFixed(2);
      coll2['MOP'] = (((100 * npk[2]) / 60) * totArea).toStringAsFixed(2);

      fertilizer131313 = (((100 * npk[0]) / 13) * totArea).toStringAsFixed(2);
    });
  }

  List<String> trees = [
    'Apple',
    "Olives",
    "Grapes",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Plantie'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: BlocBuilder<PlantBloc, PlantState>(builder: (context, state) {
          if (state is PlantInitial) {
            return const Center(child: Loader());
          }
          if (state is PlantLoaded) {
            return SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width * 0.95,
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
                                  margin: const EdgeInsets.only(
                                    top: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                      '${state.plants[state.selectedPlant].npk[0]} - ${state.plants[state.selectedPlant].npk[1]} - ${state.plants[state.selectedPlant].npk[2]}'),
                                )
                              ])),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                        margin: const EdgeInsets.only(top: 20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                  "Unit ${trees.contains(state.plants[state.selectedPlant].name)}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  )),
                              !trees.contains(
                                      state.plants[state.selectedPlant].name)
                                  ? Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.95,
                                      margin: const EdgeInsets.only(
                                          top: 20, bottom: 20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border:
                                            Border.all(color: Colors.black12),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                              flex: 1,
                                              child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      unit = Unit.Acre;
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                              topLeft: Radius
                                                                  .circular(5),
                                                              bottomLeft: Radius
                                                                  .circular(5)),
                                                      color: unit == Unit.Acre
                                                          ? Colors.grey[200]
                                                          : Colors.white60,
                                                    ),
                                                    child: const Center(
                                                      child: Text(
                                                        "Acres",
                                                      ),
                                                    ),
                                                  ))),
                                          Container(
                                            width: 1,
                                            height: 50,
                                            color: Colors.black12,
                                          ),
                                          Expanded(
                                              flex: 1,
                                              child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      unit = Unit.Hectare;
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          unit == Unit.Hectare
                                                              ? Colors.grey[200]
                                                              : Colors.white60,
                                                    ),
                                                    child: const Center(
                                                      child: Text(
                                                        "Hectare",
                                                      ),
                                                    ),
                                                  ))),
                                          Container(
                                            width: 1,
                                            height: 50,
                                            color: Colors.black12,
                                          ),
                                          Expanded(
                                              flex: 1,
                                              child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      unit = Unit.SquareMeter;
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                              topRight: Radius
                                                                  .circular(5),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          5)),
                                                      color: unit ==
                                                              Unit.SquareMeter
                                                          ? Colors.grey[200]
                                                          : Colors.white60,
                                                    ),
                                                    child: const Center(
                                                      child: Text(
                                                        "Square Meters",
                                                      ),
                                                    ),
                                                  ))),
                                        ],
                                      ))
                                  : const Text("Number of Tree"),
                              Card(
                                  elevation: 3,
                                  color: Colors.white,
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    height: 200,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            FilledButton(
                                                style: FilledButton.styleFrom(
                                                  minimumSize:
                                                      const Size(50, 50),
                                                  shape: const CircleBorder(),
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 230, 230, 230),
                                                  foregroundColor:
                                                      Colors.black54,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    if (area > 0) {
                                                      area--;
                                                    }
                                                    areaController.text =
                                                        area.toString();
                                                  });
                                                },
                                                child:
                                                    const Icon(Icons.remove)),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              width: 100,
                                              child: TextField(
                                                controller: areaController,
                                                textAlign: TextAlign.center,
                                                keyboardType:
                                                    TextInputType.number,
                                                onChanged: (value) {
                                                  setState(() {
                                                    area = int.parse(value);
                                                  });
                                                  areaController.text = value;
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                            FilledButton(
                                                style: FilledButton.styleFrom(
                                                  minimumSize:
                                                      const Size(50, 50),
                                                  shape: const CircleBorder(),
                                                  backgroundColor:
                                                      Colors.grey[200],
                                                  foregroundColor:
                                                      Colors.black54,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    area++;
                                                  });
                                                  areaController.text =
                                                      area.toString();
                                                },
                                                child: const Icon(Icons.add)),
                                          ],
                                        ),
                                        Button(
                                            text: "Calculate",
                                            onPressed: () {
                                              calculate(state
                                                  .plants[state.selectedPlant]
                                                  .npk);
                                            })
                                      ],
                                    ),
                                  )),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.95,
                                  height: 180,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      Card(
                                        elevation: 3,
                                        color: Colors.white,
                                        child: SizedBox(
                                          height: 150,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9, // Added width
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
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
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.9,
                                              )),
                                              SizedBox(
                                                height: 100,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text('${coll1['SSP']!} kg'),
                                                    Text(
                                                        '${coll1['Urea']!} kg'),
                                                    Text('${coll1['MOP']!} kg'),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Card(
                                        elevation: 3,
                                        color: Colors.white,
                                        child: SizedBox(
                                          height: 150,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9, // Added width
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text("DAP"),
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
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.9,
                                              )),
                                              SizedBox(
                                                height: 100,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text('${coll2['DAP']!} kg'),
                                                    Text(
                                                        '${coll2['Urea']!} kg'),
                                                    Text('${coll2['MOP']!} kg'),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Card(
                                        elevation: 3,
                                        color: Colors.white,
                                        child: SizedBox(
                                          height: 150,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9, // Added width
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text("13 - 13 - 13"),
                                                ],
                                              ),
                                              Center(
                                                  child: Container(
                                                height: 1,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                ),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.9,
                                              )),
                                              SizedBox(
                                                height: 100,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                        '$fertilizer131313 kg'),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ))
                            ]),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ));
          }
          return const Center(child: Text('404 Not Found'));
        }));
  }
}
