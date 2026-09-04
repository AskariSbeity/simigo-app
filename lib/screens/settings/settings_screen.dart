import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../auth/login_screen.dart';
import 'change_password_screen.dart';
import 'notification_settings_screen.dart';
import 'profile_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() =>
      _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String language = 'English';

  void _showComingSoon(String title) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$title will be added later'),
        backgroundColor: AppColors.navy,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _showLanguageSelector() async {
    final value = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(22),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              18,
              20,
              22,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select Language',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 16),

                _LanguageItem(
                  title: 'English',
                  selected: language == 'English',
                  onTap: () {
                    Navigator.pop(
                      context,
                      'English',
                    );
                  },
                ),

                const SizedBox(height: 8),

                _LanguageItem(
                  title: 'Arabic',
                  selected: language == 'Arabic',
                  onTap: () {
                    Navigator.pop(
                      context,
                      'Arabic',
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );

    if (value != null) {
      setState(() {
        language = value;
      });
    }
  }

  Future<void> _showLogoutDialog() async {
    final shouldLogout =
    await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.fromLTRB(
              22,
              24,
              22,
              20,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFF0E8),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.logout_rounded,
                    color: AppColors.orange,
                    size: 27,
                  ),
                ),

                const SizedBox(height: 17),

                const Text(
                  'Logout?',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Are you sure you want to logout from your wallet?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 22),

                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 47,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(
                              dialogContext,
                              false,
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor:
                            AppColors.textPrimary,
                            side: const BorderSide(
                              color: AppColors.border,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(
                                9,
                              ),
                            ),
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              fontWeight:
                              FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: SizedBox(
                        height: 47,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(
                              dialogContext,
                              true,
                            );
                          },
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
                                9,
                              ),
                            ),
                          ),
                          child: const Text(
                            'Logout',
                            style: TextStyle(
                              fontWeight:
                              FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    if (shouldLogout != true || !mounted) {
      return;
    }

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
          (route) => false,
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
                physics:
                const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(
                  20,
                  14,
                  20,
                  30,
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    _buildProfileCard(),

                    const SizedBox(height: 26),

                    const _SectionTitle(
                      title: 'Account',
                    ),

                    const SizedBox(height: 10),

                    _SettingsContainer(
                      children: [
                        _SettingsItem(
                          icon:
                          Icons.person_outline_rounded,
                          title:
                          'Profile Information',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                const ProfileScreen(),
                              ),
                            );
                          },
                        ),

                        const _SettingsDivider(),

                        _SettingsItem(
                          icon:
                          Icons.lock_outline_rounded,
                          title:
                          'Change Password',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                const ChangePasswordScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    const _SectionTitle(
                      title: 'Preferences',
                    ),

                    const SizedBox(height: 10),

                    _SettingsContainer(
                      children: [
                        _SettingsItem(
                          icon: Icons
                              .notifications_none_rounded,
                          title:
                          'Notification Settings',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                const NotificationSettingsScreen(),
                              ),
                            );
                          },
                        ),

                        const _SettingsDivider(),

                        _SettingsItem(
                          icon:
                          Icons.security_rounded,
                          title: 'Security',
                          onTap: () {
                            _showComingSoon(
                              'Security',
                            );
                          },
                        ),

                        const _SettingsDivider(),

                        _SettingsItem(
                          icon:
                          Icons.language_rounded,
                          title: 'Language',
                          trailingText: language,
                          onTap:
                          _showLanguageSelector,
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    const _SectionTitle(
                      title: 'Support',
                    ),

                    const SizedBox(height: 10),

                    _SettingsContainer(
                      children: [
                        _SettingsItem(
                          icon:
                          Icons.help_outline_rounded,
                          title:
                          'Help & Support',
                          onTap: () {
                            _showComingSoon(
                              'Help & Support',
                            );
                          },
                        ),

                        const _SettingsDivider(),

                        _SettingsItem(
                          icon:
                          Icons.info_outline_rounded,
                          title: 'About Us',
                          onTap: () {
                            _showComingSoon(
                              'About Us',
                            );
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 26),

                    _buildLogoutButton(),

                    const SizedBox(height: 16),

                    const Center(
                      child: Text(
                        'Wallet App v1.0.0',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 9,
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

          const SizedBox(width: 3),

          const Text(
            'Settings',
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

  Widget _buildProfileCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: AppColors.navy,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        children: [
          CircleAvatar(
            radius: 27,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.person_rounded,
              color: AppColors.navy,
              size: 29,
            ),
          ),

          SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  'John Doe',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                SizedBox(height: 4),

                Text(
                  'john.doe@email.com',
                  style: TextStyle(
                    color: Color(0xFFD7E1F0),
                    fontSize: 9.5,
                  ),
                ),
              ],
            ),
          ),

          Icon(
            Icons.verified_rounded,
            color: AppColors.orange,
            size: 22,
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton.icon(
        onPressed: _showLogoutDialog,
        icon: const Icon(
          Icons.logout_rounded,
          size: 19,
        ),
        label: const Text(
          'Logout',
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w700,
          ),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.error,
          side: const BorderSide(
            color: AppColors.error,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.textSecondary,
        fontSize: 10,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _SettingsContainer extends StatelessWidget {
  final List<Widget> children;

  const _SettingsContainer({
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: const Color(0xFFE4E9F1),
        ),
      ),
      child: Column(
        children: children,
      ),
    );
  }
}

class _SettingsDivider extends StatelessWidget {
  const _SettingsDivider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 60),
      child: Divider(
        height: 1,
        color: Color(0xFFF0F2F6),
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? trailingText;
  final VoidCallback onTap;

  const _SettingsItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.trailingText,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F6FA),
                borderRadius: BorderRadius.circular(9),
              ),
              child: Icon(
                icon,
                color: AppColors.navy,
                size: 18,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            if (trailingText != null) ...[
              Text(
                trailingText!,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 9.5,
                ),
              ),
              const SizedBox(width: 6),
            ],

            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF98A2B3),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageItem extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const _LanguageItem({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFFFF7F1)
              : const Color(0xFFF8FAFD),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected
                ? AppColors.orange
                : AppColors.border,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            if (selected)
              const Icon(
                Icons.check_circle_rounded,
                color: AppColors.orange,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}