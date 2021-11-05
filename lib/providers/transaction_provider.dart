import 'package:flutter/foundation.dart';
import 'package:flutter_database/models/Transaction.dart';

/*
This class will send out notify to Consumer,
when data (Transaction) changed
*/
class TransactionProvider with ChangeNotifier {
  /// Test data set
  List<Transaction> transactions = [
    Transaction("Book", 15, DateTime.now()),
    Transaction("Shirt", 40, DateTime.now()),
    Transaction("Jean", 50, DateTime.now()),
    Transaction("Watch", 333, DateTime.now())
  ];

  List<Transaction> getTransaction() {
    return transactions;
  }

  void addTransaction(Transaction statement) {
    transactions.add(statement);
  }
}
