class User {
  String? username;
  String? phone;

  User({this.username, this.phone});

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['phone'] = phone;
    return data;
  }
}