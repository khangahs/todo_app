import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:todoapp/modal/task.dart';
import 'package:todoapp/service/firebase.dart';
import 'package:uuid/uuid.dart';
import '../modal/task.dart';

class TaskProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  String _description;
  String _taskId;
  bool _isDone;
  var uuid = Uuid();

  String get description => _description;

  String get taskId => _taskId;

  bool get isDone => _isDone;
  final taskList = List<Task>();

  Task getById(String id) {
    return taskList.firstWhere((task) => task.taskId == id, orElse: () => null);
  }

  changeText(String value) {
    _description = value;
    notifyListeners();
  }

  loadValues(Task task) {
    _description = task.description;
    _isDone = task.isDone;
    _taskId = task.taskId;
  }

  createTask() {
    String documentId = uuid.v4();
    var newTask =
        Task(taskId: documentId, description: description, isDone: false);
    return firestoreService.createTask(newTask);
  }

  updateOption({String id, bool value}) {
    _isDone = value;
    _taskId = id;
    return firestoreService.updateOption(taskId: taskId, newValue: isDone);
  }

  removeTask(String taskId) {
    firestoreService.removeTask(taskId);
  }
}
