import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../connectivity/connectivity_screen.dart';
import '../settings/settings_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  void _showComingSoon(
      BuildContext context,
      String title,
      ) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$title will be added next'),
        backgroundColor: AppColors.navy,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
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
            _buildHeader(context),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(
                  20,
                  16,
                  20,
                  30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'More Services',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 14),

                    _MoreItem(
                      icon: Icons.settings_outlined,
                      title: 'Settings',
                      subtitle:
                      'Profile, security, language and preferences',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                            const SettingsScreen(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 10),

                    _MoreItem(
                      icon: Icons.wifi_rounded,
                      title: 'Internet Connection',
                      subtitle:
                      'View connection and network states',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                            const ConnectivityScreen(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 10),

                    _MoreItem(
                      icon: Icons.person_add_alt_1_outlined,
                      title: 'Beneficiaries',
                      subtitle:
                      'Manage people you send money to',
                      onTap: () {
                        _showComingSoon(
                          context,
                          'Beneficiaries',
                        );
                      },
                    ),

                    const SizedBox(height: 10),

                    _MoreItem(
                      icon: Icons.qr_code_rounded,
                      title: 'My QR Code',
                      subtitle:
                      'Receive money using your personal QR',
                      onTap: () {
                        _showComingSoon(
                          context,
                          'My QR Code',
                        );
                      },
                    ),

                    const SizedBox(height: 10),

                    _MoreItem(
                      icon: Icons.help_outline_rounded,
                      title: 'Help Center',
                      subtitle:
                      'Get help with wallet and payments',
                      onTap: () {
                        _showComingSoon(
                          context,
                          'Help Center',
                        );
                      },
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

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        10,
        10,
        20,
        6,
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

          const SizedBox(width: 3),

          const Text(
            'More',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 21,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _MoreItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _MoreItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(13),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(13),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            border: Border.all(
              color: const Color(0xFFE4E9F1),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F5F9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: AppColors.navy,
                  size: 21,
                ),
              ),

              const SizedBox(width: 13),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 9.5,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFF98A2B3),
                size: 21,
              ),
            ],
          ),
        ),
      ),
    );
  }
}