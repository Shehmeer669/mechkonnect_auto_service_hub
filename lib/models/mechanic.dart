class Mechanic {
  final String id;
  final String userId; // Reference to User
  final String businessName;
  final String description;
  final List<String> specializations;
  final String address;
  final double latitude;
  final double longitude;
  final String? businessLicenseNumber;
  final List<String> certifications;
  final double rating;
  final int totalReviews;
  final bool isVerified;
  final bool isAvailable;
  final double hourlyRate;
  final String? businessImageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  Mechanic({
    required this.id,
    required this.userId,
    required this.businessName,
    required this.description,
    required this.specializations,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.businessLicenseNumber,
    this.certifications = const [],
    this.rating = 0.0,
    this.totalReviews = 0,
    this.isVerified = false,
    this.isAvailable = true,
    this.hourlyRate = 0.0,
    this.businessImageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Mechanic.fromMap(Map<String, dynamic> map) {
    return Mechanic(
      id: map['id'] as String,
      userId: map['userId'] as String,
      businessName: map['businessName'] as String,
      description: map['description'] as String,
      specializations: List<String>.from(map['specializations'] as List),
      address: map['address'] as String,
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
      businessLicenseNumber: map['businessLicenseNumber'] as String?,
      certifications: List<String>.from(map['certifications'] as List? ?? []),
      rating: (map['rating'] as num?)?.toDouble() ?? 0.0,
      totalReviews: map['totalReviews'] as int? ?? 0,
      isVerified: map['isVerified'] as bool? ?? false,
      isAvailable: map['isAvailable'] as bool? ?? true,
      hourlyRate: (map['hourlyRate'] as num?)?.toDouble() ?? 0.0,
      businessImageUrl: map['businessImageUrl'] as String?,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'businessName': businessName,
      'description': description,
      'specializations': specializations,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'businessLicenseNumber': businessLicenseNumber,
      'certifications': certifications,
      'rating': rating,
      'totalReviews': totalReviews,
      'isVerified': isVerified,
      'isAvailable': isAvailable,
      'hourlyRate': hourlyRate,
      'businessImageUrl': businessImageUrl,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  Mechanic copyWith({
    String? id,
    String? userId,
    String? businessName,
    String? description,
    List<String>? specializations,
    String? address,
    double? latitude,
    double? longitude,
    String? businessLicenseNumber,
    List<String>? certifications,
    double? rating,
    int? totalReviews,
    bool? isVerified,
    bool? isAvailable,
    double? hourlyRate,
    String? businessImageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Mechanic(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      businessName: businessName ?? this.businessName,
      description: description ?? this.description,
      specializations: specializations ?? this.specializations,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      businessLicenseNumber: businessLicenseNumber ?? this.businessLicenseNumber,
      certifications: certifications ?? this.certifications,
      rating: rating ?? this.rating,
      totalReviews: totalReviews ?? this.totalReviews,
      isVerified: isVerified ?? this.isVerified,
      isAvailable: isAvailable ?? this.isAvailable,
      hourlyRate: hourlyRate ?? this.hourlyRate,
      businessImageUrl: businessImageUrl ?? this.businessImageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'Mechanic(id: $id, userId: $userId, businessName: $businessName, description: $description, specializations: $specializations, address: $address, latitude: $latitude, longitude: $longitude, businessLicenseNumber: $businessLicenseNumber, certifications: $certifications, rating: $rating, totalReviews: $totalReviews, isVerified: $isVerified, isAvailable: $isAvailable, hourlyRate: $hourlyRate, businessImageUrl: $businessImageUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Mechanic && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}