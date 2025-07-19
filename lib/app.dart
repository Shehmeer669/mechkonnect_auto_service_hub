import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dynamic_color/dynamic_color.dart';

import 'screens/splash_screen.dart';

/// Main application widget with Material 3 theming and routing configuration
class MechKonnectApp extends ConsumerWidget {
  const MechKonnectApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return MaterialApp.router(
          title: 'MechKonnect Auto Service Hub',
          debugShowCheckedModeBanner: false,
          
          // Material 3 Theme Configuration
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightDynamic ??
                ColorScheme.fromSeed(
                  seedColor: const Color(0xFF1976D2), // Primary blue color
                  brightness: Brightness.light,
                ),
            appBarTheme: const AppBarTheme(
              centerTitle: true,
              elevation: 0,
            ),
            cardTheme: CardTheme(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkDynamic ??
                ColorScheme.fromSeed(
                  seedColor: const Color(0xFF1976D2),
                  brightness: Brightness.dark,
                ),
            appBarTheme: const AppBarTheme(
              centerTitle: true,
              elevation: 0,
            ),
            cardTheme: CardTheme(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          
          themeMode: ThemeMode.system,
          
          // Router Configuration
          routerConfig: _router,
        );
      },
    );
  }
}

/// GoRouter configuration for navigation
final GoRouter _router = GoRouter(
  initialLocation: '/splash',
  routes: [
    // Splash Screen Route
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    
    // TODO: Add more routes as screens are implemented
    // Example routes for future implementation:
    /*
    GoRoute(
      path: '/auth',
      name: 'auth',
      builder: (context, state) => const AuthScreen(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/services',
      name: 'services',
      builder: (context, state) => const ServicesScreen(),
    ),
    GoRoute(
      path: '/booking/:serviceId',
      name: 'booking',
      builder: (context, state) {
        final serviceId = state.pathParameters['serviceId']!;
        return BookingScreen(serviceId: serviceId);
      },
    ),
    */
  ],
  
  // Error handling
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(
      title: const Text('Page Not Found'),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          Text(
            'Page not found: ${state.location}',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.go('/splash'),
            child: const Text('Go to Home'),
          ),
        ],
      ),
    ),
  ),
);