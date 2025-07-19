import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/models/user_model.dart';
import '../../../core/providers/auth_provider.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  
  UserRole _selectedRole = UserRole.user;

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingL),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppDimensions.marginL),
                
                Text(
                  'Create Account',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: AppDimensions.marginS),
                
                Text(
                  'Join MechKonnect and get started',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                
                const SizedBox(height: AppDimensions.marginXL),
                
                // Role Selection
                Text(
                  'I am a:',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                
                const SizedBox(height: AppDimensions.marginM),
                
                Row(
                  children: [
                    Expanded(
                      child: _buildRoleCard(
                        UserRole.user,
                        'Vehicle Owner',
                        'Find mechanics and buy parts',
                        Icons.person,
                        AppColors.userRole,
                      ),
                    ),
                    const SizedBox(width: AppDimensions.marginM),
                    Expanded(
                      child: _buildRoleCard(
                        UserRole.mechanic,
                        'Mechanic',
                        'Provide services and sell parts',
                        Icons.build,
                        AppColors.mechanicRole,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: AppDimensions.marginL),
                
                // First Name
                TextFormField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: AppDimensions.marginM),
                
                // Last Name
                TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: AppDimensions.marginM),
                
                // Email
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email address';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                
                const Spacer(),
                
                // Continue Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: authState.isLoading ? null : _signUp,
                    child: authState.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Continue'),
                  ),
                ),
                
                const SizedBox(height: AppDimensions.marginM),
                
                // Login link
                Center(
                  child: TextButton(
                    onPressed: () => context.pushReplacementNamed('login'),
                    child: const Text('Already have an account? Login'),
                  ),
                ),
                
                // Error message
                if (authState.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: AppDimensions.marginM),
                    child: Container(
                      padding: const EdgeInsets.all(AppDimensions.paddingM),
                      decoration: BoxDecoration(
                        color: AppColors.error.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.error,
                            color: AppColors.error,
                            size: AppDimensions.iconS,
                          ),
                          const SizedBox(width: AppDimensions.marginS),
                          Expanded(
                            child: Text(
                              authState.error.toString(),
                              style: TextStyle(
                                color: AppColors.error,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard(
    UserRole role,
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    final isSelected = _selectedRole == role;
    
    return GestureDetector(
      onTap: () => setState(() => _selectedRole = role),
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          border: Border.all(
            color: isSelected ? color : Colors.grey,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: isSelected ? color : Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : Colors.grey,
                size: AppDimensions.iconM,
              ),
            ),
            const SizedBox(height: AppDimensions.marginS),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: isSelected ? color : null,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.marginXS),
            Text(
              description,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _signUp() {
    if (!_formKey.currentState!.validate()) return;

    // For demo purposes, we'll go directly to OTP verification
    // In a real app, you'd sign up the user first
    context.pushNamed(
      'otp',
      extra: {
        'email': _emailController.text.trim(),
        'isSignUp': true,
        'role': _selectedRole,
        'firstName': _firstNameController.text.trim(),
        'lastName': _lastNameController.text.trim(),
      },
    );
  }
}