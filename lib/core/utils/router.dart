import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/user_model.dart';
import '../providers/auth_provider.dart';
import '../../features/auth/screens/welcome_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/otp_verification_screen.dart';
import '../../features/auth/screens/signup_screen.dart';
import '../../features/auth/screens/complete_profile_screen.dart';
import '../../features/user/screens/user_home_screen.dart';
import '../../features/user/screens/user_screens.dart';
import '../../features/mechanic/screens/mechanic_screens.dart';
import '../../features/admin/screens/admin_screens.dart';
import '../../features/chat/screens/chat_screen.dart';
import '../../shared/screens/main_navigation_screen.dart';

part 'router.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  final isAuthenticated = ref.watch(isAuthenticatedProvider);
  final userRole = ref.watch(userRoleProvider);

  return GoRouter(
    initialLocation: '/welcome',
    redirect: (context, state) {
      final location = state.location;
      
      // If not authenticated and trying to access protected routes
      if (!isAuthenticated && 
          !location.startsWith('/welcome') && 
          !location.startsWith('/login') && 
          !location.startsWith('/signup') && 
          !location.startsWith('/otp') && 
          !location.startsWith('/complete-profile') &&
          !location.startsWith('/admin-login')) {
        return '/welcome';
      }
      
      // If authenticated but trying to access auth screens
      if (isAuthenticated && 
          (location.startsWith('/welcome') || 
           location.startsWith('/login') || 
           location.startsWith('/signup') || 
           location.startsWith('/otp'))) {
        
        // Redirect based on role
        switch (userRole) {
          case UserRole.user:
            return '/user/home';
          case UserRole.mechanic:
            return '/mechanic/dashboard';
          case UserRole.admin:
            return '/admin/dashboard';
          default:
            return '/complete-profile';
        }
      }
      
      return null;
    },
    routes: [
      // Auth Routes
      GoRoute(
        path: '/welcome',
        name: 'welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/otp',
        name: 'otp',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return OtpVerificationScreen(
            email: extra?['email'],
            phone: extra?['phone'],
          );
        },
      ),
      GoRoute(
        path: '/complete-profile',
        name: 'complete-profile',
        builder: (context, state) => const CompleteProfileScreen(),
      ),
      
      // User Routes
      GoRoute(
        path: '/user',
        redirect: (context, state) => '/user/home',
      ),
      ShellRoute(
        builder: (context, state, child) => MainNavigationScreen(
          child: child,
          userRole: UserRole.user,
        ),
        routes: [
          GoRoute(
            path: '/user/home',
            name: 'user-home',
            builder: (context, state) => const UserHomeScreen(),
          ),
          GoRoute(
            path: '/user/book-mechanic',
            name: 'book-mechanic',
            builder: (context, state) => const BookMechanicScreen(),
          ),
          GoRoute(
            path: '/user/mechanic/:mechanicId',
            name: 'mechanic-detail',
            builder: (context, state) => MechanicDetailScreen(
              mechanicId: state.pathParameters['mechanicId']!,
            ),
          ),
          GoRoute(
            path: '/user/booking-confirmation',
            name: 'booking-confirmation',
            builder: (context, state) {
              final extra = state.extra as Map<String, dynamic>?;
              return BookingConfirmationScreen(
                mechanicId: extra?['mechanicId'],
                serviceType: extra?['serviceType'],
              );
            },
          ),
          GoRoute(
            path: '/user/live-tracking/:bookingId',
            name: 'live-tracking',
            builder: (context, state) => LiveTrackingScreen(
              bookingId: state.pathParameters['bookingId']!,
            ),
          ),
          GoRoute(
            path: '/user/marketplace',
            name: 'marketplace',
            builder: (context, state) => const MarketplaceHomeScreen(),
          ),
          GoRoute(
            path: '/user/part/:partId',
            name: 'part-detail',
            builder: (context, state) => PartDetailScreen(
              partId: state.pathParameters['partId']!,
            ),
          ),
          GoRoute(
            path: '/user/cart',
            name: 'cart',
            builder: (context, state) => const CartScreen(),
          ),
          GoRoute(
            path: '/user/payment',
            name: 'payment',
            builder: (context, state) => const PaymentScreen(),
          ),
          GoRoute(
            path: '/user/profile',
            name: 'user-profile',
            builder: (context, state) => const UserProfileScreen(),
          ),
          GoRoute(
            path: '/user/vehicles',
            name: 'vehicle-management',
            builder: (context, state) => const VehicleManagementScreen(),
          ),
          GoRoute(
            path: '/user/vehicle/:vehicleId',
            name: 'vehicle-detail',
            builder: (context, state) => VehicleDetailScreen(
              vehicleId: state.pathParameters['vehicleId']!,
            ),
          ),
          GoRoute(
            path: '/user/service-history',
            name: 'service-history',
            builder: (context, state) => const ServiceHistoryScreen(),
          ),
          GoRoute(
            path: '/user/notifications',
            name: 'user-notifications',
            builder: (context, state) => const UserNotificationsScreen(),
          ),
        ],
      ),
      
      // Mechanic Routes
      GoRoute(
        path: '/mechanic',
        redirect: (context, state) => '/mechanic/dashboard',
      ),
      ShellRoute(
        builder: (context, state, child) => MainNavigationScreen(
          child: child,
          userRole: UserRole.mechanic,
        ),
        routes: [
          GoRoute(
            path: '/mechanic/dashboard',
            name: 'mechanic-dashboard',
            builder: (context, state) => const MechanicDashboardScreen(),
          ),
          GoRoute(
            path: '/mechanic/profile-setup',
            name: 'mechanic-profile-setup',
            builder: (context, state) => const MechanicProfileSetupScreen(),
          ),
          GoRoute(
            path: '/mechanic/job/:jobId',
            name: 'job-detail',
            builder: (context, state) => JobDetailScreen(
              jobId: state.pathParameters['jobId']!,
            ),
          ),
          GoRoute(
            path: '/mechanic/inventory',
            name: 'inventory-management',
            builder: (context, state) => const InventoryManagementScreen(),
          ),
        ],
      ),
      
      // Admin Routes
      GoRoute(
        path: '/admin-login',
        name: 'admin-login',
        builder: (context, state) => const AdminLoginScreen(),
      ),
      GoRoute(
        path: '/admin',
        redirect: (context, state) => '/admin/dashboard',
      ),
      ShellRoute(
        builder: (context, state, child) => MainNavigationScreen(
          child: child,
          userRole: UserRole.admin,
        ),
        routes: [
          GoRoute(
            path: '/admin/dashboard',
            name: 'admin-dashboard',
            builder: (context, state) => const AdminDashboardScreen(),
          ),
          GoRoute(
            path: '/admin/users',
            name: 'admin-users',
            builder: (context, state) => const AdminUsersScreen(),
          ),
          GoRoute(
            path: '/admin/mechanics',
            name: 'admin-mechanics',
            builder: (context, state) => const AdminMechanicsScreen(),
          ),
          GoRoute(
            path: '/admin/parts',
            name: 'admin-parts',
            builder: (context, state) => const AdminPartsScreen(),
          ),
          GoRoute(
            path: '/admin/bookings',
            name: 'admin-bookings',
            builder: (context, state) => const AdminBookingsScreen(),
          ),
          GoRoute(
            path: '/admin/reports',
            name: 'admin-reports',
            builder: (context, state) => const AdminReportsScreen(),
          ),
        ],
      ),
      
      // Shared Routes
      GoRoute(
        path: '/chat/:chatRoomId',
        name: 'chat',
        builder: (context, state) => ChatScreen(
          chatRoomId: state.pathParameters['chatRoomId']!,
        ),
      ),
    ],
  );
}