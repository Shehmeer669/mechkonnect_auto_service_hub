class Vehicle {
  final String id;
  final String ownerId; // Reference to User
  final String make;
  final String model;
  final int year;
  final String? color;
  final String? licensePlateNumber;
  final String? vinNumber;
  final String fuelType;
  final String transmission;
  final int? mileage;
  final String? engineSize;
  final List<String> serviceHistory;
  final String? imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;

  Vehicle({
    required this.id,
    required this.ownerId,
    required this.make,
    required this.model,
    required this.year,
    this.color,
    this.licensePlateNumber,
    this.vinNumber,
    this.fuelType = 'Gasoline',
    this.transmission = 'Automatic',
    this.mileage,
    this.engineSize,
    this.serviceHistory = const [],
    this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    this.isActive = true,
  });

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      id: map['id'] as String,
      ownerId: map['ownerId'] as String,
      make: map['make'] as String,
      model: map['model'] as String,
      year: map['year'] as int,
      color: map['color'] as String?,
      licensePlateNumber: map['licensePlateNumber'] as String?,
      vinNumber: map['vinNumber'] as String?,
      fuelType: map['fuelType'] as String? ?? 'Gasoline',
      transmission: map['transmission'] as String? ?? 'Automatic',
      mileage: map['mileage'] as int?,
      engineSize: map['engineSize'] as String?,
      serviceHistory: List<String>.from(map['serviceHistory'] as List? ?? []),
      imageUrl: map['imageUrl'] as String?,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
      isActive: map['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ownerId': ownerId,
      'make': make,
      'model': model,
      'year': year,
      'color': color,
      'licensePlateNumber': licensePlateNumber,
      'vinNumber': vinNumber,
      'fuelType': fuelType,
      'transmission': transmission,
      'mileage': mileage,
      'engineSize': engineSize,
      'serviceHistory': serviceHistory,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isActive': isActive,
    };
  }

  Vehicle copyWith({
    String? id,
    String? ownerId,
    String? make,
    String? model,
    int? year,
    String? color,
    String? licensePlateNumber,
    String? vinNumber,
    String? fuelType,
    String? transmission,
    int? mileage,
    String? engineSize,
    List<String>? serviceHistory,
    String? imageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
  }) {
    return Vehicle(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      make: make ?? this.make,
      model: model ?? this.model,
      year: year ?? this.year,
      color: color ?? this.color,
      licensePlateNumber: licensePlateNumber ?? this.licensePlateNumber,
      vinNumber: vinNumber ?? this.vinNumber,
      fuelType: fuelType ?? this.fuelType,
      transmission: transmission ?? this.transmission,
      mileage: mileage ?? this.mileage,
      engineSize: engineSize ?? this.engineSize,
      serviceHistory: serviceHistory ?? this.serviceHistory,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  String toString() {
    return 'Vehicle(id: $id, ownerId: $ownerId, make: $make, model: $model, year: $year, color: $color, licensePlateNumber: $licensePlateNumber, vinNumber: $vinNumber, fuelType: $fuelType, transmission: $transmission, mileage: $mileage, engineSize: $engineSize, serviceHistory: $serviceHistory, imageUrl: $imageUrl, createdAt: $createdAt, updatedAt: $updatedAt, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Vehicle && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}