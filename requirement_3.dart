import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TimeOfDay _selectedTime = TimeOfDay.now();
  DateTime _selectedDate = DateTime.now();
  List<Map>todayTasks=[];
  List<Map>thisWeekTasks=[];
  void _showDueDatePicker() async {
    final DateTime? picked1 = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: _selectedDate,
      lastDate: DateTime.parse('2100-01-01')
    );

    if (picked1 != null && picked1 != _selectedDate) {
      setState(() {
        _selectedDate = picked1;
      });
    }
    final TimeOfDay? picked2 = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (picked2 != null && picked2 != _selectedTime) {
      setState(() {
        _selectedTime = picked2;
      });
    }
  }
  bool isThisWeek(DateTime date1){
    DateTime now = DateTime.now();
    int diffmon = now.weekday - DateTime.monday;
    int diffsun = DateTime.sunday-now.weekday;
    DateTime monday = now.subtract(Duration(days: diffmon));
    DateTime sunday = now.add(Duration(days: diffsun));
    int mondayOfYear = int.parse(DateFormat("D").format(monday));
    int sundayOfYear = int.parse(DateFormat("D").format(sunday));
    int inputdayOfYear = int.parse(DateFormat("D").format(date1));
    return inputdayOfYear>=mondayOfYear && inputdayOfYear<=sundayOfYear;
  }
  bool isToday(DateTime date1){
    DateTime today = DateTime.now();
    return date1.year == today.year &&
        date1.month == today.month &&
        date1.day == today.day;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Picker Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Selected Due date:\n ${DateFormat.yMMMd().format(_selectedDate)}\n ${_selectedTime.format(context)}",

              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showDueDatePicker,
              child: Text('Select Time'),
            ),
          ],
        ),
      ),
    );
  }
}
