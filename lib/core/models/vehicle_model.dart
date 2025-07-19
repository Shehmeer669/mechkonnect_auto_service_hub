import 'package:json_annotation/json_annotation.dart';

part 'vehicle_model.g.dart';

@JsonSerializable()
class VehicleModel {
  final String id;
  final String userId;
  final String make;
  final String model;
  final int year;
  final String? color;
  final String? licensePlate;
  final String? vin;
  final String? engine;
  final String? transmission;
  final int? mileage;
  final String? image;
  final bool isDefault;
  final DateTime createdAt;
  final DateTime updatedAt;

  const VehicleModel({
    required this.id,
    required this.userId,
    required this.make,
    required this.model,
    required this.year,
    this.color,
    this.licensePlate,
    this.vin,
    this.engine,
    this.transmission,
    this.mileage,
    this.image,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) => _$VehicleModelFromJson(json);
  Map<String, dynamic> toJson() => _$VehicleModelToJson(this);

  String get displayName => '$year $make $model';
  
  VehicleModel copyWith({
    String? make,
    String? model,
    int? year,
    String? color,
    String? licensePlate,
    String? vin,
    String? engine,
    String? transmission,
    int? mileage,
    String? image,
    bool? isDefault,
    DateTime? updatedAt,
  }) {
    return VehicleModel(
      id: id,
      userId: userId,
      make: make ?? this.make,
      model: model ?? this.model,
      year: year ?? this.year,
      color: color ?? this.color,
      licensePlate: licensePlate ?? this.licensePlate,
      vin: vin ?? this.vin,
      engine: engine ?? this.engine,
      transmission: transmission ?? this.transmission,
      mileage: mileage ?? this.mileage,
      image: image ?? this.image,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}