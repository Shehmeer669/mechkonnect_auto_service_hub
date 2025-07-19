# MechKonnect Auto Service Hub

A comprehensive automotive services platform built with Flutter that connects vehicle owners with trusted mechanics and service providers.

## 🚗 Features

- **Find Nearby Mechanics**: Locate certified mechanics and auto service providers in your area
- **Service Booking**: Schedule appointments and book automotive services
- **Real-time Tracking**: Track your vehicle's service progress in real-time
- **User Reviews**: Read and write reviews for service providers
- **Secure Payments**: Safe and secure payment processing
- **Service History**: Keep track of all your vehicle maintenance records
- **Emergency Services**: Quick access to emergency roadside assistance

## 🛠 Tech Stack

- **Framework**: Flutter 3.13.0+
- **State Management**: Riverpod 2.4.9
- **Backend**: Supabase
- **Navigation**: GoRouter 12.1.3
- **UI**: Material Design 3
- **Maps**: Google Maps Flutter
- **Local Storage**: Hive
- **Authentication**: Supabase Auth

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (version 3.13.0 or higher)
- [Dart SDK](https://dart.dev/get-dart) (version 3.1.0 or higher)
- [Android Studio](https://developer.android.com/studio) (for Android development)
- [Xcode](https://developer.apple.com/xcode/) (for iOS development, macOS only)
- [VS Code](https://code.visualstudio.com/) or your preferred IDE

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/Shehmeer669/mechkonnect_auto_service_hub.git
cd mechkonnect_auto_service_hub
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Configure Supabase

1. Create a new project on [Supabase](https://supabase.com/)
2. Get your project URL and anon key from the Supabase dashboard
3. Update the configuration in `lib/config/supabase_config.dart`:

```dart
class SupabaseConfig {
  static const String supabaseUrl = 'YOUR_SUPABASE_URL_HERE';
  static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY_HERE';
}
```

### 4. Configure Google Maps (Optional)

To enable map functionality:

1. Get a Google Maps API key from the [Google Cloud Console](https://console.cloud.google.com/)
2. Enable the following APIs:
   - Maps SDK for Android
   - Maps SDK for iOS
   - Places API
   - Geocoding API

3. Update the API key in:
   - `android/app/src/main/AndroidManifest.xml`
   - `ios/Runner/AppDelegate.swift` (when created)

### 5. Run the Application

#### For Android:
```bash
flutter run -d android
```

#### For iOS:
```bash
flutter run -d ios
```

#### For Web:
```bash
flutter run -d web
```

## 📁 Project Structure

```
lib/
├── config/           # Configuration files
│   └── supabase_config.dart
├── models/           # Data models
├── services/         # Business logic and API services
├── screens/          # UI screens
│   └── splash_screen.dart
├── widgets/          # Reusable UI components
├── providers/        # Riverpod providers for state management
├── utils/           # Utility functions and helpers
├── app.dart         # App configuration and routing
└── main.dart        # Application entry point

android/             # Android-specific files
ios/                 # iOS-specific files
web/                 # Web-specific files
test/                # Test files
assets/              # Images, icons, and other assets
```

## 🔧 Configuration

### Environment Variables

Create a `.env` file in the root directory for sensitive configuration:

```env
SUPABASE_URL=your_supabase_url
SUPABASE_ANON_KEY=your_supabase_anon_key
GOOGLE_MAPS_API_KEY=your_google_maps_api_key
```

### Database Schema

The app expects the following Supabase tables:
- `users` - User profiles and authentication data
- `mechanics` - Mechanic profiles and service information
- `services` - Available automotive services
- `bookings` - Service booking records
- `reviews` - User reviews and ratings

## 🧪 Testing

Run the test suite:

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Generate coverage report
genhtml coverage/lcov.info -o coverage/html
```

## 🏗 Building for Production

### Android APK:
```bash
flutter build apk --release
```

### iOS IPA:
```bash
flutter build ios --release
```

### Web:
```bash
flutter build web --release
```

## 📱 Features Implementation Status

- [x] Project Structure Setup
- [x] Supabase Integration
- [x] Riverpod State Management
- [x] GoRouter Navigation
- [x] Material 3 Theme
- [x] Splash Screen
- [ ] Authentication (Login/Register)
- [ ] Home Screen
- [ ] Mechanic Listing
- [ ] Service Booking
- [ ] Maps Integration
- [ ] Payment Processing
- [ ] Real-time Notifications
- [ ] User Reviews System

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

If you encounter any issues or have questions:

1. Check the [Issues](https://github.com/Shehmeer669/mechkonnect_auto_service_hub/issues) page
2. Create a new issue if your problem isn't already reported
3. Provide detailed information about your environment and the issue

## 📧 Contact

- Project Maintainer: [Shehmeer669](https://github.com/Shehmeer669)
- Email: [Your Email Here]

---

**MechKonnect Auto Service Hub** - Connecting vehicles with trusted service providers! 🚗✨
