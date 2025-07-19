enum BookingStatus {
  pending,
  confirmed,
  inProgress,
  completed,
  cancelled,
  rescheduled,
}

enum BookingType {
  repair,
  maintenance,
  inspection,
  diagnosis,
  consultation,
}

class Booking {
  final String id;
  final String customerId; // Reference to User
  final String mechanicId; // Reference to Mechanic
  final String vehicleId; // Reference to Vehicle
  final BookingType type;
  final String serviceDescription;
  final DateTime scheduledDateTime;
  final DateTime? estimatedCompletionTime;
  final DateTime? actualCompletionTime;
  final BookingStatus status;
  final double? estimatedCost;
  final double? finalCost;
  final String? customerNotes;
  final String? mechanicNotes;
  final List<String> serviceItems;
  final String? receiptUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  Booking({
    required this.id,
    required this.customerId,
    required this.mechanicId,
    required this.vehicleId,
    required this.type,
    required this.serviceDescription,
    required this.scheduledDateTime,
    this.estimatedCompletionTime,
    this.actualCompletionTime,
    this.status = BookingStatus.pending,
    this.estimatedCost,
    this.finalCost,
    this.customerNotes,
    this.mechanicNotes,
    this.serviceItems = const [],
    this.receiptUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['id'] as String,
      customerId: map['customerId'] as String,
      mechanicId: map['mechanicId'] as String,
      vehicleId: map['vehicleId'] as String,
      type: BookingType.values.firstWhere(
        (e) => e.toString().split('.').last == map['type'],
        orElse: () => BookingType.repair,
      ),
      serviceDescription: map['serviceDescription'] as String,
      scheduledDateTime: DateTime.parse(map['scheduledDateTime'] as String),
      estimatedCompletionTime: map['estimatedCompletionTime'] != null
          ? DateTime.parse(map['estimatedCompletionTime'] as String)
          : null,
      actualCompletionTime: map['actualCompletionTime'] != null
          ? DateTime.parse(map['actualCompletionTime'] as String)
          : null,
      status: BookingStatus.values.firstWhere(
        (e) => e.toString().split('.').last == map['status'],
        orElse: () => BookingStatus.pending,
      ),
      estimatedCost: (map['estimatedCost'] as num?)?.toDouble(),
      finalCost: (map['finalCost'] as num?)?.toDouble(),
      customerNotes: map['customerNotes'] as String?,
      mechanicNotes: map['mechanicNotes'] as String?,
      serviceItems: List<String>.from(map['serviceItems'] as List? ?? []),
      receiptUrl: map['receiptUrl'] as String?,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'mechanicId': mechanicId,
      'vehicleId': vehicleId,
      'type': type.toString().split('.').last,
      'serviceDescription': serviceDescription,
      'scheduledDateTime': scheduledDateTime.toIso8601String(),
      'estimatedCompletionTime': estimatedCompletionTime?.toIso8601String(),
      'actualCompletionTime': actualCompletionTime?.toIso8601String(),
      'status': status.toString().split('.').last,
      'estimatedCost': estimatedCost,
      'finalCost': finalCost,
      'customerNotes': customerNotes,
      'mechanicNotes': mechanicNotes,
      'serviceItems': serviceItems,
      'receiptUrl': receiptUrl,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  Booking copyWith({
    String? id,
    String? customerId,
    String? mechanicId,
    String? vehicleId,
    BookingType? type,
    String? serviceDescription,
    DateTime? scheduledDateTime,
    DateTime? estimatedCompletionTime,
    DateTime? actualCompletionTime,
    BookingStatus? status,
    double? estimatedCost,
    double? finalCost,
    String? customerNotes,
    String? mechanicNotes,
    List<String>? serviceItems,
    String? receiptUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Booking(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      mechanicId: mechanicId ?? this.mechanicId,
      vehicleId: vehicleId ?? this.vehicleId,
      type: type ?? this.type,
      serviceDescription: serviceDescription ?? this.serviceDescription,
      scheduledDateTime: scheduledDateTime ?? this.scheduledDateTime,
      estimatedCompletionTime: estimatedCompletionTime ?? this.estimatedCompletionTime,
      actualCompletionTime: actualCompletionTime ?? this.actualCompletionTime,
      status: status ?? this.status,
      estimatedCost: estimatedCost ?? this.estimatedCost,
      finalCost: finalCost ?? this.finalCost,
      customerNotes: customerNotes ?? this.customerNotes,
      mechanicNotes: mechanicNotes ?? this.mechanicNotes,
      serviceItems: serviceItems ?? this.serviceItems,
      receiptUrl: receiptUrl ?? this.receiptUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'Booking(id: $id, customerId: $customerId, mechanicId: $mechanicId, vehicleId: $vehicleId, type: $type, serviceDescription: $serviceDescription, scheduledDateTime: $scheduledDateTime, estimatedCompletionTime: $estimatedCompletionTime, actualCompletionTime: $actualCompletionTime, status: $status, estimatedCost: $estimatedCost, finalCost: $finalCost, customerNotes: $customerNotes, mechanicNotes: $mechanicNotes, serviceItems: $serviceItems, receiptUrl: $receiptUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Booking && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}