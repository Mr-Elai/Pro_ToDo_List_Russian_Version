import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:to_do_list_pro_project/resources/icons.dart';
import 'package:to_do_list_pro_project/screens/main_screen/screen2.dart';
import 'package:to_do_list_pro_project/screens/main_screen/screen1.dart';
import 'package:to_do_list_pro_project/screens/main_screen/screen.dart';
import 'package:to_do_list_pro_project/theme/color_theme.dart';
import 'package:to_do_list_pro_project/utils/global_state.dart' as global;

import 'database/squlite.dart';


class MyBottomNavbar extends StatefulWidget {

  @override
  _MyBottomNavbarState createState() => _MyBottomNavbarState();
}

class _MyBottomNavbarState extends State<MyBottomNavbar> {

  int _currentIndex = 0;
  final List<Widget> _children =
  [
    Screen2(),
    Screen1(),
    Screen(),

  ];

  void onTappedBar(int index)
  {
    setState(() {
      _currentIndex =index;
    });
  }
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar
        (
        backgroundColor: ColorPalette.white1,
        selectedItemColor: ColorPalette.purple1,
        unselectedItemColor: ColorPalette.grey3,
        elevation: 0.0,

        onTap: onTappedBar,
        currentIndex: _currentIndex,

        items:
        [
          BottomNavigationBarItem
            (
            icon: new Icon(Icons.track_changes_outlined),
            label: "Цели",
          ),
          BottomNavigationBarItem
            (
            icon: new Icon(Icons.donut_large_outlined),
            label: "Колесо",
          ),
          BottomNavigationBarItem
            (
            icon: new Icon(Icons.fact_check_outlined),
            label: "Задачи",
          ),
        ],
      ),
    );
  }
}
