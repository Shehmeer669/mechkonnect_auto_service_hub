import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  
  bool _usePhone = false;
  PhoneNumber _phoneNumber = PhoneNumber(isoCode: 'US');

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
                  'Welcome Back!',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: AppDimensions.marginS),
                
                Text(
                  'Enter your email or phone number to receive an OTP',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                
                const SizedBox(height: AppDimensions.marginXL),
                
                // Toggle between email and phone
                Row(
                  children: [
                    Expanded(
                      child: _buildToggleButton(
                        'Email',
                        Icons.email,
                        !_usePhone,
                        () => setState(() => _usePhone = false),
                      ),
                    ),
                    const SizedBox(width: AppDimensions.marginM),
                    Expanded(
                      child: _buildToggleButton(
                        'Phone',
                        Icons.phone,
                        _usePhone,
                        () => setState(() => _usePhone = true),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: AppDimensions.marginL),
                
                // Input field
                if (_usePhone) _buildPhoneInput() else _buildEmailInput(),
                
                const SizedBox(height: AppDimensions.marginXL),
                
                // Send OTP Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: authState.isLoading ? null : _sendOtp,
                    child: authState.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Send OTP'),
                  ),
                ),
                
                const SizedBox(height: AppDimensions.marginL),
                
                // Sign up link
                Center(
                  child: TextButton(
                    onPressed: () => context.pushReplacementNamed('signup'),
                    child: const Text('Don\'t have an account? Sign Up'),
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

  Widget _buildToggleButton(
    String text,
    IconData icon,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppDimensions.paddingM,
          horizontal: AppDimensions.paddingS,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey,
              size: AppDimensions.iconS,
            ),
            const SizedBox(width: AppDimensions.marginS),
            Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailInput() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: 'Email Address',
        prefixIcon: Icon(Icons.email),
        hintText: 'Enter your email address',
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
    );
  }

  Widget _buildPhoneInput() {
    return InternationalPhoneNumberInput(
      onInputChanged: (PhoneNumber number) {
        _phoneNumber = number;
      },
      onInputValidated: (bool value) {},
      selectorConfig: const SelectorConfig(
        selectorType: PhoneInputSelectorType.DROPDOWN,
        showFlags: true,
        useEmoji: true,
      ),
      ignoreBlank: false,
      autoValidateMode: AutovalidateMode.disabled,
      selectorTextStyle: const TextStyle(color: Colors.black),
      textFieldController: _phoneController,
      formatInput: true,
      keyboardType: const TextInputType.numberWithOptions(
        signed: true,
        decimal: true,
      ),
      inputBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your phone number';
        }
        return null;
      },
    );
  }

  void _sendOtp() {
    if (!_formKey.currentState!.validate()) return;

    if (_usePhone) {
      ref.read(authNotifierProvider.notifier).signInWithOtp(
        phone: _phoneNumber.phoneNumber,
      );
      
      context.pushNamed(
        'otp',
        extra: {'phone': _phoneNumber.phoneNumber},
      );
    } else {
      ref.read(authNotifierProvider.notifier).signInWithOtp(
        email: _emailController.text.trim(),
      );
      
      context.pushNamed(
        'otp',
        extra: {'email': _emailController.text.trim()},
      );
    }
  }
}