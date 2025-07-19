import 'package:json_annotation/json_annotation.dart';

part 'part_model.g.dart';

enum PartCategory {
  @JsonValue('engine')
  engine,
  @JsonValue('transmission')
  transmission,
  @JsonValue('brakes')
  brakes,
  @JsonValue('suspension')
  suspension,
  @JsonValue('electrical')
  electrical,
  @JsonValue('exhaust')
  exhaust,
  @JsonValue('cooling')
  cooling,
  @JsonValue('fuel_system')
  fuelSystem,
  @JsonValue('interior')
  interior,
  @JsonValue('exterior')
  exterior,
  @JsonValue('wheels_tires')
  wheelsTires,
  @JsonValue('filters')
  filters,
  @JsonValue('fluids')
  fluids,
  @JsonValue('other')
  other,
}

enum PartCondition {
  @JsonValue('new')
  newPart,
  @JsonValue('used')
  used,
  @JsonValue('refurbished')
  refurbished,
}

@JsonSerializable()
class PartModel {
  final String id;
  final String name;
  final String description;
  final PartCategory category;
  final String brand;
  final String partNumber;
  final double price;
  final int stockQuantity;
  final PartCondition condition;
  final List<String> images;
  final List<String> compatibleMakes;
  final List<String> compatibleModels;
  final List<int> compatibleYears;
  final double? weight;
  final String? dimensions;
  final String? warranty;
  final int? warrantyMonths;
  final bool isActive;
  final String? sellerId;
  final double? rating;
  final int? reviewCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  const PartModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.brand,
    required this.partNumber,
    required this.price,
    required this.stockQuantity,
    required this.condition,
    required this.images,
    required this.compatibleMakes,
    required this.compatibleModels,
    required this.compatibleYears,
    this.weight,
    this.dimensions,
    this.warranty,
    this.warrantyMonths,
    required this.isActive,
    this.sellerId,
    this.rating,
    this.reviewCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PartModel.fromJson(Map<String, dynamic> json) => _$PartModelFromJson(json);
  Map<String, dynamic> toJson() => _$PartModelToJson(this);

  String get categoryDisplayName {
    switch (category) {
      case PartCategory.engine:
        return 'Engine';
      case PartCategory.transmission:
        return 'Transmission';
      case PartCategory.brakes:
        return 'Brakes';
      case PartCategory.suspension:
        return 'Suspension';
      case PartCategory.electrical:
        return 'Electrical';
      case PartCategory.exhaust:
        return 'Exhaust';
      case PartCategory.cooling:
        return 'Cooling';
      case PartCategory.fuelSystem:
        return 'Fuel System';
      case PartCategory.interior:
        return 'Interior';
      case PartCategory.exterior:
        return 'Exterior';
      case PartCategory.wheelsTires:
        return 'Wheels & Tires';
      case PartCategory.filters:
        return 'Filters';
      case PartCategory.fluids:
        return 'Fluids';
      case PartCategory.other:
        return 'Other';
    }
  }

  String get conditionDisplayName {
    switch (condition) {
      case PartCondition.newPart:
        return 'New';
      case PartCondition.used:
        return 'Used';
      case PartCondition.refurbished:
        return 'Refurbished';
    }
  }

  bool get isInStock => stockQuantity > 0;
  bool get isLowStock => stockQuantity <= 5 && stockQuantity > 0;
  bool get isOutOfStock => stockQuantity == 0;

  String get mainImage => images.isNotEmpty ? images.first : '';

  bool isCompatibleWith(String make, String model, int year) {
    return compatibleMakes.contains(make) &&
           compatibleModels.contains(model) &&
           compatibleYears.contains(year);
  }

  PartModel copyWith({
    String? name,
    String? description,
    PartCategory? category,
    String? brand,
    String? partNumber,
    double? price,
    int? stockQuantity,
    PartCondition? condition,
    List<String>? images,
    List<String>? compatibleMakes,
    List<String>? compatibleModels,
    List<int>? compatibleYears,
    double? weight,
    String? dimensions,
    String? warranty,
    int? warrantyMonths,
    bool? isActive,
    String? sellerId,
    double? rating,
    int? reviewCount,
    DateTime? updatedAt,
  }) {
    return PartModel(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      brand: brand ?? this.brand,
      partNumber: partNumber ?? this.partNumber,
      price: price ?? this.price,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      condition: condition ?? this.condition,
      images: images ?? this.images,
      compatibleMakes: compatibleMakes ?? this.compatibleMakes,
      compatibleModels: compatibleModels ?? this.compatibleModels,
      compatibleYears: compatibleYears ?? this.compatibleYears,
      weight: weight ?? this.weight,
      dimensions: dimensions ?? this.dimensions,
      warranty: warranty ?? this.warranty,
      warrantyMonths: warrantyMonths ?? this.warrantyMonths,
      isActive: isActive ?? this.isActive,
      sellerId: sellerId ?? this.sellerId,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}