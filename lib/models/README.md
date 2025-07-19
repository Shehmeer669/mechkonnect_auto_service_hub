# MechKonnect Data Models

This directory contains the core data models for the MechKonnect Auto Service Hub application.

## Models Overview

### 1. User (`user.dart`)
Represents system users (customers and service providers).
- **Fields**: id, name, email, phoneNumber, profileImageUrl, timestamps, isActive
- **Usage**: Authentication, profile management, user identification

### 2. Mechanic (`mechanic.dart`)
Represents service providers with business information.
- **Fields**: business details, specializations, location, ratings, availability, rates
- **Usage**: Service provider profiles, location-based searches, booking management

### 3. Vehicle (`vehicle.dart`)
Represents customer vehicles requiring services.
- **Fields**: make, model, year, specifications, service history, owner reference
- **Usage**: Service history tracking, compatibility matching, booking context

### 4. Booking (`booking.dart`)
Represents service appointments and their lifecycle.
- **Enums**: BookingStatus (pending, confirmed, inProgress, completed, cancelled, rescheduled)
- **Enums**: BookingType (repair, maintenance, inspection, diagnosis, consultation)
- **Fields**: customer/mechanic/vehicle references, scheduling, costs, notes
- **Usage**: Appointment management, service tracking, billing

### 5. MarketplaceItem (`marketplace_item.dart`)
Represents parts and services available for sale.
- **Enums**: MarketplaceItemType (part, tool, service, accessory)
- **Enums**: MarketplaceItemCondition (newItem, used, refurbished, damaged)
- **Fields**: product details, pricing, compatibility, availability
- **Usage**: Parts marketplace, service listings, e-commerce functionality

### 6. ChatMessage (`chat_message.dart`)
Represents communication between users.
- **Enums**: MessageType (text, image, file, location, booking)
- **Enums**: MessageStatus (sent, delivered, read, failed)
- **Fields**: content, attachments, metadata, status tracking
- **Usage**: Customer service communication, booking discussions

## Usage Examples

```dart
import 'package:mechkonnect/models/models.dart';

// Create a new user
final user = User(
  id: 'user_123',
  name: 'John Doe',
  email: 'john@example.com',
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

// Serialize to JSON
final userJson = user.toMap();

// Deserialize from JSON
final userFromJson = User.fromMap(userJson);

// Create a booking
final booking = Booking(
  id: 'booking_456',
  customerId: user.id,
  mechanicId: 'mechanic_789',
  vehicleId: 'vehicle_101',
  type: BookingType.repair,
  serviceDescription: 'Oil change and brake inspection',
  scheduledDateTime: DateTime.now().add(Duration(days: 1)),
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);
```

## Features

All models include:
- **Immutable design** with final fields
- **JSON serialization/deserialization** via `toMap()` and `fromMap()`
- **Copy functionality** via `copyWith()` method
- **Proper equality and hashing** via `==` operator and `hashCode`
- **String representation** via `toString()` method
- **Type safety** with nullable fields properly marked
- **Enum support** for constrained values

## Database Integration

These models are designed to work with:
- **NoSQL databases** (Firestore, MongoDB) via Map serialization
- **SQL databases** via ORM mapping
- **REST APIs** via JSON serialization
- **Local storage** (SQLite, SharedPreferences) via Map/JSON conversion

## Extension Points

Models can be easily extended with:
- Additional fields using `copyWith()` pattern
- Validation methods
- Business logic methods
- Relationship helpers
- Custom serialization for specific backends