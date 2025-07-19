import 'package:flutter/material.dart';

/// App color constants
class AppColors {
  // Primary colors (automotive theme)
  static const Color primary = Color(0xFF1A237E); // Deep blue
  static const Color primaryLight = Color(0xFF534BAE);
  static const Color primaryDark = Color(0xFF000051);
  
  // Secondary colors
  static const Color secondary = Color(0xFFFF6F00); // Orange
  static const Color secondaryLight = Color(0xFFFF9F40);
  static const Color secondaryDark = Color(0xFFC43E00);
  
  // Accent colors
  static const Color accent = Color(0xFF00BCD4); // Cyan
  static const Color accentLight = Color(0xFF62EFFF);
  static const Color accentDark = Color(0xFF008BA3);
  
  // Status colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);
  
  // Neutral colors
  static const Color background = Color(0xFFFAFAFA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFF212121);
  static const Color onBackground = Color(0xFF212121);
  
  // Dark theme colors
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkOnSurface = Color(0xFFE0E0E0);
  static const Color darkOnBackground = Color(0xFFE0E0E0);
  
  // Role-specific colors
  static const Color userRole = Color(0xFF2196F3);
  static const Color mechanicRole = Color(0xFF4CAF50);
  static const Color adminRole = Color(0xFF9C27B0);
}

/// App string constants
class AppStrings {
  // App info
  static const String appName = 'MechKonnect';
  static const String appTagline = 'Your Trusted Auto Service Partner';
  
  // Common actions
  static const String login = 'Login';
  static const String signup = 'Sign Up';
  static const String logout = 'Logout';
  static const String save = 'Save';
  static const String cancel = 'Cancel';
  static const String delete = 'Delete';
  static const String edit = 'Edit';
  static const String update = 'Update';
  static const String submit = 'Submit';
  static const String confirm = 'Confirm';
  static const String book = 'Book Now';
  static const String search = 'Search';
  static const String filter = 'Filter';
  static const String apply = 'Apply';
  static const String reset = 'Reset';
  
  // Navigation
  static const String home = 'Home';
  static const String profile = 'Profile';
  static const String bookings = 'Bookings';
  static const String marketplace = 'Marketplace';
  static const String notifications = 'Notifications';
  static const String chat = 'Chat';
  static const String dashboard = 'Dashboard';
  static const String inventory = 'Inventory';
  static const String users = 'Users';
  static const String mechanics = 'Mechanics';
  static const String parts = 'Parts';
  static const String orders = 'Orders';
  static const String reports = 'Reports';
  
  // Error messages
  static const String networkError = 'Network connection error';
  static const String genericError = 'Something went wrong';
  static const String validationError = 'Please check your input';
  static const String authError = 'Authentication failed';
  static const String permissionError = 'Permission denied';
}

/// App dimension constants
class AppDimensions {
  // Padding
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;
  static const double paddingXL = 32.0;
  static const double paddingXXL = 48.0;
  
  // Margin
  static const double marginXS = 4.0;
  static const double marginS = 8.0;
  static const double marginM = 16.0;
  static const double marginL = 24.0;
  static const double marginXL = 32.0;
  
  // Border radius
  static const double radiusXS = 4.0;
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 24.0;
  static const double radiusCircular = 100.0;
  
  // Heights
  static const double buttonHeight = 48.0;
  static const double inputHeight = 56.0;
  static const double appBarHeight = 56.0;
  static const double bottomNavHeight = 60.0;
  
  // Icon sizes
  static const double iconXS = 16.0;
  static const double iconS = 20.0;
  static const double iconM = 24.0;
  static const double iconL = 32.0;
  static const double iconXL = 48.0;
}