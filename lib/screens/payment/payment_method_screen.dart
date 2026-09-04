import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'blue_payment_screen.dart';
import 'card_payment_screen.dart';
import 'paypal_payment_screen.dart';

class PaymentMethodScreen extends StatefulWidget {
  final double amount;
  final String initialMethod;

  const PaymentMethodScreen({
    super.key,
    required this.amount,
    required this.initialMethod,
  });

  @override
  State<PaymentMethodScreen> createState() =>
      _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  late String selectedMethod;

  @override
  void initState() {
    super.initState();

    selectedMethod = _mapInitialMethod(widget.initialMethod);
  }

  String _mapInitialMethod(String method) {
    switch (method) {
      case 'paypal':
        return 'paypal';

      case 'card':
        return 'card';

      case 'bank':
        return 'blue';

    // UDT is disabled, so UPI cannot initially select it.
      case 'upi':
        return 'paypal';

      default:
        return 'paypal';
    }
  }

  void selectMethod(String value) {
    setState(() {
      selectedMethod = value;
    });
  }

  String get selectedMethodName {
    switch (selectedMethod) {
      case 'paypal':
        return 'PayPal';

      case 'card':
        return 'Card Payment';

      case 'blue':
        return 'Blue';

      default:
        return 'Payment Method';
    }
  }

  void continueSecurely() {
    switch (selectedMethod) {
      case 'card':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CardPaymentScreen(
              amount: widget.amount,
            ),
          ),
        );
        return;

