import 'package:flutter/material.dart';

class CustomListView extends StatefulWidget {
  const CustomListView({super.key});

  @override
  State<CustomListView> createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  List<String> iconsList = [
    'assets/icons/apple.png',
    'assets/icons/green-beans.png',
    'assets/icons/corn.png',
    'assets/icons/cucumber.png',
    'assets/icons/grapes.png',
    'assets/icons/pepper.png',
    'assets/icons/potato.png',
    'assets/icons/olives.png',
    'assets/icons/tomato.png',
    'assets/icons/strawberry.png',
  ];
  Color iconBorderButtomSide = const Color(0xff777777);
  Color listBorderButtomSide = const Color(0xffE6E6E6);
  int selectedIconIndex = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: listBorderButtomSide, width: 1.1))),
      height: (size.height) * 0.1,
      width: size.width,
      child: ListView.builder(
          itemCount: iconsList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  selectedIconIndex = index;
                });
              },
              child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: index == selectedIconIndex
                                  ? iconBorderButtomSide
                                  : listBorderButtomSide,
                              width: 1.1))),
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      14.0, 14.0, 14.0, 18),
                  child: Image.asset(
                    iconsList[index],
                  )),
            );
          }),
    );
  }
}
