import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/provider/provider.dart';
import 'package:todoapp/modal/task.dart';
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
  String _inputDescription;
  bool _result;
  final _formKey = GlobalKey<FormState>();

  void _validateForm() {
    final task = Provider.of<TaskProvider>(context, listen: false);
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (!widget.isEditMode) {
        task.createTask();
      } else {
        task.createTask();
        task.removeTask(widget.taskId);
      }
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    if (widget.isEditMode) {
      _inputDescription = widget.description;
      _result = widget.isDone;
      final task = Provider.of<TaskProvider>(context, listen: false);
      task.getById(widget.taskId);
      task.loadValues(Task());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final task = Provider.of<TaskProvider>(context, listen: false);
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
                task.changeText(value);
              },
            ),
            SizedBox(
              height: 40,
            ),
            (!widget.isEditMode)
                ? Spacer()
                : Container(
                    alignment: Alignment.bottomRight,
                    child: FlutterSwitch(
                      activeText: "Complete!",
                      inactiveText: "Incomplete",
                      width: 200.0,
                      height: 50.0,
                      valueFontSize: 20.0,
                      toggleSize: 45.0,
                      value: _result,
                      borderRadius: 30.0,
                      padding: 8.0,
                      showOnOff: true,
                      onToggle: (isComplete) {
                        setState(() {
                          _result = isComplete;
                          task.updateOption(
                              id: widget.taskId, value: isComplete);
                          Navigator.of(context).pop();
                        });
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
