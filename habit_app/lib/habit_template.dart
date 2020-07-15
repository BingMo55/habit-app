import 'package:flutter/material.dart';
import 'package:meta/meta.dart'; // for @requried

//const values

// class Habit extends StatefulWidget{
//   final String name;
//   final ColorSwatch color;
//   Habit({Key key,
//     @required this.name,
//     @required this.color,
//   }): assert(name != null),
//       assert(color != null),
//       super(key:key);
//   @override
//   _HabitState createState() => _HabitState();
// }

// class _HabitState extends State<Habit>
class Habit extends StatelessWidget {
  final String name;
  final ColorSwatch color;

  //consturctor for our habit state
  // _HabitState({
  Habit({
    Key key,
    @required this.name,
    @required this.color,
  })  : assert(name != null),
        assert(color != null),
        super(key: key);

  // builds the actual habit tab
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
      child: Material(
        // color: Color(0xFFf4b551),
        color: Color(0xFFD35400),
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 50,
          child: InkWell(
            onTap: () {
              print("pressed!");
            },
            child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  children: <Widget>[
                    Text(
                      name,
                      style: DefaultTextStyle.of(context)
                          .style
                          .apply(fontSizeFactor: 1.25),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
