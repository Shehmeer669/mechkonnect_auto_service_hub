import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';
import '../services/supabase_service.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  AsyncValue<UserModel?> build() {
    _initializeAuth();
    return const AsyncValue.loading();
  }

  void _initializeAuth() {
    SupabaseService.client.auth.onAuthStateChange.listen((data) {
      final session = data.session;
      if (session != null) {
        _loadUserProfile(session.user.id);
      } else {
        state = const AsyncValue.data(null);
      }
    });
  }

  Future<void> _loadUserProfile(String userId) async {
    try {
      final user = await SupabaseService.getUserProfile(userId);
      state = AsyncValue.data(user);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> signInWithOtp({
    String? email,
    String? phone,
  }) async {
    state = const AsyncValue.loading();
    try {
      await SupabaseService.signInWithOtp(email: email ?? '', phone: phone);
      // User profile will be loaded automatically via auth state listener
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> verifyOtp({
    required String token,
    required OtpType type,
    String? email,
    String? phone,
  }) async {
    state = const AsyncValue.loading();
    try {
      final response = await SupabaseService.verifyOtp(
        token: token,
        type: type,
        email: email,
        phone: phone,
      );
      
      if (response.user != null) {
        await _loadUserProfile(response.user!.id);
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> signUp({
    required String email,
    String? phone,
    required UserRole role,
    String? firstName,
    String? lastName,
  }) async {
    state = const AsyncValue.loading();
    try {
      final authUser = SupabaseService.currentUser;
      if (authUser != null) {
        final user = UserModel(
          id: authUser.id,
          email: email,
          phone: phone,
          firstName: firstName,
          lastName: lastName,
          role: role,
          isActive: true,
          isVerified: false,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        
        final createdUser = await SupabaseService.createUserProfile(user);
        state = AsyncValue.data(createdUser);
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> updateProfile(UserModel user) async {
    state = const AsyncValue.loading();
    try {
      final updatedUser = await SupabaseService.updateUserProfile(user);
      state = AsyncValue.data(updatedUser);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    try {
      await SupabaseService.signOut();
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

@riverpod
bool isAuthenticated(IsAuthenticatedRef ref) {
  final authState = ref.watch(authNotifierProvider);
  return authState.maybeWhen(
    data: (user) => user != null,
    orElse: () => false,
  );
}

@riverpod
UserRole? userRole(UserRoleRef ref) {
  final authState = ref.watch(authNotifierProvider);
  return authState.maybeWhen(
    data: (user) => user?.role,
    orElse: () => null,
  );
}

@riverpod
class ThemeModeNotifier extends _$ThemeModeNotifier {
  @override
  ThemeMode build() {
    _loadThemeMode();
    return ThemeMode.system;
  }

  void _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeIndex = prefs.getInt('theme_mode') ?? 0;
    state = ThemeMode.values[themeModeIndex];
  }

  void setThemeMode(ThemeMode mode) async {
    state = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('theme_mode', mode.index);
  }

  void toggleTheme() {
    final newMode = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    setThemeMode(newMode);
  }
}

@riverpod
ThemeMode themeMode(ThemeModeRef ref) {
  return ref.watch(themeModeNotifierProvider);
}