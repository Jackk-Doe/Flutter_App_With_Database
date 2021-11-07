import 'package:flutter/foundation.dart';
import 'package:flutter_database/models/transaction.dart';

/*
This class will send out notify to Consumer,
when data (Transaction) changed
*/
class TransactionProvider with ChangeNotifier {
  /// Test data set
  List<Transaction> transactions = [
    /* Empty the List */
    // Transaction(title: "Shirt", amount: 40, date: DateTime.now()),
    // Transaction(title: "Book", amount: 15, date: DateTime.now()),
    // Transaction(title: "Jean", amount: 50, date: DateTime.now()),
    // Transaction(title: "Watch", amount: 333, date: DateTime.now())
  ];

  List<Transaction> getTransaction() {
    return transactions;
  }

  void addTransaction(Transaction statement) {
    /// Add new statement to front
    transactions.insert(0, statement);

    /*
    Notify Consumer (reload), that data in Provider has changed
    */
    notifyListeners();
  }
}
