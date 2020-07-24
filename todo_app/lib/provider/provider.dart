import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:todoapp/modal/task.dart';
import 'package:todoapp/service/firebase.dart';
import 'package:uuid/uuid.dart';
import '../modal/task.dart';


class TaskProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  String _description;
  bool _isDone;
  var uuid = Uuid();

  String get description => _description;

  bool get isDone => _isDone;

  removeTask(String taskId) {
    firestoreService.removeTask(taskId);
  }

  final taskList = List<Task>();

  Task getById(String id) {
    return taskList.firstWhere((task) => task.taskId == id, orElse: () => null);
  }
}
