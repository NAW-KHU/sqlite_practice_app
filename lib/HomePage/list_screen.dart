import 'package:flutter/material.dart';
import 'package:sqlite_practice_app/Model/customer.dart';
import 'package:sqlite_practice_app/Model/customer_data.dart';

class ListScreen extends StatelessWidget {
  ListScreen(Customer customer, {super.key});

  final customers = [firstCustomer, secondCustomer];
  @override
  Widget build(BuildContext context) {
    ListView.builder(
        itemCount: customers.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(customers[index].email),
          );
        });
    throw ();
  }
}