      case 'paypal':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PaypalPaymentScreen(
              amount: widget.amount,
            ),
          ),
        );
        return;

      case 'blue':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BluePaymentScreen(
              amount: widget.amount,
            ),
          ),
        );
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: SafeArea(
        child: Column(
          children: [
            _buildSecureHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(
                  16,
                  14,
                  16,
                  22,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPageTitle(),
                    const SizedBox(height: 12),
                    _buildOrderSummary(),
                    const SizedBox(height: 14),
                    _buildPaymentGrid(),
                    const SizedBox(height: 16),
                    _buildContinueButton(),
                    const SizedBox(height: 12),
                    _buildSecurityFooter(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildSecureHeader() {
    return Container(
      width: double.infinity,
      color: AppColors.navy,
      padding: const EdgeInsets.fromLTRB(
        8,
        8,
        14,
        10,
      ),
      child: Row(
        children: [
          IconButton(
            constraints: const BoxConstraints(
              minWidth: 36,
              minHeight: 36,
            ),
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 21,
            ),
          ),
          const SizedBox(width: 4),
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.orange,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.lock_rounded,
              color: Colors.white,
              size: 19,
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Secure Payment',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Trusted & Encrypted',
                  style: TextStyle(
                    color: Color(0xFFD7E1F0),
                    fontSize: 8.5,
                  ),
                ),
              ],
            ),
          ),
          const _SecurityMiniItem(
            icon: Icons.lock_outline_rounded,
            title: 'SSL Secured',
          ),
          const SizedBox(width: 9),
          const _SecurityMiniItem(
            icon: Icons.verified_user_outlined,
            title: 'PCI Compliant',
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PAGE TITLE
  // ============================================================

  Widget _buildPageTitle() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFFFF0E7),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.credit_card_rounded,
            color: AppColors.orange,
            size: 21,
          ),
        ),
        const SizedBox(width: 11),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Choose Your Payment Method',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 15.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 3),
              Text(
                'Select a secure and convenient way to complete your payment',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 9.5,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // ORDER SUMMARY
  // ============================================================

  Widget _buildOrderSummary() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(
          color: const Color(0xFFE2E7EF),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Amount to Pay',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 9,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${widget.amount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: AppColors.orange,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 1,
            height: 34,
            color: const Color(0xFFE8ECF2),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order ID',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 9,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'ADD-MONEY-001',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PAYMENT GRID
  // ============================================================

  Widget _buildPaymentGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        const gap = 10.0;

        final itemWidth =
            (constraints.maxWidth - gap) / 2;

        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            // PAYPAL - ENABLED
            SizedBox(
              width: itemWidth,
              child: _GatewayCard(
                value: 'paypal',
                selectedValue: selectedMethod,
                enabled: true,
                title: 'PayPal',
                subtitle: 'Pay with PayPal wallet or linked card',
                icon: Icons.paypal_rounded,
                iconColor: const Color(0xFF0070BA),
                features: const [
                  'Fast mobile checkout',
                  'Buyer protection',
                  'No card entry',
                ],
                onTap: () {
                  selectMethod('paypal');
                },
              ),
            ),

            // CARD - ENABLED
            SizedBox(
              width: itemWidth,
              child: _GatewayCard(
                value: 'card',
                selectedValue: selectedMethod,
                enabled: true,
                title: 'Card Payment',
                subtitle: 'Pay with saved card or add a new card',
                icon: Icons.credit_card_rounded,
                iconColor: AppColors.navy,
                features: const [
                  'Save cards',
                  'Tokenized security',
                  'Wallet top-up support',
                ],
                onTap: () {
                  selectMethod('card');
                },
              ),
            ),

            // UDT - DISABLED
            SizedBox(
              width: itemWidth,
              child: _GatewayCard(
                value: 'udt',
                selectedValue: selectedMethod,
                enabled: false,
                title: 'UDT',
                subtitle: 'Pay instantly using your UDT account',
                logoText: 'UDT',
                iconColor: const Color(0xFF155FD1),
                features: const [
                  'Instant transfer',
                  'Secure & verified',
                  'Real-time confirmation',
                ],
                onTap: () {},
              ),
            ),

            // BLUE - ENABLED
            SizedBox(
              width: itemWidth,
              child: _GatewayCard(
                value: 'blue',
                selectedValue: selectedMethod,
                enabled: true,
                title: 'Blue',
                subtitle: 'Pay securely with your Blue account',
                logoText: 'blue',
                iconColor: const Color(0xFF1465D8),
                features: const [
                  'Quick checkout',
                  'Secure payment',
                  'Trusted by thousands',
                ],
                onTap: () {
                  selectMethod('blue');
                },
              ),
            ),

            // WHISH - DISABLED
            SizedBox(
              width: itemWidth,
              child: _GatewayCard(
                value: 'whish',
                selectedValue: selectedMethod,
                enabled: false,
                title: 'Whish',
                subtitle: 'Pay easily using your Whish wallet',
                logoText: 'whish',
                iconColor: const Color(0xFFDB174D),
                features: const [
                  'Fast & easy',
                  'Wallet balance',
                  'Secure payment',
                ],
                onTap: () {},
              ),
            ),

            // OMT - DISABLED
            SizedBox(
              width: itemWidth,
              child: _GatewayCard(
                value: 'omt',
                selectedValue: selectedMethod,
                enabled: false,
                title: 'OMT',
                subtitle: 'Pay with your OMT account',
                logoText: 'OMT',
                iconColor: const Color(0xFF9A8500),
                features: const [
                  'Reliable payments',
                  'Secure transfer',
                  '24/7 support',
                ],
                onTap: () {},
              ),
            ),

            // PAGO BANK - DISABLED
            SizedBox(
              width: constraints.maxWidth,
              child: _GatewayCard(
                value: 'pago',
                selectedValue: selectedMethod,
                enabled: false,
                title: 'Pago Bank',
                subtitle:
                'Pay securely using your Pago Bank account',
                logoText: 'pago',
                iconColor: const Color(0xFF5146B3),
                features: const [
                  'Secure banking',
                  'Instant confirmation',
                  'Trusted & safe',
                ],
                onTap: () {},
                wide: true,
              ),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // CONTINUE
  // ============================================================

  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: continueSecurely,
        icon: const Icon(
          Icons.lock_rounded,
          size: 16,
        ),
        label: Text(
          'Continue with $selectedMethodName',
          style: const TextStyle(
            fontSize: 13.5,
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
    );
  }

  // ============================================================
  // SECURITY FOOTER
  // ============================================================

  Widget _buildSecurityFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFE2E7EF),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _FooterSecurityItem(
            icon: Icons.lock_outline_rounded,
            title: '256-bit',
            subtitle: 'SSL Encryption',
          ),
          _FooterSecurityItem(
            icon: Icons.verified_user_outlined,
            title: 'PCI DSS',
            subtitle: 'Compliant',
          ),
          _FooterSecurityItem(
            icon: Icons.shield_outlined,
            title: 'Instant',
            subtitle: 'Processing',
          ),
          _FooterSecurityItem(
            icon: Icons.security_rounded,
            title: 'SecurePay',
            subtitle: 'Protected',
          ),
        ],
      ),
    );
  }
}

// ============================================================
// GATEWAY CARD
// ============================================================

class _GatewayCard extends StatelessWidget {
  final String value;
  final String selectedValue;

  final bool enabled;

  final String title;
  final String subtitle;

  final IconData? icon;
  final String? logoText;

  final Color iconColor;

  final List<String> features;

  final VoidCallback onTap;

  final bool wide;

  const _GatewayCard({
    required this.value,
    required this.selectedValue,
    required this.enabled,
    required this.title,
    required this.subtitle,
    required this.iconColor,
    required this.features,
    required this.onTap,
    this.icon,
    this.logoText,
    this.wide = false,
  });

