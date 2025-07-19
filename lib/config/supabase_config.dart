/// Supabase configuration for MechKonnect Auto Service Hub
/// 
/// This file contains configuration constants for connecting to Supabase.
/// Make sure to update these values with your actual Supabase project credentials.
class SupabaseConfig {
  // TODO: Replace with your actual Supabase URL
  static const String supabaseUrl = 'https://your-project-ref.supabase.co';
  
  // TODO: Replace with your actual Supabase anon key
  static const String supabaseAnonKey = 'your-anon-key-here';
  
  // Additional configuration constants
  static const String bucketName = 'mechkonnect-storage';
  static const String profilesBucket = 'profiles';
  static const String serviceImagesBucket = 'service-images';
  
  // Table names
  static const String usersTable = 'users';
  static const String mechanicsTable = 'mechanics';
  static const String servicesTable = 'services';
  static const String bookingsTable = 'bookings';
  static const String reviewsTable = 'reviews';
  
  // Real-time subscriptions
  static const String bookingsChannel = 'bookings-channel';
  static const String messagesChannel = 'messages-channel';
}