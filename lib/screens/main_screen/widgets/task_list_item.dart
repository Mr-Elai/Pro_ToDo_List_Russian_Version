import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list_pro_project/data/models/task_model.dart';
import 'package:to_do_list_pro_project/resources/icons.dart';
import 'package:to_do_list_pro_project/screens/main_screen/blocs/task_list_bloc/task_list_bloc.dart';
import 'package:to_do_list_pro_project/theme/color_theme.dart';
import 'package:to_do_list_pro_project/theme/themes.dart';
import 'package:to_do_list_pro_project/utils/global_state.dart' as global;

class TaskListItem extends StatefulWidget {
  final TaskModel task;

  TaskListItem({required this.task});

  @override
  _TaskListItemState createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  bool _showContent = false;

  late DateFormat dateFormat;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    dateFormat = DateFormat('EEE. dd MMM', 'ru');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: ColorPalette.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: ColorPalette.white.withOpacity(0.03),
            spreadRadius: 0,
            blurRadius: 7,
            offset: Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                InkWell(
                  onTap: () {
                    BlocProvider.of<TaskListBloc>(context)
                      ..add(ChangeTaskDone(task: widget.task));
                  },
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 1, color: Colors.red),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.task.title,
                        style: TextStyles.subtitle1
                            .copyWith(color: ColorPalette.black1),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                widget.task.category,
                                style: TextStyles.subtitle4.copyWith(
                                    color: ColorPalette.grey1, height: 1),
                              ),
                              const SizedBox(width: 14),
                              widget.task.remindDate != ''
                                  ? Padding(
                                      padding: EdgeInsets.only(right: 3),
                                      child: Text(
                                        '${dateFormat.format(DateTime.parse(widget.task.remindDate ?? ''))}',
                                        style: TextStyles.subtitle4.copyWith(
                                            color: ColorPalette.grey1,
                                            height: 1),
                                      ),
                                    )
                                  : Offstage(),
                              widget.task.isRepeatable == true
                                  ? Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: SvgPicture.asset(
                                          MainIcons.repeatable),
                                    )
                                  : Offstage(),
                              widget.task.isRemind == true
                                  ? SvgPicture.asset(MainIcons.remindable)
                                  : Offstage(),
                            ],
                          ),
                          widget.task.subtasks.isNotEmpty
                              ? GestureDetector(
                                  child: SvgPicture.asset(_showContent
                                      ? MainIcons.close
                                      : MainIcons.open),
                                  onTap: () {
                                    setState(() {
                                      _showContent = !_showContent;
                                    });
                                  },
                                )
                              : Offstage(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _showContent
              ? Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  decoration: BoxDecoration(
                    color: ColorPalette.white,
                    border: Border(
                      top: BorderSide(
                        width: 1,
                        color: ColorPalette.grey2,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 10);
                          },
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.task.subtasks.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      widget.task.subtasks[index].isCompleted =
                                          !widget
                                              .task.subtasks[index].isCompleted;
                                    });
                                  },
                                  child: widget.task.subtasks[index].isCompleted
                                      ? Container(
                                          width: 16,
                                          height: 16,
                                          padding: EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.red,
                                          ),
                                          child:
                                              SvgPicture.asset(MainIcons.check),
                                        )
                                      : Container(
                                          width: 15,
                                          height: 15,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                width: 1, color: Colors.red),
                                          ),
                                        ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  widget.task.subtasks[index].title,
                                  style: widget.task.subtasks[index].isCompleted
                                      ? TextStyles.subtitle1.copyWith(
                                          color: ColorPalette.grey1,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        )
                                      : TextStyles.subtitle1
                                          .copyWith(color: ColorPalette.black1),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : Offstage(),
        ],
      ),
    );
  }
}
