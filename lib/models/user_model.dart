import 'dart:convert';




class User {
  final int id;
  final String name;
  final String avatar;

  User({
    required this.id,
    required this.avatar,
    required this.name,
  });
}

final List<User> CurrentUser =[
  User(id: 0, name: 'Tay', avatar: 'image/pic1.png'),
  User(id: 1, name: 'Addision', avatar: 'image/pic1.png'),
  User(id: 2, name: 'Jason', avatar: 'image/pic2.png'),


  User(id: 3, name: 'Joy', avatar: 'image/pic3.png'),];

