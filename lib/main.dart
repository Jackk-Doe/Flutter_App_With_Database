// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_database/providers/transaction_provider.dart';
import 'package:flutter_database/screens/form_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_database/models/transactions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*
    Use MultiProvider, incase of dealing with multiple Provider
    Connecting Provider (TransactionProvider) with main.dart, through MultiProvider
    */
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return TransactionProvider();
        })
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Account Application'),
      ),
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
  void initState() {
    super.initState();

    /// Tell Provider to get data from DataBase, also notify Consumer
    Provider.of<TransactionProvider>(context, listen: false).initData();
  }

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
        /*
        Consumer take data (or listen to changing data) from Provider,
        then return Widget from the given data
        */
        body: Consumer(
          /// The below Provider linking to Provider in <line>line 24<line>
          builder: (context, TransactionProvider provider, child) {
            /// Count how many items, do the transaction in Provider
            var count = provider.transactions.length;

            /// If transactions(list) in Provider is empty
            if (count <= 0) {
              return Center(
                  child: Text(
                "Empty Transaction",
                style: TextStyle(fontSize: 35),
              ));
            } else {
              return ListView.builder(
                  itemCount: provider.transactions.length,
                  itemBuilder: (context, int index) {
                    /// Get reference to each Transaction from Provider
                    Transactions data = provider.transactions[index];

                    /// Card Widget (Card shape box)
                    return Card(
                      /// Card's shadow density
                      elevation: 5,

                      /// Empty gap between each Card
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 5),

                      /// Cover ListTile with Card Widget
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,

                          /// Used FittedBox Widget within CircleAvatar Widget
                          /// to control text formating (scaling)
                          child: FittedBox(
                            child: Text(data.amount.toString()),
                          ),
                        ),
                        title: Text(data.title),
                        subtitle: Text(
                            DateFormat("dd/MM/yyy  EEE").format(data.date)),
                      ),
                    );
                  });
            }
          },
        ));
  }
}
