import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_list_pro_project/components/apply_button.dart';
import 'package:to_do_list_pro_project/data/models/task_model.dart';
import 'package:to_do_list_pro_project/resources/resources.dart';
import 'package:to_do_list_pro_project/screens/main_screen/blocs/task_list_bloc/task_list_bloc.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/expanded_settings.dart';
import 'package:to_do_list_pro_project/theme/color_theme.dart';
import 'package:to_do_list_pro_project/theme/text_theme.dart';
import 'package:to_do_list_pro_project/utils/global_state.dart' as global;

class TaskBottomSheet extends StatefulWidget {
  @override
  _TaskBottomSheetState createState() => _TaskBottomSheetState();
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
  TextEditingController taskController = TextEditingController();

  bool showExpandedSettings = false;

  GlobalKey<FormState> _formKey = GlobalKey();

  List<SubTask> addSubtasks() {
    List<SubTask> subtasks = [];
    if (global.store.get('subtask1') != null) {
      subtasks.add(SubTask(title: global.store.get('subtask1')));
    }
    if (global.store.get('subtask2') != null) {
      subtasks.add(SubTask(title: global.store.get('subtask2')));
    }
    return subtasks;
  }

  void clearStore() {
    global.store.set('subtask1', null);
    global.store.set('subtask2', null);
    global.store.set('category', null);
    global.store.set('periodChoose', null);
    global.store.set('isReminded', null);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.only(
          top: 44,
          bottom: 50,
          left: 30,
          right: 30,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Название задачи',
              style: TextStyles.dateStyle.copyWith(
                color: ColorPalette.grey3,
              ),
            ),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: taskController,
                validator: (value) {
                  if (value == '') {
                    return 'Введите название';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorPalette.grey6),
                    ),
                    isDense: true,
                    hintText: 'Задача',
                    hintStyle: TextStyles.subtitle5.copyWith(
                        color: ColorPalette.grey4,
                        fontWeight: FontWeight.w600)),
                style: TextStyles.subtitle5.copyWith(
                  color: ColorPalette.black1,
                  fontWeight: FontWeight.w600,
                ),
                minLines: 1,
                maxLines: 1,
              ),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showExpandedSettings = !showExpandedSettings;
                    });
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        showExpandedSettings ? MainIcons.close : MainIcons.open,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        Strings.expandedSettings,
                        style: TextStyles.subtitle5.copyWith(
                          color: ColorPalette.purple1,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                showExpandedSettings ? ExpandedSettings() : Offstage(),
                const SizedBox(height: 40),
                ApplyButton(
                    title: Strings.add,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<TaskListBloc>(context)
                          ..add(AddTaskEvent(
                              task: TaskModel(
                            title: taskController.text,
                            subtasks: addSubtasks(),
                            isRemind: global.store.get('isReminded') != null
                                ? global.store.get('isReminded')
                                : false,
                            isRepeatable:
                                global.store.get('periodChoose') != null
                                    ? true
                                    : false,
                            repeatDays: global.store.get('remindPeriod') != null
                                ? global.store.get('remindPeriod')
                                : 0,
                            isCompleted: false,
                            category: global.store.get('category') != null
                                ? global.store.get('category')
                                : 'Без категории',
                            indicatorColor: Colors.green,
                            remindDate: '20210601',
                          )));
                        Navigator.pop(context);
                        clearStore();
                      }
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
