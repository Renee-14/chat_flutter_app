
class user {
  late final int id;
  late final String username;
  late final String password;


 user(
      this.id,
      this.username,
      this.password,

      );
  factory user.fromMap(Map<String, dynamic> json) {
    return user(json['id'], json['username'], json['password'], );
  }
  factory user.fromJson(Map<String, dynamic> json) {
    return user(json['id'], json['username'], json['password'],);
  }
}