import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';

class MechanicDashboardScreen extends ConsumerStatefulWidget {
  const MechanicDashboardScreen({super.key});

  @override
  ConsumerState<MechanicDashboardScreen> createState() => _MechanicDashboardScreenState();
}

class _MechanicDashboardScreenState extends ConsumerState<MechanicDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mechanic Dashboard'),
        actions: [
          Switch(
            value: true, // isAvailable
            onChanged: (value) {
              // Toggle availability
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Card
            Card(
              color: AppColors.success.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.paddingM),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppDimensions.paddingS),
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                      ),
                      child: const Icon(
                        Icons.check_circle,
                        color: Colors.white,
                        size: AppDimensions.iconM,
                      ),
                    ),
                    const SizedBox(width: AppDimensions.marginM),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'You\'re Online',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.success,
                            ),
                          ),
                          Text(
                            'Ready to accept new jobs',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: AppDimensions.marginL),
            
            // Stats Overview
            Text(
              'Today\'s Overview',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: AppDimensions.marginM),
            
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Jobs Completed',
                    '3',
                    Icons.check_circle,
                    AppColors.success,
                  ),
                ),
                const SizedBox(width: AppDimensions.marginM),
                Expanded(
                  child: _buildStatCard(
                    'Revenue',
                    '\$450',
                    Icons.attach_money,
                    AppColors.primary,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: AppDimensions.marginM),
            
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Rating',
                    '4.8',
                    Icons.star,
                    Colors.amber,
                  ),
                ),
                const SizedBox(width: AppDimensions.marginM),
                Expanded(
                  child: _buildStatCard(
                    'Pending',
                    '2',
                    Icons.pending,
                    AppColors.warning,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: AppDimensions.marginL),
            
            // Pending Jobs
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pending Jobs',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('View All'),
                ),
              ],
            ),
            
            const SizedBox(height: AppDimensions.marginM),
            
            _buildJobCard(
              'Oil Change Service',
              'John Doe',
              '2020 Toyota Camry',
              '\$75',
              '2.5 km away',
              true,
            ),
            
            _buildJobCard(
              'Brake Inspection',
              'Sarah Wilson',
              '2019 Honda Civic',
              '\$120',
              '1.8 km away',
              false,
            ),
            
            const SizedBox(height: AppDimensions.marginL),
            
            // Active Jobs
            Text(
              'Active Jobs',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: AppDimensions.marginM),
            
            _buildActiveJobCard(
              'Engine Diagnostic',
              'Mike Johnson',
              '2021 Ford F-150',
              'In Progress',
              0.7,
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
                    'Update Profile',
                    Icons.person,
                    AppColors.primary,
                    () {},
                  ),
                ),
                const SizedBox(width: AppDimensions.marginM),
                Expanded(
                  child: _buildQuickAction(
                    'View Reviews',
                    Icons.star,
                    Colors.amber,
                    () {},
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: AppDimensions.marginM),
            
            Row(
              children: [
                Expanded(
                  child: _buildQuickAction(
                    'Manage Inventory',
                    Icons.inventory,
                    AppColors.secondary,
                    () {},
                  ),
                ),
                const SizedBox(width: AppDimensions.marginM),
                Expanded(
                  child: _buildQuickAction(
                    'View Earnings',
                    Icons.account_balance_wallet,
                    AppColors.success,
                    () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: AppDimensions.iconL,
            ),
            const SizedBox(height: AppDimensions.marginS),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJobCard(
    String service,
    String customerName,
    String vehicle,
    String amount,
    String distance,
    bool isUrgent,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppDimensions.marginM),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            service,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (isUrgent) ...[
                            const SizedBox(width: AppDimensions.marginS),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.error,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'URGENT',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      Text(
                        '$customerName • $vehicle',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        distance,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  amount,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: AppDimensions.marginM),
            
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.error,
                      side: const BorderSide(color: AppColors.error),
                    ),
                    child: const Text('Decline'),
                  ),
                ),
                const SizedBox(width: AppDimensions.marginM),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Accept'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveJobCard(
    String service,
    String customerName,
    String vehicle,
    String status,
    double progress,
  ) {
    return Card(
      color: AppColors.primary.withOpacity(0.05),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$customerName • $vehicle',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: AppDimensions.marginM),
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Progress: ${(progress * 100).toInt()}%',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ],
            ),
            
            const SizedBox(height: AppDimensions.marginM),
            
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.chat),
                    label: const Text('Chat'),
                  ),
                ),
                const SizedBox(width: AppDimensions.marginM),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.update),
                    label: const Text('Update'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAction(
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
            Icon(
              icon,
              color: color,
              size: AppDimensions.iconL,
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
}