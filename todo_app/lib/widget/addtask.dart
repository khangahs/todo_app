import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/provider/provider.dart';
import 'package:todoapp/modal/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import '../modal/task.dart';

class AddTask extends StatefulWidget {
  final String taskId;
  final String description;
  final bool isEditMode;
  final Task task;

  AddTask({this.taskId, this.description, this.isEditMode, this.task});

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  var uuid = Uuid();
  Firestore _db = Firestore.instance;
  Task task;
  String _inputDescription;
  final _formKey = GlobalKey<FormState>();

  Future<void> createTask(Task task) {
    String documentId = uuid.v4();
    Task task =
        Task(taskId: documentId, description: _inputDescription, isDone: false);
    return _db.collection('tasks').document(documentId).setData(task.toMap());
  }

  void _validateForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (!widget.isEditMode) {
        createTask(Task());
      } else {
        Provider.of<TaskProvider>(context, listen: false);
        createTask(Task());
      }
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    if (widget.isEditMode) {
      final taskList = Provider.of<List<Task>>(context);
      Task getById(String id) {
        return taskList.firstWhere((task) => task.taskId == id);
      }

      getById(task.taskId);
      _inputDescription = task.description;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Title', style: Theme.of(context).textTheme.headline6),
            TextFormField(
              initialValue:
                  _inputDescription == null ? null : _inputDescription,
              decoration: InputDecoration(
                hintText: 'Describe your task',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onSaved: (value) {
                _inputDescription = value;
              },
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: FlatButton(
                child: Text(
                  !widget.isEditMode ? 'ADD TASK' : 'EDIT TASK',
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontFamily: 'Lato',
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  _validateForm();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
