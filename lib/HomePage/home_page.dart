import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_practice_app/Model/customer.dart';
import 'package:sqlite_practice_app/Model/customer_data.dart';
import 'package:sqlite_practice_app/SQLITE/userdatabase.dart';
// import 'package:sqlite_practice_app/HomePage/list_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// @override
// void initState() {
//   createDatabase();
//   initState();
// }

final Database db = createDatabase();

@override
class _HomePageState extends State<HomePage> {
  List customerList = [];

// get customer => {
//   'id':[1,2]
// };

  Future<List<Map<String, Object>>> addCustomers() async {
    final listOfCustomers = [
      firstCustomer,
      secondCustomer,
      thirdCustomer,
      fourthCustomer,
      fifthCustomer
    ];

    for (Customer customer in listOfCustomers) {
      await createCustomer(customer);
      if (kDebugMode) {
        //   print('length: ${listOfCustomers.length}');
        // print("CustomerId: ${customer.id}");
        //   print("Name: ${customer.firstName} ${customer.lastName}");
        print("email: ${customer.email}");
        print('Name: ${customer.firstName} ${customer.lastName}');
      }
    }

    return [];
  }

  // Future<Customer> showCustomers(Customer customers) async {
  //   try {
  //     await getCustomers(customers, customers.id);
  //     if (kDebugMode) {
  //       print(customers.email);
  //     }
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print('Error $e');
  //     }
  //   }
  //   return customers;
  // }

  // Future<Customer> showCustomers(Customer customers) async {
  //   try {
  //     await getCustomers();
  //     if (kDebugMode) {
  //       print(customers.email);
  //     }
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print('Error $e');
  //     }
  //   }
  //   return customers;
  // }
  bool hasMoreData = true;
  bool isbuttonDisabled = true;
  List<Customer> customerLists = [
    firstCustomer,
    secondCustomer,
    thirdCustomer,
    fourthCustomer,
    fifthCustomer
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Demo"),
        backgroundColor: Colors.blue[200],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.all(8.0),
                  child: TextButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.amber)),
                    onPressed: () {
                      addCustomers();
                    },
                    child: const Text("Insert"),
                  )),
              Container(
                margin: const EdgeInsets.all(8.0),
                child: TextButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.green)),
                  onPressed: () async {
                    // for (var element in customerList) {
                    //   // showCustomers(element);
                    //   showCustomers(element).then((value) => setState(() {
                    //         // customerList = [value];
                    //         // customerList.add(value);
                    //       }));
                    if (isbuttonDisabled == true) {
                      for (var element in customerLists) {
                        await getCustomers(element.id);
                        customerList.add(element);
                      }
                      setState(() {
                        isbuttonDisabled = false;
                      });
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              actions: <Widget>[
                                CloseButton(
                                  color: Colors.black,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                // FloatingActionButton(onPressed: () {
                                //   Navigator.of(context).pop();
                                // },
                                // child: const Icon(Icons.close),
                                // )
                              ],
                              title: const Text('Alert Message!'),
                              content: const Text(
                                  'No More Data found in Your Database'),
                            );
                          });
                    }

                    // for (var element in customerLists) {
                    //   await getCustomers(element.id);
                    //   setState(() {
                    //     // for (var element in customerLists) {
                    //     // if (customerLists.isNotEmpty) {
                    //     customerList.add(element);

                    //     // }
                    //     // // }
                    //     // if (kDebugMode) {
                    //     //   print(customerList.length);
                    //     // }
                    //   });
                    // }

                    //   List<Map> customerList = await getCustomers();
                    //   if (customerList.isEmpty) {
                    //       setState(() {
                    //       });
                    //       customerList.add();
                    //   } else {
                    //     setState(() {
                    //       // _hasMoreData = false;
                    //     });
                    //   }
                  },
                  child: const Text(
                    "Show",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                width: 500,
                height: 500,
                child: ListView.builder(
                    itemCount: customerList.length + 1,
                    itemBuilder: ((context, index) {
                      if (index == customerList.length) {
                        if (kDebugMode) {
                          print(index);
                        }

                        hasMoreData = false;
                        return hasMoreData
                            ? Container()
                            : Center(
                                child: Text('All User: ${customerList.length}',
                                    style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)));
                      } else {
                        // return ListTile(
                        //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        //   tileColor: Colors.cyan,
                        //   title: Text(
                        //       '${customerList[index].firstName} ${customerList[index].lastName}'),
                        //   textColor: Colors.white,
                        //   subtitle: Text(customerList[index].email),
                        // );
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.all(2.0),
                          color: Colors.blue[200],
                     
                          child: Column(
                            
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            
                            children: [
                              
                              Text('${customerLists[index].firstName} ${customerLists[index].lastName}', textAlign: TextAlign.center, style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: AutofillHints.addressCity),),
                              Text(customerLists[index].email, textAlign: TextAlign.start, style: const TextStyle(
                                      color: Colors.amber,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: AutofillHints.addressCity)),
                              const Padding(padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8)),
                            ],
                            
                          ),
                        );
                      }
                    })),
              ),
              const SizedBox(
                height: 50,
              )
              //   SizedBox(
              //     width: 500,
              //     height: 500,
              //     child: ListView.builder(
              //         itemCount: customerList.length + 1,
              //         itemBuilder: (context, index) {
              //           if (index == customerList.length) {
              //             return _hasMoreData
              //                 ? Center(child: Text('${customerList.length}'))
              //                 : Center(child: Text('${customerList.first}'));
              //           } else {
              //             return ListTile(
              //               title: Text(
              //                   '${customerList[index].firstName} ${customerList[index].lastName}'),
              //               subtitle: Text('${customerList[index].email}'),
              //             );
              //           }
              //         }),
              //   )
            ],
          ),
        ),
      ),
    );
  }
}
