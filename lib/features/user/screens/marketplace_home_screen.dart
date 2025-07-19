import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/models/part_model.dart';

class MarketplaceHomeScreen extends ConsumerStatefulWidget {
  const MarketplaceHomeScreen({super.key});

  @override
  ConsumerState<MarketplaceHomeScreen> createState() => _MarketplaceHomeScreenState();
}

class _MarketplaceHomeScreenState extends ConsumerState<MarketplaceHomeScreen> {
  final _searchController = TextEditingController();
  PartCategory? _selectedCategory;
  String _sortBy = 'popularity';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parts Marketplace'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => context.pushNamed('cart'),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(AppDimensions.paddingM),
            color: Theme.of(context).cardColor,
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search parts...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.tune),
                      onPressed: _showFilters,
                    ),
                    IconButton(
                      icon: const Icon(Icons.sort),
                      onPressed: _showSortOptions,
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Categories
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
              itemCount: PartCategory.values.length,
              itemBuilder: (context, index) {
                final category = PartCategory.values[index];
                return _buildCategoryCard(category);
              },
            ),
          ),
          
          // Featured Banner
          Container(
            margin: const EdgeInsets.all(AppDimensions.paddingM),
            height: 120,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.secondary, AppColors.secondaryDark],
              ),
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: AppDimensions.paddingM,
                  top: AppDimensions.paddingM,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Special Offer',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Up to 30% off on\nbrake parts',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.secondary,
                          minimumSize: const Size(80, 32),
                        ),
                        child: const Text('Shop Now'),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: AppDimensions.paddingM,
                  top: AppDimensions.paddingM,
                  child: const Icon(
                    Icons.car_repair,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          
          // Parts Grid
          Expanded(
            child: _buildPartsGrid(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showScannerDialog,
        child: const Icon(Icons.qr_code_scanner),
      ),
    );
  }

  Widget _buildCategoryCard(PartCategory category) {
    final isSelected = _selectedCategory == category;
    
    return GestureDetector(
      onTap: () => setState(() {
        _selectedCategory = isSelected ? null : category;
      }),
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(right: AppDimensions.marginM),
        child: Column(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: isSelected 
                    ? AppColors.primary 
                    : AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              ),
              child: Icon(
                _getCategoryIcon(category),
                color: isSelected ? Colors.white : AppColors.primary,
                size: 30,
              ),
            ),
            const SizedBox(height: AppDimensions.marginS),
            Text(
              _getCategoryDisplayName(category),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? AppColors.primary : null,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPartsGrid() {
    // Mock parts data
    final parts = List.generate(20, (index) => {
      'id': 'part_$index',
      'name': _getPartName(index),
      'price': (50 + (index * 25)).toDouble(),
      'originalPrice': (70 + (index * 30)).toDouble(),
      'rating': 4.0 + (index % 5) * 0.2,
      'reviews': 50 + (index * 10),
      'image': 'https://via.placeholder.com/150',
      'inStock': index % 4 != 0,
      'fastDelivery': index % 3 == 0,
    });

    return GridView.builder(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: AppDimensions.marginM,
        mainAxisSpacing: AppDimensions.marginM,
      ),
      itemCount: parts.length,
      itemBuilder: (context, index) {
        final part = parts[index];
        return _buildPartCard(part);
      },
    );
  }

  Widget _buildPartCard(Map<String, dynamic> part) {
    return GestureDetector(
      onTap: () => context.pushNamed(
        'part-detail',
        pathParameters: {'partId': part['id']},
      ),
      child: Card(
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppDimensions.radiusM),
                  ),
                ),
                child: Stack(
                  children: [
                    const Center(
                      child: Icon(
                        Icons.auto_parts,
                        size: 60,
                        color: Colors.grey,
                      ),
                    ),
                    
                    // Badges
                    if (part['fastDelivery'])
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.success,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Fast',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    
                    if (!part['inStock'])
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.error,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Out of Stock',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            
            // Details
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.paddingS),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      part['name'],
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    Row(
                      children: [
                        const Icon(Icons.star, size: 12, color: Colors.amber),
                        Text(
                          ' ${part['rating']} (${part['reviews']})',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    
                    const Spacer(),
                    
                    Row(
                      children: [
                        Text(
                          '\$${part['price']}',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '\$${part['originalPrice']}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => _addToCart(part),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: part['inStock'] 
                                  ? AppColors.primary 
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Icon(
                              Icons.add_shopping_cart,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(PartCategory category) {
    switch (category) {
      case PartCategory.engine:
        return Icons.engineering;
      case PartCategory.transmission:
        return Icons.settings;
      case PartCategory.brakes:
        return Icons.stop_circle;
      case PartCategory.suspension:
        return Icons.height;
      case PartCategory.electrical:
        return Icons.electrical_services;
      case PartCategory.exhaust:
        return Icons.air;
      case PartCategory.cooling:
        return Icons.ac_unit;
      case PartCategory.fuelSystem:
        return Icons.local_gas_station;
      case PartCategory.interior:
        return Icons.airline_seat_recline_normal;
      case PartCategory.exterior:
        return Icons.directions_car;
      case PartCategory.wheelsTires:
        return Icons.tire_repair;
      case PartCategory.filters:
        return Icons.filter_alt;
      case PartCategory.fluids:
        return Icons.opacity;
      case PartCategory.other:
        return Icons.more_horiz;
    }
  }

  String _getCategoryDisplayName(PartCategory category) {
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

  String _getPartName(int index) {
    final names = [
      'Brake Pads Set',
      'Engine Oil Filter',
      'Air Filter',
      'Spark Plugs',
      'Battery',
      'Windshield Wipers',
      'Transmission Fluid',
      'Brake Fluid',
      'Radiator',
      'Alternator',
      'Starter Motor',
      'Fuel Pump',
      'Timing Belt',
      'Water Pump',
      'Thermostat',
      'Serpentine Belt',
      'Cabin Filter',
      'Oxygen Sensor',
      'Catalytic Converter',
      'Headlight Bulb',
    ];
    return names[index % names.length];
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
            
            const Text('Price Range'),
            RangeSlider(
              values: const RangeValues(0, 500),
              min: 0,
              max: 1000,
              divisions: 20,
              labels: const RangeLabels('\$0', '\$500'),
              onChanged: (RangeValues values) {},
            ),
            
            const SizedBox(height: AppDimensions.marginM),
            
            CheckboxListTile(
              title: const Text('In Stock Only'),
              value: true,
              onChanged: (value) {},
            ),
            
            CheckboxListTile(
              title: const Text('Fast Delivery'),
              value: false,
              onChanged: (value) {},
            ),
            
            const SizedBox(height: AppDimensions.marginL),
            
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Reset'),
                  ),
                ),
                const SizedBox(width: AppDimensions.marginM),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
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

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppDimensions.paddingL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sort By',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppDimensions.marginL),
            
            ...['popularity', 'price_low', 'price_high', 'rating', 'newest']
                .map((option) => ListTile(
                      title: Text(_getSortDisplayName(option)),
                      leading: Radio<String>(
                        value: option,
                        groupValue: _sortBy,
                        onChanged: (value) {
                          setState(() => _sortBy = value!);
                          Navigator.pop(context);
                        },
                      ),
                    )),
          ],
        ),
      ),
    );
  }

  String _getSortDisplayName(String sortBy) {
    switch (sortBy) {
      case 'popularity':
        return 'Most Popular';
      case 'price_low':
        return 'Price: Low to High';
      case 'price_high':
        return 'Price: High to Low';
      case 'rating':
        return 'Highest Rated';
      case 'newest':
        return 'Newest First';
      default:
        return sortBy;
    }
  }

  void _showScannerDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Scan Part'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.qr_code_scanner,
              size: 100,
              color: AppColors.primary,
            ),
            SizedBox(height: 16),
            Text(
              'Scan the QR code or barcode on your part to find compatible replacements',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement scanner functionality
            },
            child: const Text('Open Scanner'),
          ),
        ],
      ),
    );
  }

  void _addToCart(Map<String, dynamic> part) {
    if (!part['inStock']) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('This item is out of stock'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${part['name']} added to cart'),
        backgroundColor: AppColors.success,
        action: SnackBarAction(
          label: 'View Cart',
          onPressed: () => context.pushNamed('cart'),
        ),
      ),
    );
  }
}