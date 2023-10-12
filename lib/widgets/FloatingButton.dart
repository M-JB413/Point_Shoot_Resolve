import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class Temp extends StatefulWidget {
  @override
  _TempState createState() => _TempState();
}

class _TempState extends State<Temp> {
  bool showOptions = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temp Page'),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Press the button below',
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
      ),
      floatingActionButton: SpeedDial(
        overlayOpacity: 0.3,
        overlayColor: Colors.white30,
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
            child: Icon(Icons.list),
            label: "All"
          ),
          SpeedDialChild(
            child: Icon(Icons.assignment_ind_outlined),
            label: "Admin Office"
          ),
          SpeedDialChild(
            child: Icon(Icons.plumbing_rounded),
            label: "Plumbing Department"
          ),
          SpeedDialChild(
            child: Icon(Icons.hardware_rounded),
            label: "Hardware Department"
          ),
          SpeedDialChild(
            child: Icon(Icons.electrical_services_rounded),
            label: "Electrical Department",
          )
        ],

      ),
    );
  }
}
