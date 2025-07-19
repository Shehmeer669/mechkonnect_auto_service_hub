import 'package:flutter/material.dart';

class BookMechanicScreen extends StatelessWidget {
  const BookMechanicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Mechanic')),
      body: const Center(
        child: Text('Book Mechanic Screen - Coming Soon'),
      ),
    );
  }
}

class MechanicDetailScreen extends StatelessWidget {
  final String mechanicId;
  const MechanicDetailScreen({super.key, required this.mechanicId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mechanic Details')),
      body: Center(
        child: Text('Mechanic Details for ID: $mechanicId'),
      ),
    );
  }
}

class BookingConfirmationScreen extends StatelessWidget {
  final String? mechanicId;
  final String? serviceType;
  const BookingConfirmationScreen({super.key, this.mechanicId, this.serviceType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Booking Confirmation')),
      body: const Center(
        child: Text('Booking Confirmation Screen - Coming Soon'),
      ),
    );
  }
}

class LiveTrackingScreen extends StatelessWidget {
  final String bookingId;
  const LiveTrackingScreen({super.key, required this.bookingId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Live Tracking')),
      body: Center(
        child: Text('Live Tracking for Booking: $bookingId'),
      ),
    );
  }
}

class MarketplaceHomeScreen extends StatelessWidget {
  const MarketplaceHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Marketplace')),
      body: const Center(
        child: Text('Marketplace Screen - Coming Soon'),
      ),
    );
  }
}

class PartDetailScreen extends StatelessWidget {
  final String partId;
  const PartDetailScreen({super.key, required this.partId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Part Details')),
      body: Center(
        child: Text('Part Details for ID: $partId'),
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: const Center(
        child: Text('Cart Screen - Coming Soon'),
      ),
    );
  }
}

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: const Center(
        child: Text('Payment Screen - Coming Soon'),
      ),
    );
  }
}

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: const Center(
        child: Text('User Profile Screen - Coming Soon'),
      ),
    );
  }
}

class VehicleManagementScreen extends StatelessWidget {
  const VehicleManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Vehicles')),
      body: const Center(
        child: Text('Vehicle Management Screen - Coming Soon'),
      ),
    );
  }
}

class VehicleDetailScreen extends StatelessWidget {
  final String vehicleId;
  const VehicleDetailScreen({super.key, required this.vehicleId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vehicle Details')),
      body: Center(
        child: Text('Vehicle Details for ID: $vehicleId'),
      ),
    );
  }
}

class ServiceHistoryScreen extends StatelessWidget {
  const ServiceHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Service History')),
      body: const Center(
        child: Text('Service History Screen - Coming Soon'),
      ),
    );
  }
}

class UserNotificationsScreen extends StatelessWidget {
  const UserNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: const Center(
        child: Text('Notifications Screen - Coming Soon'),
      ),
    );
  }
}