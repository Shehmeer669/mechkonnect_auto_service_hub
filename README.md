# MechKonnect Auto Service Hub

A comprehensive Flutter mobile application that connects vehicle owners with certified mechanics and provides a marketplace for auto parts. The platform serves three user roles: Vehicle Owners, Mechanics, and Administrators.

## 🚗 Features

### For Vehicle Owners (Users)
- **Find & Book Mechanics**: Search and book certified mechanics in your area
- **Real-time Tracking**: Track mechanic location and service progress
- **Parts Marketplace**: Browse and purchase genuine auto parts
- **Vehicle Management**: Manage multiple vehicles with maintenance alerts
- **Service History**: View past services, invoices, and ratings
- **Emergency Services**: 24/7 roadside assistance and emergency repairs

### For Mechanics
- **Job Management**: Accept/reject jobs with real-time notifications  
- **Dashboard**: Overview of pending, active, and completed jobs
- **Inventory Management**: Manage parts stock and pricing
- **Profile & Reviews**: Showcase skills, ratings, and customer reviews
- **Earnings Tracking**: Monitor daily, weekly, and monthly earnings

### For Administrators
- **User Management**: Manage user accounts and permissions
- **Mechanic Verification**: Approve and verify mechanic credentials
- **Parts Catalog**: Manage marketplace inventory and pricing
- **Analytics & Reports**: Revenue tracking and performance metrics
- **System Monitoring**: Monitor app usage and performance

## 🏗️ Architecture

### Project Structure
```
lib/
├── core/
│   ├── constants/          # App constants and configurations
│   ├── models/            # Data models (User, Vehicle, Booking, etc.)
│   ├── services/          # Supabase and other services
│   ├── providers/         # Riverpod state management
│   ├── themes/            # App theming and styles
│   └── utils/             # Utilities and router configuration
├── features/
│   ├── auth/              # Authentication screens and logic
│   ├── user/              # User-specific features (14 screens)
│   ├── mechanic/          # Mechanic-specific features (4 screens)
│   ├── admin/             # Admin features (7 screens)
│   └── chat/              # Real-time messaging
└── shared/                # Shared widgets and screens
```

### Technology Stack
- **Frontend**: Flutter 3.x with Material 3 design
- **State Management**: Riverpod with code generation
- **Backend**: Supabase (Authentication, Database, Storage, Realtime)
- **Navigation**: GoRouter with named routes and guards
- **Maps**: flutter_map with OpenStreetMap
- **Authentication**: OTP-based phone/email verification

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.10.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Shehmeer669/mechkonnect_auto_service_hub.git
   cd mechkonnect_auto_service_hub
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code (if needed)**
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Configure Supabase**
   - Create a Supabase project at [supabase.com](https://supabase.com)
   - Update `lib/core/constants/supabase_config.dart` with your credentials:
   ```dart
   class SupabaseConfig {
     static const String url = 'YOUR_SUPABASE_URL';
     static const String anonKey = 'YOUR_SUPABASE_ANON_KEY';
   }
   ```

5. **Run the application**
   ```bash
   flutter run
   ```

## 📱 Screens Overview

### Authentication Flow (5 screens)
1. **Welcome Screen** - App introduction and navigation
2. **Login Screen** - Phone/email input with OTP
3. **OTP Verification** - 6-digit code verification
4. **Sign Up** - Role selection and basic information
5. **Complete Profile** - Photo upload and detailed info

### User Features (14 screens)
1. **User Home** - Dashboard with quick actions
2. **Book Mechanic** - Search mechanics with map/list view
3. **Mechanic Detail** - Mechanic profile and services
4. **Booking Confirmation** - Vehicle selection and scheduling
5. **Live Tracking** - Real-time service tracking
6. **Marketplace Home** - Parts categories and search
7. **Part Detail** - Part specifications and purchasing
8. **Cart** - Shopping cart management
9. **Payment** - Payment processing
10. **Profile** - User settings and information
11. **Vehicle Management** - Add/edit vehicles
12. **Vehicle Detail** - Vehicle-specific information
13. **Service History** - Past bookings and invoices
14. **Notifications** - App notifications and alerts

### Mechanic Features (4 screens)
1. **Mechanic Dashboard** - Job overview and stats
2. **Profile Setup** - Skills, rates, and availability
3. **Job Detail** - Accept/manage jobs
4. **Inventory Management** - Parts stock management

### Admin Features (7 screens)
1. **Admin Login** - Secure administrative access
2. **Admin Dashboard** - System overview and metrics
3. **User Management** - User accounts and permissions
4. **Mechanic Management** - Verification and approval
5. **Parts Management** - Catalog administration
6. **Booking Management** - Order monitoring
7. **Reports** - Analytics and performance metrics

### Shared Features (1 screen)
1. **Chat** - Real-time messaging between users

## 🔧 Key Features Implementation

### Authentication System
- OTP-based verification via phone/email
- Role-based access control (User/Mechanic/Admin)
- Secure session management with Supabase Auth

### Real-time Features
- Live location tracking during service
- Instant messaging with typing indicators
- Real-time booking status updates
- Push notifications

### Navigation & Routing
- GoRouter with named routes
- Role-based route guards
- Deep linking support
- Bottom navigation with role-specific items

### State Management
- Riverpod providers for app state
- Code generation for type safety
- Async state handling with proper loading/error states

### UI/UX Design
- Material 3 design system
- Dark/light theme support
- Responsive layouts for different screen sizes
- Smooth animations and transitions
- Accessibility features

## 🗄️ Database Schema

### Core Tables
- **users** - User profiles and roles
- **vehicles** - User vehicle information
- **bookings** - Service appointments and history
- **parts** - Marketplace inventory
- **chat_messages** - Real-time messaging
- **reviews** - User ratings and feedback

### Storage Buckets
- **profile-images** - User profile photos
- **vehicle-images** - Vehicle photos
- **part-images** - Part photos and documentation
- **chat-images** - Image attachments in chat

## 🧪 Testing

Run tests with:
```bash
flutter test
```

Run integration tests:
```bash
flutter drive --target=test_driver/app.dart
```

## 🚀 Deployment

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Support

For support, email support@mechkonnect.com or create an issue in this repository.

## 🙏 Acknowledgments

- Flutter team for the excellent framework
- Supabase for backend services
- OpenStreetMap for mapping services
- Material Design team for design guidelines

---

**Built with ❤️ using Flutter and Supabase**
