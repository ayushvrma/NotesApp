import 'package:hive/hive.dart';

part 'tasks.g.dart';

@HiveType(typeId: 1)
class Task {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String descp;

  Task(this.title, this.descp);
}
