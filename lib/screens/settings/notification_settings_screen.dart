import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class NotificationSettingsScreen
    extends StatefulWidget {
  const NotificationSettingsScreen({
    super.key,
  });

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool transactionAlerts = true;
  bool paymentAlerts = true;
  bool securityAlerts = true;
  bool offers = false;
  bool emailNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  18,
                  20,
                  30,
                ),
                children: [
                  _NotificationItem(
                    icon:
                    Icons.receipt_long_outlined,
                    title:
                    'Transaction Alerts',
                    subtitle:
                    'Money sent and received',
                    value: transactionAlerts,
                    onChanged: (value) {
                      setState(() {
                        transactionAlerts =
                            value;
                      });
                    },
                  ),

                  const SizedBox(height: 10),

                  _NotificationItem(
                    icon:
                    Icons.payment_rounded,
                    title:
                    'Payment Alerts',
                    subtitle:
                    'Card and wallet payment updates',
                    value: paymentAlerts,
                    onChanged: (value) {
                      setState(() {
                        paymentAlerts = value;
                      });
                    },
                  ),

                  const SizedBox(height: 10),

                  _NotificationItem(
                    icon:
                    Icons.security_rounded,
                    title:
                    'Security Alerts',
                    subtitle:
                    'Login and account security activity',
                    value: securityAlerts,
                    onChanged: (value) {
                      setState(() {
                        securityAlerts = value;
                      });
                    },
                  ),

                  const SizedBox(height: 10),

                  _NotificationItem(
                    icon:
                    Icons.local_offer_outlined,
                    title:
                    'Offers & Promotions',
                    subtitle:
                    'Deals and wallet offers',
                    value: offers,
                    onChanged: (value) {
                      setState(() {
                        offers = value;
                      });
                    },
                  ),

                  const SizedBox(height: 10),

                  _NotificationItem(
                    icon:
                    Icons.email_outlined,
                    title:
                    'Email Notifications',
                    subtitle:
                    'Receive wallet updates by email',
                    value:
                    emailNotifications,
                    onChanged: (value) {
                      setState(() {
                        emailNotifications =
                            value;
                      });
                    },
                  ),
                ],
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
            'Notification Settings',
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

class _NotificationItem
    extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;

  final ValueChanged<bool>
  onChanged;

  const _NotificationItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: const Color(0xFFE4E9F1),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 39,
            height: 39,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F6FA),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: AppColors.navy,
              size: 19,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),

          Switch(
            value: value,
            activeColor: Colors.white,
            activeTrackColor:
            AppColors.orange,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}