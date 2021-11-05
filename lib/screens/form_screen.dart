// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FormScreen extends StatelessWidget {
  // const FormScreen({Key? key}) : super(key: key);

  /// Use to check (validate) State in Form Widget
  final formKey = GlobalKey<FormState>();

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
            /// Assign FormState Object to this Form Widget
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Item name Textfield
                TextFormField(
                  decoration: new InputDecoration(labelText: "Name"),
                  autofocus: true,
                  validator: (var str) {
                    /// If Text field is empty, return Error string
                    if (str!.isEmpty) {
                      return "Please Enter Item title";
                    }

                    /// If OK (not empty) return null, or just NOT return anything
                    return null;
                  },
                ),

                /// Item price Textfield
                TextFormField(
                  decoration: new InputDecoration(labelText: "Money Amount"),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Item price";
                    }
                    if (double.parse(value) <= 0) {
                      return "Item price can't be negative or zero";
                    }
                  },
                ),
                OutlinedButton(
                  child: Text(
                    "Adding",
                    style: TextStyle(color: Colors.blue),
                  ),
                  style: TextButton.styleFrom(primary: Colors.green),
                  onPressed: () {
                    /// If the written data has validated OK,
                    /// Else if unvalidated, show Error string
                    if (formKey.currentState!.validate()) {
                      /// Back to first screen
                      Navigator.pop(context);
                    }
                  },
                )
              ],
            ),
          ),
        ));
  }
}
