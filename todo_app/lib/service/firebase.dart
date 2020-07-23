import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp/modal/task.dart';
import 'package:uuid/uuid.dart';

class FirestoreService {
  Firestore _db = Firestore.instance;
  var uuid = Uuid();

  Future<void> editTask(String taskId) {
    Task task;
    return _db.collection('tasks').document(taskId).setData(task.toMap());
  }

  Future<void> optionCheck(Task task) {
    return _db
        .collection('tasks')
        .document(task.taskId)
        .updateData({'isDone': true});
  }

  Stream<List<Task>> getTasks() {
    return _db.collection('tasks').snapshots().map((snapshot) => snapshot
        .documents
        .map((document) => Task.fromFirestore(document.data))
        .toList());
  }
//Future <void> getTaskId(String taskId) {
//    return _db.collection('tasks').where(field)
//}
  Future<void> removeTask(String taskId) {
    return _db.collection('tasks').document(taskId).delete();
  }

  Future<void> changeStatus(bool newValue, Task task) {
    return _db
        .collection('tasks')
        .document(task.taskId)
        .updateData({'isDone': newValue});
  }
}
