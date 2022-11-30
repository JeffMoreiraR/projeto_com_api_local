class User {
  String userName;
  int userCpf;
  int userNumber;
  String email;
  String password;

  User({
    required this.userName,
    required this.userCpf,
    required this.userNumber,
    required this.email,
    required this.password,
  });

  fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    userCpf = json['userCpf'];
    userNumber = json['userNumber'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['userName'] = userName;
    data['userCpf'] = userCpf;
    data['userNumber'] = userNumber;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
