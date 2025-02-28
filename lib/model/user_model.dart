class UserModel {
  final String id;
  final String username;
  final String password;
  final DateTime createdAt;
  final String email;
  final String profilePictureUrl;
  final bool accountStatus;

  UserModel({
    required this.id,
    required this.username,
    required this.password,
    required this.createdAt,
    required this.email,
    required this.profilePictureUrl,
    required this.accountStatus,
  });

  factory UserModel.fromFirestore(Map<String, dynamic> data) {
    return UserModel(
      id: data['id'],
      username: data['username'] ?? '',
      password: data['password'] ?? '',
      createdAt: data['createdAt'].toDate(),
      email: data['email'] ?? '',
      profilePictureUrl: data['profilePictureUrl'],
      accountStatus: data['accountStatus'],
    );
  }

}