import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'models/tasks.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Hive.init((await getApplicationDocumentsDirectory()).path);
//  Hive.initFlutter((await getApplicationDocumentsDirectory()).path);

  Hive.registerAdapter<Task>(TaskAdapter());
  await Future.wait([Hive.openBox<Task>('tasks')]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: Color(0xff0D3257)),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  static const String routeName = '';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController myController = TextEditingController();
  TextEditingController myController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Box<Task> taskBox = Hive.box('tasks');
    return Scaffold(
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          itemCount: taskBox.length,
          itemBuilder: (BuildContext ctx, index) {
            return Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(taskBox.getAt(index)!.title),
                  Text(taskBox.getAt(index)!.descp),
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.amber, borderRadius: BorderRadius.circular(15)),
            );
          }),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                // Retrieve the text the that user has entered by using the
                // TextEditingController.
                content: Column(
                  children: [
                    TextField(
                      controller: myController,
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
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      myController.text = '';
                      myController2.text = '';
                      Navigator.pop(context, 'Cancel');
                      setState(() {});
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      taskBox.add(Task(myController.text, 'descp'));
                      myController.text = '';
                      myController2.text = '';
                      Navigator.pop(context, 'OK');
                      setState(() {});
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        },
        tooltip: 'Entered the task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
