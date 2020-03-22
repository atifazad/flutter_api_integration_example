class User {
  final int id;
  final String username;
  final String email;
  final String authToken;

  User({this.id, this.username, this.email, this.authToken});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      authToken: json['token'],
    );
  }
}