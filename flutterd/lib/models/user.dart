class User {
  int? id;
  String? username;
  String? password;
  String? firstName;
  String? lastName;
  String? email;

  User(
      {this.id,
      this.username,
      this.password,
      this.firstName,
      this.lastName,
      this.email});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['password'] = this.password;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    return data;
  }
}
