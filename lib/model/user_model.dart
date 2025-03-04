
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

  factory UserModel.fromFirestore(Map<String, dynamic> data) => UserModel(    
    id: data['id'],
    username: data['username'] ?? '',
    password: data['password'] ?? '',
    createdAt: data['createdAt'] is String 
      ? DateTime.parse(data['createdAt']) 
      : data['createdAt'].toDate(),
    email: data['email'] ?? '',
    profilePictureUrl: data['profilePictureUrl'] ?? '',
    accountStatus: data['accountStatus'] ?? true,    
  );
  Map<String, dynamic> toFirestore() => {
    'id': id,
    'username': username,
    'password': password,
    'createdAt': createdAt.toIso8601String(),
    'email': email,
    'profilePictureUrl': profilePictureUrl,
    'accountStatus': accountStatus,
  };

  UserModel copyWith({
  String? id,
  String? username,
  String? password,
  DateTime? createdAt,
  String? email,
  String? profilePictureUrl,
  bool? accountStatus,
}) {
  return UserModel(
    id: id ?? this.id,
    username: username ?? this.username,
    password: password ?? this.password,
    createdAt: createdAt ?? this.createdAt,
    email: email ?? this.email,
    profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
    accountStatus: accountStatus ?? this.accountStatus,
  );
}
}

