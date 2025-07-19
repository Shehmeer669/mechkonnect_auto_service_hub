import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/models/booking_model.dart';

class BookMechanicScreen extends ConsumerStatefulWidget {
  const BookMechanicScreen({super.key});

  @override
  ConsumerState<BookMechanicScreen> createState() => _BookMechanicScreenState();
}

class _BookMechanicScreenState extends ConsumerState<BookMechanicScreen> {
  final _searchController = TextEditingController();
  ServiceType? _selectedServiceType;
  double _selectedRadius = 10.0;
  bool _showMap = true;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Mechanic'),
        actions: [
          IconButton(
            icon: Icon(_showMap ? Icons.list : Icons.map),
            onPressed: () => setState(() => _showMap = !_showMap),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filters
          Container(
            padding: const EdgeInsets.all(AppDimensions.paddingM),
            color: Theme.of(context).cardColor,
            child: Column(
              children: [
                // Search Bar
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search mechanics or services...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.tune),
                      onPressed: _showFilters,
                    ),
                  ),
                ),
                
                const SizedBox(height: AppDimensions.marginM),
                
                // Service Type Filter
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: ServiceType.values.length,
                    itemBuilder: (context, index) {
                      final serviceType = ServiceType.values[index];
                      final isSelected = _selectedServiceType == serviceType;
                      
                      return Padding(
                        padding: const EdgeInsets.only(right: AppDimensions.marginS),
                        child: FilterChip(
                          label: Text(_getServiceTypeDisplayName(serviceType)),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              _selectedServiceType = selected ? serviceType : null;
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          
          // Content
          Expanded(
            child: _showMap ? _buildMapView() : _buildListView(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showEmergencyServices,
        icon: const Icon(Icons.emergency),
        label: const Text('Emergency'),
        backgroundColor: AppColors.error,
      ),
    );
  }

  Widget _buildMapView() {
    return Container(
      color: Colors.grey[200],
      child: Stack(
        children: [
          // Map placeholder
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.map,
                  size: 100,
                  color: Colors.grey,
                ),
                Text(
                  'Map View',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.grey,
                  ),
                ),
                Text('Showing mechanics near you'),
              ],
            ),
          ),
          
          // Mechanic markers overlay
          Positioned(
            top: 50,
            left: 50,
            child: _buildMechanicMarker('John\'s Auto', 4.8, 2.5),
          ),
          Positioned(
            top: 150,
            right: 80,
            child: _buildMechanicMarker('Mike\'s Garage', 4.6, 1.2),
          ),
          Positioned(
            bottom: 200,
            left: 100,
            child: _buildMechanicMarker('Quick Fix', 4.9, 0.8),
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      itemCount: 10,
      itemBuilder: (context, index) {
        return _buildMechanicCard(index);
      },
    );
  }

  Widget _buildMechanicMarker(String name, double rating, double distance) {
    return GestureDetector(
      onTap: () => _showMechanicDetails(name, rating, distance),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.build,
              color: AppColors.primary,
              size: 20,
            ),
            Text(
              name,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star, size: 12, color: Colors.amber),
                Text('$rating', style: const TextStyle(fontSize: 10)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMechanicCard(int index) {
    final mechanics = [
      {'name': 'John\'s Auto Service', 'rating': 4.8, 'distance': 2.5, 'hourlyRate': 75},
      {'name': 'Mike\'s Garage', 'rating': 4.6, 'distance': 1.2, 'hourlyRate': 65},
      {'name': 'Quick Fix Motors', 'rating': 4.9, 'distance': 0.8, 'hourlyRate': 80},
      {'name': 'Pro Auto Care', 'rating': 4.7, 'distance': 3.1, 'hourlyRate': 70},
      {'name': 'Elite Service Hub', 'rating': 4.5, 'distance': 4.2, 'hourlyRate': 85},
    ];
    
    final mechanic = mechanics[index % mechanics.length];
    
    return Card(
      margin: const EdgeInsets.only(bottom: AppDimensions.marginM),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  child: Text(
                    mechanic['name'].toString().substring(0, 1),
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(width: AppDimensions.marginM),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mechanic['name'].toString(),
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 16, color: Colors.amber),
                          Text(' ${mechanic['rating']} '),
                          const Icon(Icons.location_on, size: 16, color: Colors.grey),
                          Text(' ${mechanic['distance']} km away'),
                        ],
                      ),
                      Text(
                        '\$${mechanic['hourlyRate']}/hour',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
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
                    color: AppColors.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Available',
                    style: TextStyle(
                      color: AppColors.success,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: AppDimensions.marginM),
            
            // Services
            Wrap(
              spacing: 8,
              children: [
                _buildServiceChip('Oil Change'),
                _buildServiceChip('Brake Service'),
                _buildServiceChip('Engine Repair'),
              ],
            ),
            
            const SizedBox(height: AppDimensions.marginM),
            
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => context.pushNamed(
                      'mechanic-detail',
                      pathParameters: {'mechanicId': 'mechanic_$index'},
                    ),
                    child: const Text('View Details'),
                  ),
                ),
                const SizedBox(width: AppDimensions.marginM),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => context.pushNamed(
                      'booking-confirmation',
                      extra: {
                        'mechanicId': 'mechanic_$index',
                        'mechanicName': mechanic['name'],
                      },
                    ),
                    child: const Text('Book Now'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceChip(String service) {
    return Chip(
      label: Text(
        service,
        style: const TextStyle(fontSize: 12),
      ),
      backgroundColor: AppColors.accent.withOpacity(0.1),
      side: BorderSide(color: AppColors.accent.withOpacity(0.3)),
    );
  }

  String _getServiceTypeDisplayName(ServiceType serviceType) {
    switch (serviceType) {
      case ServiceType.oilChange:
        return 'Oil Change';
      case ServiceType.brakeService:
        return 'Brakes';
      case ServiceType.tireService:
        return 'Tires';
      case ServiceType.engineRepair:
        return 'Engine';
      case ServiceType.transmissionService:
        return 'Transmission';
      case ServiceType.electricalService:
        return 'Electrical';
      case ServiceType.acService:
        return 'AC Service';
      case ServiceType.generalMaintenance:
        return 'Maintenance';
      case ServiceType.diagnostic:
        return 'Diagnostic';
      case ServiceType.other:
        return 'Other';
    }
  }

  void _showFilters() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppDimensions.paddingL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filters',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppDimensions.marginL),
            
            Text(
              'Search Radius: ${_selectedRadius.toInt()} km',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Slider(
              value: _selectedRadius,
              min: 1,
              max: 50,
              divisions: 49,
              onChanged: (value) => setState(() => _selectedRadius = value),
            ),
            
            const SizedBox(height: AppDimensions.marginL),
            
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: AppDimensions.marginM),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // Apply filters
                    },
                    child: const Text('Apply'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showMechanicDetails(String name, double rating, double distance) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 16),
                Text(' $rating rating'),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.grey, size: 16),
                Text(' $distance km away'),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.pushNamed(
                'mechanic-detail',
                pathParameters: {'mechanicId': name.replaceAll(' ', '_')},
              );
            },
            child: const Text('View Details'),
          ),
        ],
      ),
    );
  }

  void _showEmergencyServices() {
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
                color: AppColors.error,
              ),
            ),
            const SizedBox(height: AppDimensions.marginL),
            
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.error,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.car_crash, color: Colors.white),
              ),
              title: const Text('Roadside Assistance'),
              subtitle: const Text('24/7 emergency help'),
              trailing: const Text('\$150', style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () => _bookEmergencyService('Roadside Assistance'),
            ),
            
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.warning,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.local_gas_station, color: Colors.white),
              ),
              title: const Text('Fuel Delivery'),
              subtitle: const Text('Emergency fuel service'),
              trailing: const Text('\$75', style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () => _bookEmergencyService('Fuel Delivery'),
            ),
            
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.info,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.battery_alert, color: Colors.white),
              ),
              title: const Text('Jump Start'),
              subtitle: const Text('Dead battery assistance'),
              trailing: const Text('\$50', style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () => _bookEmergencyService('Jump Start'),
            ),
          ],
        ),
      ),
    );
  }

  void _bookEmergencyService(String serviceName) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$serviceName requested! Help is on the way.'),
        backgroundColor: AppColors.success,
        action: SnackBarAction(
          label: 'Track',
          onPressed: () {
            // Navigate to tracking screen
          },
        ),
      ),
    );
  }
}