import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp/modal/task.dart';

class FirestoreService {
  Firestore _db = Firestore.instance;

  Future<void> editTask(Task task) {
    return _db.collection('tasks').document(task.taskId).setData(task.toMap());
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

  Future<void> removeTask(String taskId) {
    return _db.collection('tasks').document(taskId).delete();
  }

  Future<void> createTask(Task task) {
    return _db.collection('tasks').add({
      'taskId': task.taskId,
      'description': task.description,
      'isDone': task.isDone
    });
  }

  Future<void> changeStatus(bool newValue, Task task) {
    return _db
        .collection('tasks')
        .document(task.taskId)
        .updateData({'isDone': newValue});
  }
}
