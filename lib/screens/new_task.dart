import 'package:flutter/material.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';

class NewTask extends StatefulWidget {
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
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
      body: Container(alignment: Alignment.center, child: Text('lets go')),
    );
  }
}
