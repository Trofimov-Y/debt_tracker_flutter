class UserModel {
  UserModel({
    this.name,
    this.email,
    required this.isAnonymous,
  });

  final String? name;
  final String? email;
  final bool isAnonymous;
}
