import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../connectivity/connectivity_screen.dart';

enum ConnectionStatus {
  offline,
  slow,
  restored,
}

class ConnectivityScreen extends StatefulWidget {
  const ConnectivityScreen({super.key});

  @override
  State<ConnectivityScreen> createState() =>
      _ConnectivityScreenState();
}

class _ConnectivityScreenState extends State<ConnectivityScreen> {
  ConnectionStatus status = ConnectionStatus.offline;

  void setStatus(ConnectionStatus newStatus) {
    setState(() {
      status = newStatus;
    });
  }

  void retryConnection() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Checking connection...'),
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            20,
            28,
            20,
            30,
          ),
          child: Column(
            children: [
              _buildHeader(),

              const SizedBox(height: 30),

              _buildStatusCard(),

              const SizedBox(height: 26),

              _buildPreviewSwitcher(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
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

        const SizedBox(width: 4),

        const Text(
          'Internet Connection',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 21,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusCard() {
    switch (status) {
      case ConnectionStatus.offline:
        return _ConnectionCard(
          icon: Icons.cloud_off_rounded,
          iconColor: AppColors.navy,
          title: 'No Internet Connection',
          description:
          'You are not connected to the internet.\nPlease check your connection.',
          buttonText: 'Retry',
          onPressed: retryConnection,
        );

      case ConnectionStatus.slow:
        return _ConnectionCard(
          icon: Icons.wifi_rounded,
          iconColor: AppColors.navy,
          title: 'Slow Connection',
          description:
          'Your internet connection is slow.\nSome features may not work.',
          buttonText: 'Retry',
          onPressed: retryConnection,
        );

      case ConnectionStatus.restored:
        return _ConnectionCard(
          icon: Icons.check_circle_outline_rounded,
          iconColor: AppColors.success,
          title: 'Connection Restored',
          description:
          'You are back online.\nAll systems are ready.',
          showButton: false,
        );
    }
  }

  Widget _buildPreviewSwitcher() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Preview States',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        const SizedBox(height: 12),

        Row(
          children: [
            Expanded(
              child: _StatusButton(
                label: 'Offline',
                selected: status == ConnectionStatus.offline,
                onTap: () {
                  setStatus(ConnectionStatus.offline);
                },
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: _StatusButton(
                label: 'Slow',
                selected: status == ConnectionStatus.slow,
                onTap: () {
                  setStatus(ConnectionStatus.slow);
                },
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: _StatusButton(
                label: 'Restored',
                selected: status == ConnectionStatus.restored,
                onTap: () {
                  setStatus(ConnectionStatus.restored);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ConnectionCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;

  final String title;
  final String description;

  final String buttonText;
  final VoidCallback? onPressed;

  final bool showButton;

  const _ConnectionCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    this.buttonText = '',
    this.onPressed,
    this.showButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        24,
        30,
        24,
        28,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE2E7EF),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.025),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 38,
            ),
          ),

          const SizedBox(height: 20),

          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11,
              height: 1.6,
            ),
          ),

          if (showButton) ...[
            const SizedBox(height: 22),

            SizedBox(
              width: 180,
              height: 46,
              child: ElevatedButton.icon(
                onPressed: onPressed,
                icon: const Icon(
                  Icons.refresh_rounded,
                  size: 18,
                ),
                label: Text(
                  buttonText,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.orange,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _StatusButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _StatusButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(9),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected
              ? AppColors.navy
              : Colors.white,
          borderRadius: BorderRadius.circular(9),
          border: Border.all(
            color: selected
                ? AppColors.navy
                : AppColors.border,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected
                ? Colors.white
                : AppColors.textPrimary,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}