  bool get selected =>
      enabled && value == selectedValue;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(11),
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 170),
            curve: Curves.easeOut,
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: selected
                  ? const Color(0xFFFFF8F2)
                  : enabled
                  ? Colors.white
                  : const Color(0xFFF4F5F7),
              borderRadius: BorderRadius.circular(11),
              border: Border.all(
                color: selected
                    ? AppColors.orange
                    : const Color(0xFFE0E6EF),
                width: selected ? 1.4 : 1,
              ),
            ),
            child: wide
                ? _buildWideContent()
                : _buildNormalContent(),
          ),
        ),
    );
  }

  // ============================================================
  // NORMAL CARD
  // ============================================================

  Widget _buildNormalContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLogo(),
            const Spacer(),
            enabled
                ? _buildRadio()
                : _buildDisabledIcon(),
          ],
        ),

        const SizedBox(height: 8),

        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: enabled
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            if (!enabled)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6E8EC),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Text(
                  'Unavailable',
                  style: TextStyle(
                    color: Color(0xFF667085),
                    fontSize: 6.8,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
          ],
        ),

        const SizedBox(height: 3),

        Text(
          subtitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 8.6,
            height: 1.3,
          ),
        ),

        const SizedBox(height: 8),

        ...features.map(
              (feature) => Padding(
            padding: const EdgeInsets.only(
              bottom: 3.5,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.check_rounded,
                  size: 11,

                  // ORANGE WHEN SELECTED
                  color: selected
                      ? AppColors.orange
                      : enabled
                      ? AppColors.navy
                      : const Color(0xFF98A2B3),
                ),

                const SizedBox(width: 4),

                Expanded(
                  child: Text(
                    feature,
                    style: TextStyle(
                      color: enabled
                          ? AppColors.textPrimary
                          : AppColors.textSecondary,
                      fontSize: 7.9,
                      height: 1.2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // WIDE CARD
  // ============================================================

  Widget _buildWideContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLogo(),

        const SizedBox(width: 10),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: enabled
                            ? AppColors.textPrimary
                            : AppColors.textSecondary,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  if (!enabled)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE6E8EC),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text(
                        'Unavailable',
                        style: TextStyle(
                          color: Color(0xFF667085),
                          fontSize: 7,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 3),

              Text(
                subtitle,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 8.8,
                ),
              ),

              const SizedBox(height: 7),

              Wrap(
                spacing: 10,
                runSpacing: 4,
                children: features
                    .map(
                      (feature) => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_rounded,
                        size: 10,
                        color: selected
                            ? AppColors.orange
                            : enabled
                            ? AppColors.navy
                            : const Color(
                          0xFF98A2B3,
                        ),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        feature,
                        style: TextStyle(
                          color: enabled
                              ? AppColors.textPrimary
                              : AppColors.textSecondary,
                          fontSize: 7.8,
                        ),
                      ),
                    ],
                  ),
                )
                    .toList(),
              ),
            ],
          ),
        ),

        const SizedBox(width: 8),

        enabled
            ? _buildRadio()
            : _buildDisabledIcon(),
      ],
    );
  }

  // ============================================================
  // LOGO
  // ============================================================

  Widget _buildLogo() {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.09),
        borderRadius: BorderRadius.circular(9),
      ),
      alignment: Alignment.center,
      child: logoText != null
          ? Text(
        logoText!,
        style: TextStyle(
          color: iconColor,
          fontSize:
          logoText!.length > 3 ? 10.5 : 12,
          fontWeight: FontWeight.w800,
        ),
      )
          : Icon(
        icon,
        color: enabled
            ? iconColor
            : const Color(0xFF98A2B3),
        size: 21,
      ),
    );
  }

  // ============================================================
  // SELECTED RADIO
  // ============================================================

  Widget _buildRadio() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 170),
      width: 19,
      height: 19,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selected
            ? AppColors.orange
            : Colors.transparent,
        border: Border.all(
          color: selected
              ? AppColors.orange
              : const Color(0xFFB9C4D3),
          width: 1.3,
        ),
      ),
      child: selected
          ? const Icon(
        Icons.check_rounded,
        size: 12,
        color: Colors.white,
      )
          : null,
    );
  }

  // ============================================================
  // DISABLED LOCK
  // ============================================================

  Widget _buildDisabledIcon() {
    return Container(
      width: 19,
      height: 19,
      decoration: BoxDecoration(
        color: const Color(0xFFE4E7EC),
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFFD0D5DD),
        ),
      ),
      child: const Icon(
        Icons.lock_rounded,
        color: Color(0xFF98A2B3),
        size: 10,
      ),
    );
  }
}

// ============================================================
// SECURITY MINI ITEM
// ============================================================

class _SecurityMiniItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const _SecurityMiniItem({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 14,
        ),
        const SizedBox(height: 2),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 7,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// ============================================================
// SECURITY FOOTER ITEM
// ============================================================

class _FooterSecurityItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _FooterSecurityItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      child: Column(
        children: [
          Icon(
            icon,
            size: 16,
            color: AppColors.navy,
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 8,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 1),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 7,
            ),
          ),
        ],
      ),
    );
  }
}