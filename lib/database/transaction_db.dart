/*
This Class deals with Database:
- Open/Close DB
- Read/Write/Edit DB

Database file name e.g : transactiondb.db
*/
import 'package:flutter_database/models/transactions.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class TransactionDB {
  var dbName; // Database name (MUST NOT BE NULL)

  /// If NOT yet created  =>  Create new DB
  /// If ALREADY created  =>  Open DB
  TransactionDB({this.dbName});

  /// Find (or create) and return In-device DB
  Future<Database> openDatabase() async {
    /// Get Database Path:
    ///
    /// Get current User account directory (path)
    /// e.g : users/jackk/
    var appDicectory = await getApplicationDocumentsDirectory();

    /// Comcatiation (combine) user directory path (string) with DatabaseName
    /// dbLocation : /data/user/0/com.example.flutter_database/app_flutter/transactions.db
    String dbLocation = join(appDicectory.path, dbName);

    /// Create DataBase :
    ///
    /// Get Database IO from Database Factory (Factory Pattern)
    DatabaseFactory dbFactory = databaseFactoryIo;

    /// Create new or Open existing Database that link to our Database path
    Database db = await dbFactory.openDatabase(dbLocation);

    return db;
  }

  /// Data storing method
  /// Key : Database => Store
  Future<int> insertData(Transactions statement) async {
    var db = await openDatabase();

    /// Create a store name "expense"
    var store = intMapStoreFactory.store("expense");

    /// Store statement(data) to Database, through Store, in JSON format
    /// When done, return stored data key ID of new added item
    var keyID = store.add(db, {
      "title": statement.title,
      "amount": statement.amount,
      "date": statement.date.toIso8601String()
    });

    db.close();

    return keyID;
  }

  /// Get data from Database
  Future<List<Transactions>> loadAllData() async {
    /// Access DataBase and Store
    var db = await openDatabase();
    var store = intMapStoreFactory.store("expense");

    /// Get all from Database,
    /// Return in List of SnapShot
    var snapshot = await store.find(db,

        /// Sort the given SnapShot,
        /// by KeyID (Field.key)
        /// false :  New to Old   ||   More to Less
        /// true  :  Old to New   ||   Less to More
        finder: Finder(sortOrders: [SortOrder(Field.key, false)]));

    // Return this List
    List<Transactions> transactionList = [];
    for (var record in snapshot) {
      transactionList.add(Transactions(
          title: record["title"],
          amount: record["amount"],
          date: DateTime.parse(record["date"].toString())));
    }

    db.close();

    return transactionList;
  }
}
