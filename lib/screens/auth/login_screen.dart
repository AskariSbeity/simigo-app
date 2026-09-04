// lib/screens/auth/login_screen.dart

import 'package:flutter/material.dart';

import '../dashboard/dashboard_screen.dart';
import 'signup_screen.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void goToSignup() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const SignupScreen(),
      ),
    );
  }

  void goToDashboard() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const DashboardScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 70),

                Text(
                  'Welcome Back!',
                  style: AppTextStyles.heading,
                ),

                const SizedBox(height: 8),

                Text(
                  'Login to continue',
                  style: AppTextStyles.subheading,
                ),

                const SizedBox(height: 40),

                CustomTextField(
                  label: 'Email / Mobile Number',
                  hint: 'Enter your email or mobile',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 22),

                CustomTextField(
                  label: 'Password',
                  hint: 'Enter your password',
                  controller: passwordController,
                  isPassword: true,
                ),

                const SizedBox(height: 10),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(
                      'Forgot Password?',
                      style: AppTextStyles.link.copyWith(
                        color: AppColors.navy,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                CustomButton(
                  text: 'Login',
                  onPressed: goToDashboard,
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

                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _SocialButton(
                      child: const Text(
                        'G',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w700,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    const SizedBox(width: 28),
                    _SocialButton(
                      child: const Text(
                        'f',
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1877F2),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 35),

                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: AppTextStyles.subheading.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      InkWell(
                        onTap: goToSignup,
                        borderRadius: BorderRadius.circular(6),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 3,
                            vertical: 8,
                          ),
                          child: Text(
                            'Sign Up',
                            style: AppTextStyles.link,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 35),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final Widget child;

  const _SocialButton({
    required this.child,
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
      child: child,
    );
  }
}