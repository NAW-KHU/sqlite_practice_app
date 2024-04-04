
class Customer {
  int id;
  String firstName;
  String lastName;
  String email;

  Customer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  // @override
  // String toString(){
  //   return 'Customer{id: $id, firstName: $firstName, lastName: $lastName, email: $email}';
  // }

  // int get id => id;
  // String get firstName => firstName;
  // String get lastName => lastName;
  // String get email => email;

  factory Customer.fromMap(Map<String, dynamic> data) => Customer(
        id: data["id"],
        firstName: data["first_name"],
        lastName: data["last_name"],
        email: data["email"],
      );

  Map<String, Object> toMap() {
    return {
      "id": id,
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
    };
  }

  
}
