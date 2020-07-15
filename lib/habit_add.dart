import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:habit_app/habit_template.dart';
import 'package:habit_app/main.dart';

class add_habit_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('add habit')), body: habit_add_prompt_state(),
      // home: Container(color: Colors.greenAccent),
    );
  }
}

class habit_add_prompt_state extends StatefulWidget {
  _habit_add_prompt createState() => _habit_add_prompt();
}

class _habit_add_prompt extends State<habit_add_prompt_state> {
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

  void resetDatePreferences() {
    datePreferences["U"] = false;
    datePreferences["M"] = false;
    datePreferences["T"] = false;
    datePreferences["W"] = false;
    datePreferences["R"] = false;
    datePreferences["F"] = false;
    datePreferences["S"] = false;
  }

  Widget createDateSelectionButton(String date) {
    Color colorB = Colors.transparent;
    return Flexible(
      child: SizedBox(
        width: 30,
        child: FlatButton(
          padding: EdgeInsets.all(0),
          color: datePreferences[date] ? Colors.blueGrey : Colors.transparent,
          // color: datePreferences[date]?
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
          // _addHabit(habitName.text);
          Navigator.of(context).pop(habitName.text);
          habitName.clear();
          resetDatePreferences();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // return MaterialApp(
      // debugShowCheckedModeBanner: false,
      // home: Container(
      // color: Colors.greenAccent,
      // child: Expanded(
      child: Column(
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
      // ),
      // ),
    );
    //   return AlertDialog(
    //     content: Stack(
    //       overflow: Overflow.visible,
    //       children: <Widget>[
    //         Form(
    //           child: Column(
    //             mainAxisSize: MainAxisSize.min,
    //             children: <Widget>[
    //               _textFieldForm(),
    //               Padding(
    //                   padding: EdgeInsets.all(8.0),
    //                   child: createDateSelectionContainer()),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: <Widget>[
    //                   _cancelButtonWidget(),
    //                   _submitButtonWidget()
    //                 ],
    //               )
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
  }
}
