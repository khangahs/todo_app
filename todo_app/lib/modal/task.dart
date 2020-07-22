class Task {
  final String taskId;
  String description;
  bool isDone;

  Task({
    this.taskId,
    this.description,
    this.isDone = false,
  });

  Map<String, dynamic> toMap() {
    return {'taskId': taskId, 'description': description, 'isDone': isDone};
  }

  Task.fromFirestore(Map<String, dynamic> firestore)
      : taskId = firestore['taskId'],
        description = firestore['description'],
        isDone = firestore['isDone'];
}
