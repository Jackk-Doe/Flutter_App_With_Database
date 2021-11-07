// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_database/models/transactions.dart';
import 'package:flutter_database/providers/transaction_provider.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatelessWidget {
  // const FormScreen({Key? key}) : super(key: key);

  /// Use to check (validate) State in Form Widget
  final formKey = GlobalKey<FormState>();

  /// Controller :
  /// Store value from <code>title<code> TextFormField Widget
  final titleController = TextEditingController();

  /// Store value from <code>amout<code> TextFormField Widget
  final amountController = TextEditingController();

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
                  decoration: new InputDecoration(labelText: "Title"),
                  autofocus: true,
                  controller: titleController,
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
                  controller: amountController,
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
                      /// Get user inputed values (from Controller)
                      var title = titleController.text;
                      var amount = amountController.text;

                      /// Create a new statement
                      Transactions newStatement = Transactions(
                          title: title, amount: amount, date: DateTime.now());

                      /// Call Provider
                      TransactionProvider provider =
                          Provider.of<TransactionProvider>(context,
                              listen: false);

                      /// Add the new statement to Provider
                      provider.addTransaction(newStatement);

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
