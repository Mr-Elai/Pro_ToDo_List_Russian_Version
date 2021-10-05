import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:to_do_list_pro_project/theme/text_theme.dart';
import 'package:to_do_list_pro_project/utils/global_state.dart' as global;

class TableCalenderWidget extends StatefulWidget {
  final Function func;

  const TableCalenderWidget({required this.func});
  @override
  _TableCalenderWidgetState createState() => _TableCalenderWidgetState();
}

class _TableCalenderWidgetState extends State<TableCalenderWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarStyle: CalendarStyle(
        isTodayHighlighted: true,
      ),
      // onFormatChanged: (CalendarFormat format) {
      //   _calendarFormat = format;
      // },
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
      ),

      calendarBuilders: CalendarBuilders(
        dowBuilder: (context, day) {
          final text = DateFormat.E().format(day);

          return Center(
            child: Text(
              text.toUpperCase(),
              style: TextStyles.dateStyle,
            ),
          );
        },
      ),
      calendarFormat: _calendarFormat,
      headerVisible: true,
      startingDayOfWeek: StartingDayOfWeek.monday,
      firstDay: DateTime.utc(2020, 10, 16),
      lastDay: DateTime.utc(2100, 3, 14),
      focusedDay: _focusedDay,
      locale: 'ru_RU',
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          widget.func(_selectedDay.toString());

          log(_selectedDay.toString(), name: 'selected');
          log(_focusedDay.toString(), name: 'focused');
          _focusedDay = focusedDay; // update `_focusedDay` here as well
        });
      },
    );
  }
}
