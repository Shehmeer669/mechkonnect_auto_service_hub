import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

enum UserRole {
  @JsonValue('user')
  user,
  @JsonValue('mechanic')
  mechanic,
  @JsonValue('admin')
  admin,
}

@JsonSerializable()
class UserModel {
  final String id;
  final String email;
  final String? phone;
  final String? firstName;
  final String? lastName;
  final String? profileImage;
  final UserRole role;
  final bool isActive;
  final bool isVerified;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  // User-specific fields
  final String? address;
  final double? latitude;
  final double? longitude;
  
  // Mechanic-specific fields
  final String? businessName;
  final String? description;
  final List<String>? skills;
  final double? hourlyRate;
  final double? rating;
  final int? totalJobs;
  final bool? isAvailable;
  final double? serviceRadius;

  const UserModel({
    required this.id,
    required this.email,
    this.phone,
    this.firstName,
    this.lastName,
    this.profileImage,
    required this.role,
    required this.isActive,
    required this.isVerified,
    required this.createdAt,
    required this.updatedAt,
    this.address,
    this.latitude,
    this.longitude,
    this.businessName,
    this.description,
    this.skills,
    this.hourlyRate,
    this.rating,
    this.totalJobs,
    this.isAvailable,
    this.serviceRadius,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  String get fullName => '${firstName ?? ''} ${lastName ?? '}'.trim();
  
  bool get isMechanic => role == UserRole.mechanic;
  bool get isUser => role == UserRole.user;
  bool get isAdmin => role == UserRole.admin;

  UserModel copyWith({
    String? email,
    String? phone,
    String? firstName,
    String? lastName,
    String? profileImage,
    UserRole? role,
    bool? isActive,
    bool? isVerified,
    DateTime? updatedAt,
    String? address,
    double? latitude,
    double? longitude,
    String? businessName,
    String? description,
    List<String>? skills,
    double? hourlyRate,
    double? rating,
    int? totalJobs,
    bool? isAvailable,
    double? serviceRadius,
  }) {
    return UserModel(
      id: id,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      profileImage: profileImage ?? this.profileImage,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      isVerified: isVerified ?? this.isVerified,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      businessName: businessName ?? this.businessName,
      description: description ?? this.description,
      skills: skills ?? this.skills,
      hourlyRate: hourlyRate ?? this.hourlyRate,
      rating: rating ?? this.rating,
      totalJobs: totalJobs ?? this.totalJobs,
      isAvailable: isAvailable ?? this.isAvailable,
      serviceRadius: serviceRadius ?? this.serviceRadius,
    );
  }
}