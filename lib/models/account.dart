import 'dart:convert';

class Account {
  final int id;
  final String name;
  final String username;
  final String? avatarPath;

  Account({
    required this.id,
    required this.name,
    required this.username,
    this.avatarPath,
  });

  factory Account.fromJson(String str) => Account.fromMap(json.decode(str));

  factory Account.fromMap(Map<String, dynamic> json) => Account(
    id: json["id"],
    name: json["name"] ?? "",
    username: json["username"],
    avatarPath: json["avatar"]?["tmdb"]?["avatar_path"],
  );
}
