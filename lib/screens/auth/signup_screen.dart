// lib/screens/auth/signup_screen.dart

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_field.dart';
import 'otp_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool agreed = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void goToOtp() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const OtpScreen(),
      ),
    );
  }

  void goBackToLogin() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 28,
            vertical: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 18),

              Text(
                'Create Account',
                style: AppTextStyles.heading,
              ),

              const SizedBox(height: 8),

              Text(
                'Sign up to get started',
                style: AppTextStyles.subheading,
              ),

              const SizedBox(height: 34),

              CustomTextField(
                label: 'Full Name',
                hint: 'Enter your full name',
                controller: nameController,
              ),

              const SizedBox(height: 20),

              CustomTextField(
                label: 'Email / Mobile Number',
                hint: 'Enter your email or mobile',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 20),

              CustomTextField(
                label: 'Password',
                hint: 'Create a password',
                controller: passwordController,
                isPassword: true,
              ),

              const SizedBox(height: 14),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 22,
                    height: 22,
                    child: Checkbox(
                      value: agreed,
                      activeColor: AppColors.orange,
                      side: const BorderSide(
                        color: AppColors.border,
                      ),
                      onChanged: (value) {
                        setState(() {
                          agreed = value ?? false;
                        });
                      },
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Wrap(
                      children: [
                        Text(
                          'I agree to the ',
                          style: AppTextStyles.subheading.copyWith(
                            fontSize: 12,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            'Terms & Conditions',
                            style: AppTextStyles.link.copyWith(
                              fontSize: 12,
                              color: AppColors.navy,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 26),

              CustomButton(
                text: 'Sign Up',
                onPressed: goToOtp,
              ),

              const SizedBox(height: 28),

              Row(
                children: [
                  const Expanded(
                    child: Divider(
                      color: AppColors.border,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                    ),
                    child: Text(
                      'or continue with',
                      style: AppTextStyles.subheading.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Divider(
                      color: AppColors.border,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  _SocialButton(
                    text: 'G',
                    color: Colors.blue,
                  ),
                  SizedBox(width: 28),
                  _SocialButton(
                    text: 'f',
                    color: Color(0xFF1877F2),
                  ),
                ],
              ),

              const SizedBox(height: 36),

              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: AppTextStyles.subheading.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    InkWell(
                      onTap: goBackToLogin,
                      borderRadius: BorderRadius.circular(6),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 3,
                          vertical: 8,
                        ),
                        child: Text(
                          'Login',
                          style: AppTextStyles.link,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String text;
  final Color color;

  const _SocialButton({
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          fontSize: text == 'f' ? 27 : 23,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}