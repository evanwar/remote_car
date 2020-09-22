import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class Driver extends StatefulWidget {
  final String adress;
  Driver({Key key, @required this.adress});

  @override
  _DriverState createState() => _DriverState();
}

class _DriverState extends State<Driver> {
  @override
  Widget build(BuildContext context) {
    final String AdressdDevice = (context.widget as Driver).adress;

    BluetoothConnection connection;

    void connectionAsync() async {
      try {
        connection = await BluetoothConnection.toAddress(AdressdDevice);
      } catch (e) {
        print(e);
      }
    }

    connectionAsync();

    return Scaffold(
        backgroundColor: const Color(0xFF192DA1),
        appBar: AppBar(
          backgroundColor: const Color(0xFF111E6C),
          title: const Text("Control Remoto"),
        ),
        body: Container(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FloatingActionButton(
                  heroTag: "btn_UP",
                  child: Icon(Icons.arrow_drop_up),
                  onPressed: () {
                    connection.output
                        .add(new Uint8List.fromList("DOWN".codeUnits));
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FloatingActionButton(
                    heroTag: "btn_LEFT",
                    child: Icon(Icons.arrow_left),
                    onPressed: () {
                      connection.output
                          .add(new Uint8List.fromList("RIGHT".codeUnits));
                    },
                  ),
                  FloatingActionButton(
                    heroTag: "btn_STOP",
                    backgroundColor: Colors.red,
                    child: Icon(Icons.stop),
                    onPressed: () {
                      connection.output
                          .add(new Uint8List.fromList("STOP".codeUnits));
                    },
                  ),
                  FloatingActionButton(
                    heroTag: "btn_RIGHT",
                    child: Icon(Icons.arrow_right),
                    onPressed: () {
                      connection.output
                          .add(new Uint8List.fromList("LEFT".codeUnits));
                    },
                  )
                ],
              ),
              FloatingActionButton(
                  heroTag: "btn_DOWN",
                  child: Icon(Icons.arrow_drop_down),
                  onPressed: () {
                    connection.output
                        .add(new Uint8List.fromList("UP".codeUnits));
                  })
            ],
          ),
        )));
  }
}
