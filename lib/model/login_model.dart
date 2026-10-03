class LoginRequest {
  String? username;
  String? password;
  int? expiresInMins;

  LoginRequest({this.username, this.password, this.expiresInMins});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    expiresInMins = json['expiresInMins'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    data['expiresInMins'] = this.expiresInMins;
    return data;
  }
}
class LoginResponse {
  String? accessToken;
  String? refreshToken;
  int? id;
  String? username;
  String? email;
  String? firstName;
  String? lastName;
  String? gender;
  String? image;

  LoginResponse(
      {this.accessToken,
        this.refreshToken,
        this.id,
        this.username,
        this.email,
        this.firstName,
        this.lastName,
        this.gender,
        this.image});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    id = json['id'];
    username = json['username'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    gender = json['gender'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['refreshToken'] = this.refreshToken;
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['gender'] = this.gender;
    data['image'] = this.image;
    return data;
  }
}