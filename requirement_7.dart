import 'package:flutter/material.dart';

class Task {
  String name;
  bool isCompleted;
  DateTime deadline;

  Task({required this.name, this.isCompleted = false, required this.deadline});
}
double calculatePerformance(List<Task> tasks) {
  int completedTasks = tasks.where((task) => task.isCompleted).length;
  int totalTasks = tasks.length;

  if (totalTasks == 0) {
    return 0.0; // Avoid division by zero
  }

  return (completedTasks / totalTasks) * 100.0;
}

double deductPointsForMissedDeadlines(List<Task> tasks) {
  DateTime now = DateTime.now();
  double deduction = 0.0;

  for (Task task in tasks) {
    print (task.isCompleted);
    print (task.name);
    if (!task.isCompleted && task.deadline.isBefore(now)) {
      // Deduct points for missed deadlines
      deduction += 5.0; // Adjust as needed
    }
  }

  return deduction;
}


void main() {
  List<Task> tasks = [
    Task(name: 'Task 1', deadline: DateTime(2023, 11, 15)),
    Task(name: 'Task 2', deadline: DateTime(2023, 11, 20)),
    // Add more tasks as needed
  ];
  // change the completed task
  tasks[0].isCompleted = true;
  tasks[1].isCompleted = false;
  runApp(MyApp(tasks: tasks));
}

class MyApp extends StatelessWidget {
  final List<Task> tasks;

  MyApp({required this.tasks});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(tasks: tasks),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final List<Task> tasks;

  MyHomePage({required this.tasks});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Performance Tracker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Performance: ${calculatePerformance(widget.tasks)}%\nDeduction: ${deductPointsForMissedDeadlines(widget.tasks)} points',
              style: TextStyle(fontSize: 18),
            ),
            // Add more UI components as needed
          ],
        ),
      ),
    );
  }
}
