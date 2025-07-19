import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/providers/auth_provider.dart';

class UserHomeScreen extends ConsumerWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final user = authState.value;
    
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, ${user?.firstName ?? 'User'}',
              style: const TextStyle(fontSize: 16),
            ),
            const Text(
              'Find your mechanic',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () => context.pushNamed('user-notifications'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search mechanics, services...',
                  prefixIcon: const Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingM,
                    vertical: AppDimensions.paddingM,
                  ),
                ),
                onTap: () => context.pushNamed('book-mechanic'),
              ),
            ),
            
            const SizedBox(height: AppDimensions.marginL),
            
            // Quick Actions
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: AppDimensions.marginM),
            
            Row(
              children: [
                Expanded(
                  child: _buildQuickAction(
                    context,
                    'Book Service',
                    Icons.build,
                    AppColors.primary,
                    () => context.pushNamed('book-mechanic'),
                  ),
                ),
                const SizedBox(width: AppDimensions.marginM),
                Expanded(
                  child: _buildQuickAction(
                    context,
                    'Buy Parts',
                    Icons.shopping_cart,
                    AppColors.secondary,
                    () => context.pushNamed('marketplace'),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: AppDimensions.marginM),
            
            Row(
              children: [
                Expanded(
                  child: _buildQuickAction(
                    context,
                    'My Vehicles',
                    Icons.directions_car,
                    AppColors.accent,
                    () => context.pushNamed('vehicle-management'),
                  ),
                ),
                const SizedBox(width: AppDimensions.marginM),
                Expanded(
                  child: _buildQuickAction(
                    context,
                    'Emergency',
                    Icons.emergency,
                    AppColors.error,
                    () => _showEmergencyOptions(context),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: AppDimensions.marginL),
            
            // Recent Bookings
            Text(
              'Recent Bookings',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: AppDimensions.marginM),
            
            _buildRecentBookingCard(context),
            
            const SizedBox(height: AppDimensions.marginL),
            
            // Maintenance Alerts
            Text(
              'Maintenance Alerts',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: AppDimensions.marginM),
            
            _buildMaintenanceAlert(context),
            
            const SizedBox(height: AppDimensions.marginL),
            
            // Featured Mechanics
            Text(
              'Top Rated Mechanics',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: AppDimensions.marginM),
            
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return _buildMechanicCard(context, index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAction(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(AppDimensions.paddingS),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(AppDimensions.radiusS),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: AppDimensions.iconM,
              ),
            ),
            const SizedBox(height: AppDimensions.marginS),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentBookingCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppDimensions.paddingS),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: AppColors.success,
                    size: AppDimensions.iconS,
                  ),
                ),
                const SizedBox(width: AppDimensions.marginM),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Oil Change - Completed',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'John\'s Auto Service • 2 days ago',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () => context.pushNamed('service-history'),
                  child: const Text('View'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMaintenanceAlert(BuildContext context) {
    return Card(
      color: AppColors.warning.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppDimensions.paddingS),
              decoration: BoxDecoration(
                color: AppColors.warning,
                borderRadius: BorderRadius.circular(AppDimensions.radiusS),
              ),
              child: const Icon(
                Icons.warning,
                color: Colors.white,
                size: AppDimensions.iconS,
              ),
            ),
            const SizedBox(width: AppDimensions.marginM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Brake Service Due',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Your 2020 Toyota Camry is due for brake service',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () => context.pushNamed('book-mechanic'),
              child: const Text('Book'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMechanicCard(BuildContext context, int index) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: AppDimensions.marginM),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingM),
          child: Column(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.primary.withOpacity(0.1),
                child: Text(
                  'M${index + 1}',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.marginS),
              Text(
                'Mechanic ${index + 1}',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 16,
                  ),
                  Text(
                    ' 4.${8 + index}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.marginS),
              TextButton(
                onPressed: () => context.pushNamed(
                  'mechanic-detail',
                  pathParameters: {'mechanicId': 'mechanic_$index'},
                ),
                child: const Text('View'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEmergencyOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppDimensions.paddingL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Emergency Services',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppDimensions.marginL),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(AppDimensions.paddingS),
                decoration: BoxDecoration(
                  color: AppColors.error,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                ),
                child: const Icon(
                  Icons.car_crash,
                  color: Colors.white,
                ),
              ),
              title: const Text('Roadside Assistance'),
              subtitle: const Text('Get help if your car breaks down'),
              onTap: () {
                Navigator.pop(context);
                // Handle roadside assistance
              },
            ),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(AppDimensions.paddingS),
                decoration: BoxDecoration(
                  color: AppColors.warning,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                ),
                child: const Icon(
                  Icons.local_gas_station,
                  color: Colors.white,
                ),
              ),
              title: const Text('Fuel Delivery'),
              subtitle: const Text('Get fuel delivered to your location'),
              onTap: () {
                Navigator.pop(context);
                // Handle fuel delivery
              },
            ),
          ],
        ),
      ),
    );
  }
}