import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:todoapp/modal/task.dart';
import 'package:todoapp/service/firebase.dart';
import 'package:uuid/uuid.dart';

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

  optionCheck(bool value) {
    _isDone = value;
    notifyListeners();
  }

  createTask(Task task) {
    final newTask = Task(
      taskId: uuid.v4(),
      description: task.description,
    );
    firestoreService.createTask(newTask);
  }

  saveTask() {
    if (_taskId == null) {
      var newTask = Task(description: _description, taskId: uuid.v4());
      firestoreService.saveTask(newTask);
    } else {
      //Update
      var updatedTask = Task(description: _description, taskId: _taskId);
      firestoreService.saveTask(updatedTask);
    }
  }

  removeTask(String taskId) {
    firestoreService.removeTask(taskId);
  }
}
