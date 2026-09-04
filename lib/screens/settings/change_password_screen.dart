import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class ChangePasswordScreen
    extends StatefulWidget {
  const ChangePasswordScreen({
    super.key,
  });

  @override
  State<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState
    extends State<ChangePasswordScreen> {
  final currentController =
  TextEditingController();

  final newController =
  TextEditingController();

  final confirmController =
  TextEditingController();

  bool currentHidden = true;
  bool newHidden = true;
  bool confirmHidden = true;

  @override
  void dispose() {
    currentController.dispose();
    newController.dispose();
    confirmController.dispose();

    super.dispose();
  }

  void changePassword() {
    if (currentController.text.isEmpty ||
        newController.text.isEmpty ||
        confirmController.text.isEmpty) {
      _showError(
        'Please complete all fields',
      );
      return;
    }

    if (newController.text !=
        confirmController.text) {
      _showError(
        'New passwords do not match',
      );
      return;
    }

    ScaffoldMessenger.of(context)
        .hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Password change ready for backend integration',
        ),
        backgroundColor: AppColors.navy,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context)
        .hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  22,
                  20,
                  30,
                ),
                child: Column(
                  children: [
                    _PasswordField(
                      title: 'Current Password',
                      controller: currentController,
                      obscure: currentHidden,
                      onToggle: () {
                        setState(() {
                          currentHidden =
                          !currentHidden;
                        });
                      },
                    ),

                    const SizedBox(height: 18),

                    _PasswordField(
                      title: 'New Password',
                      controller: newController,
                      obscure: newHidden,
                      onToggle: () {
                        setState(() {
                          newHidden = !newHidden;
                        });
                      },
                    ),

                    const SizedBox(height: 18),

                    _PasswordField(
                      title: 'Confirm New Password',
                      controller:
                      confirmController,
                      obscure: confirmHidden,
                      onToggle: () {
                        setState(() {
                          confirmHidden =
                          !confirmHidden;
                        });
                      },
                    ),

                    const SizedBox(height: 28),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: changePassword,
                        style:
                        ElevatedButton.styleFrom(
                          backgroundColor:
                          AppColors.orange,
                          foregroundColor:
                          Colors.white,
                          elevation: 0,
                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(
                              10,
                            ),
                          ),
                        ),
                        child: const Text(
                          'Update Password',
                          style: TextStyle(
                            fontWeight:
                            FontWeight.w700,
                          ),
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
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        10,
        10,
        20,
        5,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: AppColors.textPrimary,
            ),
          ),

          const Text(
            'Change Password',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final bool obscure;
  final VoidCallback onToggle;

  const _PasswordField({
    required this.title,
    required this.controller,
    required this.obscure,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 7),

        TextField(
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: 'Enter password',
            filled: true,
            fillColor: Colors.white,
            prefixIcon: const Icon(
              Icons.lock_outline_rounded,
              color: AppColors.navy,
              size: 19,
            ),
            suffixIcon: IconButton(
              onPressed: onToggle,
              icon: Icon(
                obscure
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                size: 18,
                color: AppColors.textSecondary,
              ),
            ),
            enabledBorder:
            OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.border,
              ),
            ),
            focusedBorder:
            OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.orange,
                width: 1.4,
              ),
            ),
          ),
        ),
      ],
    );
  }
}