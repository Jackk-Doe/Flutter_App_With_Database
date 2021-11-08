import 'package:flutter/foundation.dart';
import 'package:flutter_database/database/transaction_db.dart';
import 'package:flutter_database/models/transactions.dart';

/*
This class will send out notify to Consumer,
when data (Transaction) changed
*/
class TransactionProvider with ChangeNotifier {
  /// Test data set
  List<Transactions> transactions = [
    /* Empty the List */
    // Transaction(title: "Shirt", amount: 40, date: DateTime.now()),
    // Transaction(title: "Book", amount: 15, date: DateTime.now()),
    // Transaction(title: "Jean", amount: 50, date: DateTime.now()),
    // Transaction(title: "Watch", amount: 333, date: DateTime.now())
  ];

  List<Transactions> getTransaction() {
    return transactions;
  }

  /*
  Call this method, when START running App
  */
  void initData() async {
    /// Load data from DataBase
    var db = TransactionDB(dbName: "transactions.db");
    transactions = await db.loadAllData();
    notifyListeners();
  }

  void addTransaction(Transactions statement) async {
    /// Access Database
    var db = TransactionDB(dbName: "transactions.db");

    /// Store data to DataBase
    await db.insertData(statement);

    /// Get Data from DataBase,
    /// Then assign to transaction list
    transactions = await db.loadAllData();

    /*
    Notify Consumer (reload), that data in Provider has changed
    */
    notifyListeners();
  }
}
