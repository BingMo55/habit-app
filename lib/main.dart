import 'package:flutter/material.dart';
import 'package:habit_app/habit_add.dart';
import 'package:habit_app/habit_template.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: "/",
        routes: {
          "/": (context) => buildHabits(),
          "/addHabitScreen": (context) => add_habit_screen()
        },
        debugShowCheckedModeBanner: false);
  }
}

class buildHabits extends StatefulWidget {
  @override
  _buildHabitState createState() => _buildHabitState();
}

class _buildHabitState extends State<buildHabits> {
  //global variable for habits
  // TextEditingController habitName = new TextEditingController();

  // var datePreferences = {
  //   "U": false,
  //   "M": false,
  //   "T": false,
  //   "W": false,
  //   "R": false,
  //   "F": false,
  //   "S": false,
  // };
  // String hName = "";

  List<Habit> habitList = [
    Habit(
      name: "tes1",
      color: Colors.green,
    ),
    Habit(
      name: "tes1",
      color: Colors.green,
    )
  ];

  // void resetDatePreferences() {
  //   datePreferences["U"] = false;
  //   datePreferences["M"] = false;
  //   datePreferences["T"] = false;
  //   datePreferences["W"] = false;
  //   datePreferences["R"] = false;
  //   datePreferences["F"] = false;
  //   datePreferences["S"] = false;
  // }

  // void _addHabit(String habitName) {
  //   setState(() {
  //     int index = habitList.length;
  //     habitList.add(Habit(name: habitName, color: Colors.greenAccent));
  //   });
  // }

  Widget _buildHabitList() {
    ///[todo] add padding to each of the list tiles.
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.only(top: 8),
        itemBuilder: (BuildContext context, int index) => habitList[index],
        itemCount: habitList.length,
      ),
    );
  }

  String getDate(int weekdayNumber)
  // // date letter from
  // //https://eventguide.com/topics/one_digit_day_abbreviations.html
  {
    switch (weekdayNumber) {
      case 1:
        return "M";
      case 2:
        return "T";
      case 3:
        return "W";
      case 4:
        return "R";
      case 5:
        return "F";
      case 6:
        return "S";
      case 7:
        return "U";
    }
  }

  Widget createDateButton(DateTime date) {
    String weekday = getDate(date.weekday.toInt());
    return Flexible(
      child: SizedBox(
        width: 50, //we will need to set a predefine width
        child: FlatButton(
          padding: EdgeInsets.all(0),
          color: Colors.greenAccent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed: () {
            print(weekday + " PRESSED");
          },
          child: Column(
            children: <Widget>[Text(date.day.toString()), Text(weekday)],
          ),
        ),
      ),
    );
  }

  Widget createDateOptionButton() {
    return Flexible(
      child: IconButton(
        icon: Icon(
          Icons.more_vert,
          color: Colors.grey,
        ),
        onPressed: () {
          print("option clicked");
        },
      ),
    );
  }

  Widget _buildDatesButton() {
    var today = DateTime.now();

    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        createDateButton(today),
        createDateButton(today.add(Duration(days: 1))),
        createDateButton(today.add(Duration(days: 2))),
        createDateButton(today.add(Duration(days: 3))),
        createDateButton(today.add(Duration(days: 4))),
        createDateOptionButton()
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Habit List')),
      body: Column(
        children: [
          _buildDatesButton(),
          Expanded(child: _buildHabitList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final habit_name =
                await Navigator.pushNamed(context, "/addHabitScreen");

            ///[todo] receiving data results in black screen, otherwise it will be fine
            String habit = habit_name.toString();
            print(habit);
            if (habit != "") {
              // _addHabit(habit);
              setState(() {
                habitList.add(Habit(name: habit, color: Colors.greenAccent));
              });
            }
          },
          tooltip: 'Add task',
          child: new Icon(Icons.add)),
    );
  }
}
