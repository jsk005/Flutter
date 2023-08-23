class User {
  int? id;
  String name;
  int age;
  String email;

  User({this.id, required this.name, required this.age, required this.email});

  User.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"],
        age = res["age"],
        email = res["email"];

  Map<String, Object?> toMap() {
    return {'id': id, 'name': name, 'age': age, 'email': email};
  }
}