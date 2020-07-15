import 'package:flutter/material.dart';
import 'package:habit_app/habit_template.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        home: buildHabits(),
        debugShowCheckedModeBanner: false);
  }
}

class buildHabits extends StatefulWidget {
  @override
  _buildHabitState createState() => _buildHabitState();
}

class _buildHabitState extends State<buildHabits> {
  //global variable for habits
  TextEditingController habitName = new TextEditingController();
  var datePreferences = {
    "U": false,
    "M": false,
    "T": false,
    "W": false,
    "R": false,
    "F": false,
    "S": false,
  };
  String hName = "";
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

  void resetDatePreferences() {
    datePreferences["U"] = false;
    datePreferences["M"] = false;
    datePreferences["T"] = false;
    datePreferences["W"] = false;
    datePreferences["R"] = false;
    datePreferences["F"] = false;
    datePreferences["S"] = false;
  }

  void _addHabit(String habitName) {
    setState(() {
      int index = habitList.length;
      habitList.add(Habit(name: habitName, color: Colors.greenAccent));
      Navigator.of(context).pop();
    });
  }

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
  // date letter from
  //https://eventguide.com/topics/one_digit_day_abbreviations.html
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

  Widget createDateSelectionButton(String date) {
    Color colorB = Colors.transparent;
    return Flexible(
      child: SizedBox(
        width: 30,
        child: FlatButton(
          padding: EdgeInsets.all(0),
          // color: datePreferences[date] ? Colors.blueGrey : Colors.transparent,
          color: colorB,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed: () {
            setState(() {
              print(datePreferences[date]);
              datePreferences[date] = !datePreferences[date];
              colorB = Colors.blueGrey;
            });
          },
          child: Align(
            alignment: Alignment.center,
            child: Text(
              date,
              style: TextStyle(fontSize: 15),
            ),
          ),
        ),
      ),
    );
  }

  Widget createDateSelectionContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        createDateSelectionButton("U"),
        createDateSelectionButton("M"),
        createDateSelectionButton("T"),
        createDateSelectionButton("W"),
        createDateSelectionButton("R"),
        createDateSelectionButton("F"),
        createDateSelectionButton("S"),
      ],
    );
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

  Widget _textFieldForm() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        controller: habitName,
        decoration: const InputDecoration(
            hintText: 'Habit Name', labelText: 'Habit Name'),
      ),
    );
  }

  Widget _cancelButtonWidget() {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: FlatButton(
        child: Text("Cancel"),
        onPressed: () {
          Navigator.of(context).pop();
          habitName.clear();
          resetDatePreferences();
        },
      ),
    );
  }

  Widget _submitButtonWidget() {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: FlatButton(
        child: Text("Submit"),
        onPressed: () {
          _addHabit(habitName.text);
          habitName.clear();
          resetDatePreferences();
        },
      ),
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
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Form(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              _textFieldForm(),
                              Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: createDateSelectionContainer()),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  _cancelButtonWidget(),
                                  _submitButtonWidget()
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });
          },
          tooltip: 'Add task',
          child: new Icon(Icons.add)),
    );
  }
}
