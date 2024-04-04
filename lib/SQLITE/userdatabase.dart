//Creating and opening the database
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_practice_app/Model/customer.dart';

createDatabase() async {
  String databasePath = await getDatabasesPath();
  String dbPath = join(databasePath, 'userdata.db');

  if (kDebugMode) {
    print("path: $dbPath");
  }
  final database =
      await openDatabase(dbPath, version: 1, onCreate: (db, version) {
    return db.execute(
        'CREATE TABLE IF NOT EXISTS Userdata(id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT)');
  });
  if (kDebugMode) {
    print('databaseIsOpen = ${database.isOpen}');
    print('table= ${database.toString()}');
  }
  return database;
}

// void populatedDB(Database database, int version) async {
//   await database.execute(
//       'CREATE TABLE Customers (id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT)');
// }'

//Create customer in database table // insert()Method
Future<int> createCustomer(Customer customer) async {
  final Database db = await createDatabase();
  var result = await db.insert('Userdata', customer.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);

  if (kDebugMode) {
    print('id= ${customer.id}, email = ${customer.email}');
  }
  return result;
}

//rawInsert() Method
// Future createCustomer(Customer customer) async{
//   final Database db = await createDatabase();
//   var result = await db.rawInsert(
//     "INSERT INTO Customer(id, first_name, last_name, email)"
//     "VALUES (${customer.id}, ${customer.firstName}, ${customer.lastName}, ${customer.email})"
//   );
//   return result;
// }

// Future<Customer> insertCustomers(List<Customer> customers) async {
//   final db = await createDatabase();
//   final batch = db.batch();

//   for (var customer in customers) {
//     batch.insert('Customers', {
//       'id': customer.id,
//       'firstname': customer.firstName,
//       'lastname': customer.lastName,
//       'email': customer.email,
//     },
// "VALUES (${customer.id}, ${customer.firstName}, ${customer.lastName}, ${customer.email})"
// );
// if (kDebugMode) {
//   print('Table= ');
//   // print(customers.length);
//   print(customer.id);
//   print(customer.email);
//   print(db);
// }
// }

//   throw ('length: ${customers.length}');
// }

// Read (All) operation
// query() Method
Future<List<Map<String, Object>>> getCustomers(int id) async {
  try {
    final db = await createDatabase();
    await db.query(
      'Userdata',
      columns: ["id", "first_name", "last_name", "email"],
      where: 'id = ?',
      whereArgs: [id],
    );

    // for (var user in result) {
    //   if (kDebugMode) {
    //     print(user);
    //   }
    // }
    return [];
  } catch (e) {
    if (kDebugMode) {
      print("Error fetching customer data: $e");
    }
    return []; // Return an empty list in case of an error
  }
}

// Future<List<Customer>> getCustomers() async {
//   try {
//     final db = await createDatabase();
//     final List<Map<String, dynamic>> customer = await db.query('Userdata');
//     return List.generate(
//         customer.length,
//         (i) => Customer(
//             id: customer[i]['id'],
//             firstName: customer[i]['first_Name'],
//             lastName: customer[i]['last_Name'],
//             email: customer[i]['email']));
//   } catch (e) {
//     if (kDebugMode) {
//       print(e);
//     }
//   }
//   return [];
// }

//Second method: rawQuery() Method
// Future<List> getCustomers() async {
//   final db = await createDatabase();
//   var result = await db.rawQuery('SELECT *FROM Customer');
//   return result.toList();
// }

//Read (by Id) Query() method
// Future<List<Map<String, Object?>>> getCustomers(int id) async {
//   final db = await createDatabase();
//   List<Map<String, Object?>> results = await db.query('Customers',
//       columns: ["id", "first_name", "last_name", "email"],
//       where: 'id =?',
//       whereArgs: [id]);

//   // if (results.isNotEmpty) {
//   //   return Customer.fromMap(results.first);
//   // }
//   if (kDebugMode) {
//     print(id);
//   }
//   return results;
// }

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
  return db.update("Userdata", customer.toMap());
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
  return await db.delete("Userdata", where: 'id =?', whereArgs: [id]);
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
