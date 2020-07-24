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

}
