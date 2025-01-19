import 'user.dart';

class UserData {
  User? user;
  String? token;

  UserData({this.user, this.token});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['token'] = token;
    return data;
  }
}
