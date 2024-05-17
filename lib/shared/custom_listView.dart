import 'package:flutter/material.dart';

class CustomListView extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onTap;
  const CustomListView(
      {super.key, required this.selectedIndex, required this.onTap});

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
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: double.infinity,
      child: ListView.builder(
          itemCount: iconsList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                widget.onTap(index);
              },
              child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: index == widget.selectedIndex
                                  ? iconBorderButtomSide
                                  : listBorderButtomSide,
                              width: 1.1))),
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      14.0, 14.0, 14.0, 18),
                  child: Image.asset(
                    height: 50,
                    iconsList[index],
                  )),
            );
          }),
    );
  }
}
