class User{
  String? username;
  String? password;
  String? name;
  String? lastname;
  String? datebirth;

  User({
    this.username,
    this.password,
    this.name,
    this.lastname,
    this.datebirth
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"] == null ? null : json["username"],
        password: json["password"] == null ? null : json["password"],
        name: json["name"] == null ? null : json["name"],
        lastname: json["lastname"] == null ? null : json["lastname"],
        datebirth: json["date_birth"] == null ? null : json["date_birth"]
    );

    Map<String, dynamic> toJson() => {
        "username": username == null ? null : username,
        "password": password == null ? null : password,
        "name": name == null ? null : name,
        "lastname": name == null ? null : lastname,
        "date_birth": name == null ? null : datebirth
    };
}