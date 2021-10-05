import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:to_do_list_pro_project/data/models/task_model.dart';
import 'package:to_do_list_pro_project/data/repositories/task_list_repo.dart';

part 'task_list_event.dart';

part 'task_list_state.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  TaskListBloc({required this.taskListRepo}) : super(TaskListInitial());

  TaskListRepo taskListRepo;

  @override
  Stream<TaskListState> mapEventToState(
    TaskListEvent event,
  ) async* {
    if (event is TaskListInitialEvent) {
      yield TaskListInitial();
    }
    if (event is TaskListLoadEvent) {
      yield TaskListLoading();
      try {
        yield TaskListLoaded(
          currentTasks: taskListRepo
              .getTasks()
              .where((element) => !element.isCompleted)
              .toList(),
          completedTasks: taskListRepo
              .getTasks()
              .where((element) => element.isCompleted)
              .toList(),
        );
      } catch (e) {
        e.toString();
        yield TaskListError();
      }
    }
    if (event is AddTaskEvent) {
      yield TaskListLoading();
      try {
        taskListRepo.addTask(event.task);
        yield TaskListLoaded(
          currentTasks: taskListRepo
              .getTasks()
              .where((element) => !element.isCompleted)
              .toList(),
          completedTasks: taskListRepo
              .getTasks()
              .where((element) => element.isCompleted)
              .toList(),
        );
      } catch (e) {
        e.toString();
        yield TaskListError();
      }
    }
    if (event is RemoveTaskEvent) {
      yield TaskListLoading();
      try {
        taskListRepo.removeTask(event.task);
        yield TaskListLoaded(
          currentTasks: taskListRepo
              .getTasks()
              .where((element) => !element.isCompleted)
              .toList(),
          completedTasks: taskListRepo
              .getTasks()
              .where((element) => element.isCompleted)
              .toList(),
        );
      } catch (e) {
        e.toString();
        yield TaskListError();
      }
    }
    if (event is ChangeTaskDone) {
      try {
        taskListRepo.removeTask(event.task);
        taskListRepo.addTask(event.task..isCompleted = !event.task.isCompleted);
        yield TaskListLoaded(
          currentTasks: taskListRepo
              .getTasks()
              .where((element) => !element.isCompleted)
              .toList(),
          completedTasks: taskListRepo
              .getTasks()
              .where((element) => element.isCompleted)
              .toList(),
        );
      } catch (e) {
        e.toString();
        yield TaskListError();
      }
    }
  }
}
