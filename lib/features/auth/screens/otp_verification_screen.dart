import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:async';

import '../../../core/constants/app_constants.dart';
import '../../../core/providers/auth_provider.dart';

class OtpVerificationScreen extends ConsumerStatefulWidget {
  final String? email;
  final String? phone;

  const OtpVerificationScreen({
    super.key,
    this.email,
    this.phone,
  });

  @override
  ConsumerState<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends ConsumerState<OtpVerificationScreen> {
  final _otpController = TextEditingController();
  Timer? _timer;
  int _secondsRemaining = 60;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _otpController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _secondsRemaining = 60;
    _canResend = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        setState(() {
          _canResend = true;
        });
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify OTP'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: AppDimensions.marginXL),
              
              // Icon
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
                ),
                child: const Icon(
                  Icons.message,
                  size: 40,
                  color: AppColors.primary,
                ),
              ),
              
              const SizedBox(height: AppDimensions.marginL),
              
              Text(
                'Verify Your ${widget.phone != null ? 'Phone' : 'Email'}',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: AppDimensions.marginM),
              
              Text(
                'We sent a 6-digit code to\n${widget.phone ?? widget.email}',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: AppDimensions.marginXL),
              
              // OTP Input
              Pinput(
                controller: _otpController,
                length: 6,
                defaultPinTheme: _defaultPinTheme,
                focusedPinTheme: _focusedPinTheme,
                submittedPinTheme: _submittedPinTheme,
                showCursor: true,
                onCompleted: _verifyOtp,
              ),
              
              const SizedBox(height: AppDimensions.marginXL),
              
              // Verify Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: authState.isLoading || _otpController.text.length != 6
                      ? null
                      : _verifyOtp,
                  child: authState.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Verify'),
                ),
              ),
              
              const SizedBox(height: AppDimensions.marginL),
              
              // Timer and Resend
              if (!_canResend)
                Text(
                  'Resend code in ${_secondsRemaining}s',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                )
              else
                TextButton(
                  onPressed: _resendOtp,
                  child: const Text('Resend Code'),
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
    );
  }

  PinTheme get _defaultPinTheme => PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(AppDimensions.radiusM),
    ),
  );

  PinTheme get _focusedPinTheme => _defaultPinTheme.copyDecorationWith(
    border: Border.all(color: AppColors.primary, width: 2),
  );

  PinTheme get _submittedPinTheme => _defaultPinTheme.copyWith(
    decoration: _defaultPinTheme.decoration?.copyWith(
      color: AppColors.primary.withOpacity(0.1),
      border: Border.all(color: AppColors.primary),
    ),
  );

  void _verifyOtp([String? otp]) {
    final code = otp ?? _otpController.text;
    if (code.length != 6) return;

    ref.read(authNotifierProvider.notifier).verifyOtp(
      token: code,
      type: widget.phone != null ? OtpType.sms : OtpType.email,
      email: widget.email,
      phone: widget.phone,
    );
  }

  void _resendOtp() {
    ref.read(authNotifierProvider.notifier).signInWithOtp(
      email: widget.email,
      phone: widget.phone,
    );
    _startTimer();
  }
}