import 'package:json_annotation/json_annotation.dart';

part 'booking_model.g.dart';

enum BookingStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('accepted')
  accepted,
  @JsonValue('rejected')
  rejected,
  @JsonValue('in_progress')
  inProgress,
  @JsonValue('completed')
  completed,
  @JsonValue('cancelled')
  cancelled,
}

enum ServiceType {
  @JsonValue('oil_change')
  oilChange,
  @JsonValue('brake_service')
  brakeService,
  @JsonValue('tire_service')
  tireService,
  @JsonValue('engine_repair')
  engineRepair,
  @JsonValue('transmission_service')
  transmissionService,
  @JsonValue('electrical_service')
  electricalService,
  @JsonValue('ac_service')
  acService,
  @JsonValue('general_maintenance')
  generalMaintenance,
  @JsonValue('diagnostic')
  diagnostic,
  @JsonValue('other')
  other,
}

@JsonSerializable()
class BookingModel {
  final String id;
  final String userId;
  final String mechanicId;
  final String vehicleId;
  final ServiceType serviceType;
  final String? description;
  final double? estimatedCost;
  final double? finalCost;
  final DateTime scheduledAt;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final BookingStatus status;
  final double? userLatitude;
  final double? userLongitude;
  final String? userAddress;
  final String? mechanicNotes;
  final int? rating;
  final String? review;
  final List<String>? images;
  final DateTime createdAt;
  final DateTime updatedAt;

  const BookingModel({
    required this.id,
    required this.userId,
    required this.mechanicId,
    required this.vehicleId,
    required this.serviceType,
    this.description,
    this.estimatedCost,
    this.finalCost,
    required this.scheduledAt,
    this.startedAt,
    this.completedAt,
    required this.status,
    this.userLatitude,
    this.userLongitude,
    this.userAddress,
    this.mechanicNotes,
    this.rating,
    this.review,
    this.images,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) => _$BookingModelFromJson(json);
  Map<String, dynamic> toJson() => _$BookingModelToJson(this);

  String get statusDisplayName {
    switch (status) {
      case BookingStatus.pending:
        return 'Pending';
      case BookingStatus.accepted:
        return 'Accepted';
      case BookingStatus.rejected:
        return 'Rejected';
      case BookingStatus.inProgress:
        return 'In Progress';
      case BookingStatus.completed:
        return 'Completed';
      case BookingStatus.cancelled:
        return 'Cancelled';
    }
  }

  String get serviceTypeDisplayName {
    switch (serviceType) {
      case ServiceType.oilChange:
        return 'Oil Change';
      case ServiceType.brakeService:
        return 'Brake Service';
      case ServiceType.tireService:
        return 'Tire Service';
      case ServiceType.engineRepair:
        return 'Engine Repair';
      case ServiceType.transmissionService:
        return 'Transmission Service';
      case ServiceType.electricalService:
        return 'Electrical Service';
      case ServiceType.acService:
        return 'AC Service';
      case ServiceType.generalMaintenance:
        return 'General Maintenance';
      case ServiceType.diagnostic:
        return 'Diagnostic';
      case ServiceType.other:
        return 'Other';
    }
  }

  bool get isActive => status == BookingStatus.pending || 
                       status == BookingStatus.accepted || 
                       status == BookingStatus.inProgress;

  bool get isCompleted => status == BookingStatus.completed;
  bool get isCancelled => status == BookingStatus.cancelled;

  BookingModel copyWith({
    ServiceType? serviceType,
    String? description,
    double? estimatedCost,
    double? finalCost,
    DateTime? scheduledAt,
    DateTime? startedAt,
    DateTime? completedAt,
    BookingStatus? status,
    double? userLatitude,
    double? userLongitude,
    String? userAddress,
    String? mechanicNotes,
    int? rating,
    String? review,
    List<String>? images,
    DateTime? updatedAt,
  }) {
    return BookingModel(
      id: id,
      userId: userId,
      mechanicId: mechanicId,
      vehicleId: vehicleId,
      serviceType: serviceType ?? this.serviceType,
      description: description ?? this.description,
      estimatedCost: estimatedCost ?? this.estimatedCost,
      finalCost: finalCost ?? this.finalCost,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      status: status ?? this.status,
      userLatitude: userLatitude ?? this.userLatitude,
      userLongitude: userLongitude ?? this.userLongitude,
      userAddress: userAddress ?? this.userAddress,
      mechanicNotes: mechanicNotes ?? this.mechanicNotes,
      rating: rating ?? this.rating,
      review: review ?? this.review,
      images: images ?? this.images,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}