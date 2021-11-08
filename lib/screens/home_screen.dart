// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_database/models/transactions.dart';
import 'package:flutter_database/providers/transaction_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          title: Text("Account Application"),
          actions: [
            /// Add Icon Button to AppBar (Top-Right)
            IconButton(
              icon: Icon(Icons.exit_to_app),

              /// EXIT APP when pressed Button
              onPressed: () {
                SystemNavigator.pop();
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
