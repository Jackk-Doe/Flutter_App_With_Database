// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_database/screens/form_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Account Application'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            /// Add Icon Button to AppBar (Top-Right)
            IconButton(
              icon: Icon(Icons.add_shopping_cart),

              /// Change page when pressed Button
              onPressed: () {
                /// Push the returning Widget to a Navigator Widget's stack
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  /// Return FormScreen Widget (form_screen.dart)
                  return FormScreen();
                }));
              },
            )
          ],
        ),
        body: ListView.builder(
            itemCount: 4,
            itemBuilder: (context, int index) {
              /// Card Widget (Card shape box)
              return Card(
                /// Card's shadow density
                elevation: 5,

                /// Empty gap between each Card
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),

                /// Cover ListTile with Card Widget
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,

                    /// Used FittedBox Widget within CircleAvatar Widget
                    /// to control text formating (scaling)
                    child: FittedBox(
                      child: Text("50000"),
                    ),
                  ),
                  title: Text("Menu"),
                  subtitle: Text("02/01/2021"),
                ),
              );
            }));
  }
}
