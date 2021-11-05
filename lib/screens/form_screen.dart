// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Information Form"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),

          /// Form Widget
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: new InputDecoration(labelText: "Name"),
                  autofocus: true,
                ),
                TextFormField(
                  decoration: new InputDecoration(labelText: "Money Amount"),
                  keyboardType: TextInputType.number,
                ),
                OutlinedButton(
                  child: Text(
                    "Adding",
                    style: TextStyle(color: Colors.blue),
                  ),
                  style: TextButton.styleFrom(primary: Colors.green),
                  onPressed: () {
                    /// Back to first screen
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        ));
  }
}
