import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() =>
      _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final nameController =
  TextEditingController(
    text: 'John Doe',
  );

  final emailController =
  TextEditingController(
    text: 'john.doe@email.com',
  );

  final phoneController =
  TextEditingController(
    text: '+1 234 567 8900',
  );

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();

    super.dispose();
  }

  void saveProfile() {
    FocusScope.of(context).unfocus();

    ScaffoldMessenger.of(context)
        .hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Profile changes saved',
        ),
        backgroundColor: AppColors.navy,
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
                  20,
                  20,
                  30,
                ),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 42,
                      backgroundColor:
                      Color(0xFFE9EEF7),
                      child: Icon(
                        Icons.person_rounded,
                        color: AppColors.navy,
                        size: 43,
                      ),
                    ),

                    const SizedBox(height: 10),

                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.camera_alt_outlined,
                        size: 16,
                      ),
                      label: const Text(
                        'Change Photo',
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor:
                        AppColors.orange,
                      ),
                    ),

                    const SizedBox(height: 22),

                    _ProfileField(
                      title: 'Full Name',
                      controller: nameController,
                      icon: Icons.person_outline_rounded,
                    ),

                    const SizedBox(height: 16),

                    _ProfileField(
                      title: 'Email Address',
                      controller: emailController,
                      icon: Icons.email_outlined,
                    ),

                    const SizedBox(height: 16),

                    _ProfileField(
                      title: 'Mobile Number',
                      controller: phoneController,
                      icon: Icons.phone_outlined,
                    ),

                    const SizedBox(height: 28),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: saveProfile,
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
                          'Save Changes',
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
            'Profile Information',
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

class _ProfileField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final IconData icon;

  const _ProfileField({
    required this.title,
    required this.controller,
    required this.icon,
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
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Icon(
              icon,
              color: AppColors.navy,
              size: 19,
            ),
            border: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(10),
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