import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_list_pro_project/resources/resources.dart';
import 'package:to_do_list_pro_project/screens/advertisement_screen/screen.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/categories_list_row.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/database/squlite.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/drawer_widget.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/edit_task_bottomsheet.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/goal_expanded_settings.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/goal_task_bottom_sheet.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/goal_task_list_widget.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/long_term.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/long_term_goal_widget.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/medium_term.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/medium_term_goal_widget.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/short_term.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/short_term_goal_widget.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/task_bottom_sheet.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/task_list_widget.dart';
import 'package:to_do_list_pro_project/theme/color_theme.dart';
import 'package:to_do_list_pro_project/theme/text_theme.dart';
import 'package:to_do_list_pro_project/utils/global_state.dart' as global;

class Screen2 extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ColorPalette.white1,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
                child: SvgPicture.asset(
                  MainIcons.menu,
                  fit: BoxFit.scaleDown,
                ),
              ),
              Text(
                Strings.goals,
                style: TextStyles.header3.copyWith(color: ColorPalette.black1),
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdvertisementScreen()));
                },
                child: SvgPicture.asset(MainIcons.brilliant),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      drawer: DrawerWidget(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CategoriesListRow(),
              const SizedBox(height: 20),
              ShortTerm(),
              const SizedBox(height: 20),
              MediumTerm(),
              const SizedBox(height: 20),
              LongTerm(),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 30, right: 18),
        child: FloatingActionButton(
          elevation: 20,
          backgroundColor: ColorPalette.purple1,
          onPressed: () {
            showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return Wrap(
                    children: [
                      BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: GoalTaskBottomSheet()),
                    ],
                  );
                });
          },
          child: SvgPicture.asset(MainIcons.plus),
        ),
      ),
    );
  }
}
