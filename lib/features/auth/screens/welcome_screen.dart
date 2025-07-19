import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingL),
          child: Column(
            children: [
              const Spacer(),
              
              // Logo
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
                ),
                child: const Icon(
                  Icons.build,
                  size: 60,
                  color: Colors.white,
                ),
              ),
              
              const SizedBox(height: AppDimensions.marginL),
              
              // App Name
              Text(
                AppStrings.appName,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: AppDimensions.marginS),
              
              // Tagline
              Text(
                AppStrings.appTagline,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: AppDimensions.marginXL),
              
              // Features
              _buildFeature(
                context,
                Icons.handyman,
                'Expert Mechanics',
                'Connect with certified mechanics in your area',
              ),
              
              const SizedBox(height: AppDimensions.marginM),
              
              _buildFeature(
                context,
                Icons.location_on,
                'Doorstep Service',
                'Get your vehicle serviced at your location',
              ),
              
              const SizedBox(height: AppDimensions.marginM),
              
              _buildFeature(
                context,
                Icons.shopping_cart,
                'Parts Marketplace',
                'Buy genuine auto parts at competitive prices',
              ),
              
              const Spacer(),
              
              // Login Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.pushNamed('login'),
                  child: const Text(AppStrings.login),
                ),
              ),
              
              const SizedBox(height: AppDimensions.marginM),
              
              // Sign Up Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => context.pushNamed('signup'),
                  child: const Text(AppStrings.signup),
                ),
              ),
              
              const SizedBox(height: AppDimensions.marginL),
              
              // Admin Login
              TextButton(
                onPressed: () => context.pushNamed('admin-login'),
                child: const Text('Admin Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeature(
    BuildContext context,
    IconData icon,
    String title,
    String description,
  ) {
    return Row(
      children: [
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: AppColors.secondary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          ),
          child: Icon(
            icon,
            color: AppColors.secondary,
            size: AppDimensions.iconM,
          ),
        ),
        const SizedBox(width: AppDimensions.marginM),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}