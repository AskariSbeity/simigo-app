// lib/screens/auth/otp_screen.dart

import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/custom_button.dart';
import '../dashboard/dashboard_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> controllers =
  List.generate(6, (_) => TextEditingController());

  final List<FocusNode> focusNodes =
  List.generate(6, (_) => FocusNode());

  int secondsRemaining = 30;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer?.cancel();

    secondsRemaining = 30;

    timer = Timer.periodic(
      const Duration(seconds: 1),
          (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }

        if (secondsRemaining <= 1) {
          setState(() {
            secondsRemaining = 0;
          });

          timer.cancel();
        } else {
          setState(() {
            secondsRemaining--;
          });
        }
      },
    );
  }

  void resendCode() {
    setState(() {
      secondsRemaining = 30;
    });

    startTimer();
  }

  String get timerText {
    final seconds = secondsRemaining.toString().padLeft(2, '0');
    return '00:$seconds';
  }

  @override
  void dispose() {
    timer?.cancel();

    for (final controller in controllers) {
      controller.dispose();
    }

    for (final node in focusNodes) {
      node.dispose();
    }

    super.dispose();
  }

  void verifyOtp() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const DashboardScreen(),
      ),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 28,
            vertical: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              Text(
                'Verify Mobile Number',
                style: AppTextStyles.heading,
              ),

              const SizedBox(height: 14),

              Text(
                'Enter the 6-digit code sent to',
                style: AppTextStyles.subheading,
              ),

              const SizedBox(height: 6),

              Text(
                '+1 234 567 8900',
                style: AppTextStyles.body.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 42),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  6,
                      (index) {
                    return SizedBox(
                      width: 48,
                      height: 54,
                      child: TextField(
                        controller: controllers[index],
                        focusNode: focusNodes[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                        decoration: InputDecoration(
                          counterText: '',
                          contentPadding: EdgeInsets.zero,
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: AppColors.border,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: AppColors.border,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: AppColors.orange,
                              width: 1.5,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 5) {
                            FocusScope.of(context).requestFocus(
                              focusNodes[index + 1],
                            );
                          }

                          if (value.isEmpty && index > 0) {
                            FocusScope.of(context).requestFocus(
                              focusNodes[index - 1],
                            );
                          }
                        },
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 50),

              Center(
                child: secondsRemaining > 0
                    ? Text(
                  'Resend code in $timerText',
                  style: AppTextStyles.subheading.copyWith(
                    fontSize: 12,
                  ),
                )
                    : InkWell(
                  onTap: resendCode,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      'Resend Code',
                      style: AppTextStyles.link,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              CustomButton(
                text: 'Verify & Continue',
                onPressed: verifyOtp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}