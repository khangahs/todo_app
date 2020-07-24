import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
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
  final bool isDone;

  AddTask({this.taskId, this.description, this.isDone, this.isEditMode});

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
        final task = Provider.of<TaskProvider>(context, listen: false);
        createTask(Task());
        task.removeTask(widget.taskId);
      }
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    if (widget.isEditMode) {
      task = Provider.of<TaskProvider>(context, listen: false)
          .getById(widget.taskId);
      _inputDescription = widget.description;
    }
    super.initState();
  }

  void updateStatus(bool newValue) async {
    await _db
        .collection('tasks')
        .document(widget.taskId)
        .updateData({'isDone': newValue});
  }

  @override
  Widget build(BuildContext context) {
    bool result = widget.isDone;
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
              height: 40,
            ),
            (!widget.isEditMode)
                ? Spacer()
                : Container(
                    alignment: Alignment.bottomRight,
                    child: LiteRollingSwitch(
                      value: result,
                      textOn: 'Complete',
                      textOff: 'Incomplete',
                      colorOn: Colors.greenAccent[700],
                      colorOff: Colors.redAccent[700],
                      iconOn: Icons.done,
                      iconOff: Icons.remove_circle_outline,
                      textSize: 16.0,
                      onTap: () {
                        Future.delayed(Duration(seconds: 2), () {
                          setState(() {
                            Navigator.of(context).pop();
                          });
                        });
                      },
                      onChanged: (bool newValue) async {
                        result = newValue;
                        updateStatus(newValue);
                      },
                    ),
                  ),
            Spacer(),
            Container(
              alignment: Alignment.center,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0),
                ),
                padding: EdgeInsets.all(0.0),
                textColor: Colors.white,
                child: Ink(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Container(
                    constraints:
                        BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                    alignment: Alignment.center,
                    child: Text(
                      !widget.isEditMode ? 'ADD TASK' : 'EDIT TASK',
                      style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
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
