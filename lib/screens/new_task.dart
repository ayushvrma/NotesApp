import 'package:flutter/material.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/models/tasks.dart';

class NewTask extends StatefulWidget {
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  TextEditingController myController = TextEditingController();
  TextEditingController myController2 = TextEditingController();
  final Box<Task> taskBox = Hive.box('tasks');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
      ),
      bottomNavigationBar: CustomNavigationBar(
          iconSize: 25.0,
          selectedColor: Colors.white,
          strokeColor: Colors.white,
          unSelectedColor: Colors.grey[600],
          backgroundColor: Colors.black,
          blurEffect: true,
          opacity: 0.8,
          items: [
            CustomNavigationBarItem(icon: Icon(Icons.palette)),
            CustomNavigationBarItem(icon: Icon(Icons.more))
          ]),
      body: Column(
        children: [
          TextField(
            controller: myController,
            onChanged: (text) {
              taskBox.add(Task(myController.text, ''));
              myController.text = '';
            },
            autofocus: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter a Task',
            ),
          ),
          TextField(
            controller: myController2,
            autofocus: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter a Description',
            ),
          ),
        ],
      ),
    );
  }
}
