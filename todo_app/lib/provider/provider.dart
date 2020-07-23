import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:todoapp/modal/task.dart';
import 'package:todoapp/service/firebase.dart';
import 'package:uuid/uuid.dart';

import '../modal/task.dart';
import '../modal/task.dart';

class TaskProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  String _taskId;
  String _description;
  bool _isDone;
  var uuid = Uuid();

  String get description => _description;

  bool get isDone => _isDone;

  changeName(String value) {
    _description = value;
    notifyListeners();
  }

  loadValues(Task task) {
    _description = task.description;
    _taskId = task.taskId;
  }

  optionCheck(Task task) {
//    var updateOption = Task(isDone: task.isDone);
    firestoreService.optionCheck(Task(taskId: task.taskId));
  }

//  createTask(Task task) {
//    firestoreService.createTask(Task(description: task.description));
//  }

//  editTask(Task task) {
//    //Update
//    var updatedTask = Task(description: task.description, taskId: _taskId);
//    firestoreService.editTask(updatedTask);
//  }

  removeTask(String taskId) {
    firestoreService.removeTask(taskId);
  }

  changeStatus(bool isComplete, Task task) {
    bool isComplete;
    final newTask = Task(
      taskId: task.taskId,
      description: task.description,
    );
    firestoreService.changeStatus(isComplete, newTask);
  }
}
