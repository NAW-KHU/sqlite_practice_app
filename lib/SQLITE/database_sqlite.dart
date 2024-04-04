//Creating and opening the database
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_practice_app/Model/customer.dart';
import 'package:sqlite_practice_app/Model/customer_data.dart';

createDatabase() async {
  String databasePath = await getDatabasesPath();
  String dbPath = join(databasePath, 'my.db');

  if (kDebugMode) {
    print("path: $dbPath");
  }
  var database =
      await openDatabase(dbPath, version: 1, onCreate: (db, version) {
    return db.execute(
        'CREATE TABLE Customers(id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT)');
  });
  // if (kDebugMode) {
  //   print('table = $database');
  // }
  return database;
}

// void populatedDB(Database database, int version) async {
//   await database.execute(
//       'CREATE TABLE Customers (id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT)');
// }'

// Create customer in database table // insert()Method
// Future<int> createCustomer(Customer customer) async {
//   final Database db = await createDatabase();
//   var result = await db.insert('Customer', customer.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace);
//   return result;

// }

//rawInsert() Method
// Future createCustomer(Customer customer) async{
//   final Database db = await createDatabase();
//   var result = await db.rawInsert(
//     "INSERT INTO Customer(id, first_name, last_name, email)"
//     "VALUES (${customer.id}, ${customer.firstName}, ${customer.lastName}, ${customer.email})"
//   );
//   return result;
// }

Future<void> insertCustomers(List<Customer> customers) async {
  final db = await createDatabase();
  final batch = db.batch();

  for (final customer in customers) {
    batch.insert('Customers', {
      'id': customer.id,
      'firstname': customer.firstName,
      'lastname': customer.lastName,
      'email': customer.email,
      // "VALUES (${customer.id}, ${customer.firstName}, ${customer.lastName}, ${customer.email})"
    });
    if (kDebugMode) {
      print('Table= ');
      // print(customers.length);
      print(customer.id);
      print(customer.email);
      print(db);
    }
  }

  throw (customers.length);
}

// Read (All) operation
// query() Method
// Future<List> getCustomers() async {
//   final Database db = await createDatabase();
//   var result = await db
//       .query("Customers", columns: ["id", "first_name", "last_name", "email"]);
//   if (kDebugMode) {
//     print(result);
//   }
//   return result.toList();
// }

//Second method: rawQuery() Method
// Future<List> getCustomers() async {
//   final db = await createDatabase();
//   var result = await db.rawQuery('SELECT *FROM Customer');
//   return result.toList();
// }

//Read (by Id) Query() method
Future<List<Map<String, Object>>> getCustomers(int id) async {
  final db = await createDatabase();
  List<Map<String, Object>> results = await db.query('Customers',
      columns: ["id", "first_name", "last_name", "email"],
      where: 'id =?',
      whereArgs: [id]);

  // if (results.isNotEmpty) {
  //   return Customer.fromMap(results.first);
  // }
  if (kDebugMode) {
    print('result = $firstCustomer');
  }
  return results;
}

//second Approach: rawQuery() method
// Future<Customer> getCustomer1(int id) async {
//   final Database db = await createDatabase();
//   var results = await db.rawQuery('SELECT * FROM Customer');
//   if (results.isNotEmpty) {
//     return Customer.fromMap(results.first);
//   }
//   throw ("error occurs.");
// }

// Update the table entries
//First method update()
Future<int> updateCustomer(Customer customer) async {
  final Database db = await createDatabase();
  return db.update("Customers", customer.toMap());
}

//Second method rawUpdate()
// Future<int> updateCustomer1(Customer customer) async {
//   final Database db = await createDatabase();
//   return db.rawUpdate(
//       'UPDATE Customer SET first_name = ${customer.firstName} WHERE id = ${customer.id}');
// }

//Delete() Method
Future<int> deleteCustomer(int id) async {
  final Database db = await createDatabase();
  return await db.delete("Customers", where: 'id =?', whereArgs: [id]);
}

// rawDelete() method
// Future<int> deleteCustomer1(int id) async {
//   final Database db = await createDatabase();
//   return db.rawDelete('DELETE FROM Customer WHERE id = $id');
// }

//Closes DB
closeDatabase() async {
  final Database db = await createDatabase();
  await db.close();
}
