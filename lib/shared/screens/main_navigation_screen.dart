import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/models/user_model.dart';
import '../../core/constants/app_constants.dart';

class MainNavigationScreen extends StatefulWidget {
  final Widget child;
  final UserRole userRole;

  const MainNavigationScreen({
    super.key,
    required this.child,
    required this.userRole,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  List<NavigationItem> get _navigationItems {
    switch (widget.userRole) {
      case UserRole.user:
        return [
          NavigationItem(
            icon: Icons.home,
            label: AppStrings.home,
            route: '/user/home',
          ),
          NavigationItem(
            icon: Icons.build,
            label: 'Book Service',
            route: '/user/book-mechanic',
          ),
          NavigationItem(
            icon: Icons.shopping_cart,
            label: AppStrings.marketplace,
            route: '/user/marketplace',
          ),
          NavigationItem(
            icon: Icons.history,
            label: 'History',
            route: '/user/service-history',
          ),
          NavigationItem(
            icon: Icons.person,
            label: AppStrings.profile,
            route: '/user/profile',
          ),
        ];
      case UserRole.mechanic:
        return [
          NavigationItem(
            icon: Icons.dashboard,
            label: AppStrings.dashboard,
            route: '/mechanic/dashboard',
          ),
          NavigationItem(
            icon: Icons.work,
            label: 'Jobs',
            route: '/mechanic/dashboard',
          ),
          NavigationItem(
            icon: Icons.inventory,
            label: AppStrings.inventory,
            route: '/mechanic/inventory',
          ),
          NavigationItem(
            icon: Icons.person,
            label: AppStrings.profile,
            route: '/mechanic/profile-setup',
          ),
        ];
      case UserRole.admin:
        return [
          NavigationItem(
            icon: Icons.dashboard,
            label: AppStrings.dashboard,
            route: '/admin/dashboard',
          ),
          NavigationItem(
            icon: Icons.people,
            label: AppStrings.users,
            route: '/admin/users',
          ),
          NavigationItem(
            icon: Icons.build,
            label: AppStrings.mechanics,
            route: '/admin/mechanics',
          ),
          NavigationItem(
            icon: Icons.inventory,
            label: AppStrings.parts,
            route: '/admin/parts',
          ),
          NavigationItem(
            icon: Icons.analytics,
            label: AppStrings.reports,
            route: '/admin/reports',
          ),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onTap,
        items: _navigationItems
            .map((item) => BottomNavigationBarItem(
                  icon: Icon(item.icon),
                  label: item.label,
                ))
            .toList(),
      ),
    );
  }

  void _onTap(int index) {
    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index;
      });
      context.go(_navigationItems[index].route);
    }
  }
}

class NavigationItem {
  final IconData icon;
  final String label;
  final String route;

  const NavigationItem({
    required this.icon,
    required this.label,
    required this.route,
  });
}