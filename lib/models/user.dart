class User {
  final String id;
  final String name;
  final String email;
  final String? phoneNumber;
  final String? profileImageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.profileImageUrl,
    required this.createdAt,
    required this.updatedAt,
    this.isActive = true,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String?,
      profileImageUrl: map['profileImageUrl'] as String?,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
      isActive: map['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'profileImageUrl': profileImageUrl,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isActive': isActive,
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? profileImageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, phoneNumber: $phoneNumber, profileImageUrl: $profileImageUrl, createdAt: $createdAt, updatedAt: $updatedAt, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}