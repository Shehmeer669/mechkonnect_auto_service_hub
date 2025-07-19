import 'package:flutter/material.dart';

class MechanicDashboardScreen extends StatelessWidget {
  const MechanicDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mechanic Dashboard')),
      body: const Center(
        child: Text('Mechanic Dashboard Screen - Coming Soon'),
      ),
    );
  }
}

class MechanicProfileSetupScreen extends StatelessWidget {
  const MechanicProfileSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Setup')),
      body: const Center(
        child: Text('Mechanic Profile Setup Screen - Coming Soon'),
      ),
    );
  }
}

class JobDetailScreen extends StatelessWidget {
  final String jobId;
  const JobDetailScreen({super.key, required this.jobId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Job Details')),
      body: Center(
        child: Text('Job Details for ID: $jobId'),
      ),
    );
  }
}

class InventoryManagementScreen extends StatelessWidget {
  const InventoryManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inventory')),
      body: const Center(
        child: Text('Inventory Management Screen - Coming Soon'),
      ),
    );
  }
}