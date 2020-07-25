import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp/modal/task.dart';
import 'package:uuid/uuid.dart';

class FirestoreService {
  Firestore _db = Firestore.instance;
  var uuid = Uuid();

  Stream<List<Task>> getTasks() {
    return _db.collection('tasks').snapshots().map((snapshot) => snapshot
        .documents
        .map((document) => Task.fromFirestore(document.data))
        .toList());
  }

  Future<void> removeTask(String taskId) {
    return _db.collection('tasks').document(taskId).delete();
  }

  Future<void> updateOption({String taskId, bool newValue}) {
    return _db
        .collection('tasks')
        .document(taskId)
        .updateData({'isDone': newValue});
  }

  Future<void> createTask(Task task) {
    return _db.collection('tasks').document(task.taskId).setData(task.toMap());
  }
}
