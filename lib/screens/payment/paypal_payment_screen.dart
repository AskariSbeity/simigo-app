import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class PaypalPaymentScreen extends StatefulWidget {
  final double amount;

  const PaypalPaymentScreen({
    super.key,
    required this.amount,
  });

  @override
  State<PaypalPaymentScreen> createState() =>
      _PaypalPaymentScreenState();
}

class _PaypalPaymentScreenState extends State<PaypalPaymentScreen> {
  bool processing = false;

  Future<void> continueToPaypal() async {
    setState(() {
      processing = true;
    });

    await Future.delayed(
      const Duration(milliseconds: 900),
    );

    if (!mounted) return;

    setState(() {
      processing = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'PayPal checkout will be connected to the backend later',
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
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 15),

                    Container(
                      width: 90,
                      height: 90,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEAF5FD),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.paypal_rounded,
                        color: Color(0xFF0070BA),
                        size: 48,
                      ),
                    ),

                    const SizedBox(height: 22),

                    const Text(
                      'Pay with PayPal',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'You will be securely redirected to PayPal to complete your payment.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 28),

                    _buildAmountCard(),

                    const SizedBox(height: 22),

                    _buildFeature(
                      Icons.bolt_rounded,
                      'Fast mobile checkout',
                      'Complete your payment quickly with your PayPal account.',
                    ),

                    _buildFeature(
                      Icons.shield_outlined,
                      'Buyer protection',
                      'Payments are handled through PayPal’s secure checkout.',
                    ),

                    _buildFeature(
                      Icons.credit_card_off_outlined,
                      'No card entry here',
                      'Your card details are not entered directly inside this screen.',
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed:
                        processing ? null : continueToPaypal,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0070BA),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: processing
                            ? const SizedBox(
                          width: 21,
                          height: 21,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                            : Text(
                          'Continue to PayPal • \$${widget.amount.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
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
    return Container(
      color: AppColors.navy,
      padding: const EdgeInsets.fromLTRB(8, 10, 18, 12),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
          ),
          const Icon(
            Icons.paypal_rounded,
            color: Colors.white,
            size: 28,
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'PayPal',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Icon(
            Icons.lock_outline_rounded,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildAmountCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: const Color(0xFFE1E6EE),
        ),
      ),
      child: Row(
        children: [
          const Text(
            'Amount to Pay',
            style: TextStyle(
              color: AppColors.textSecondary,
            ),
          ),
          const Spacer(),
          Text(
            '\$${widget.amount.toStringAsFixed(2)}',
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 21,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeature(
      IconData icon,
      String title,
      String subtitle,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF5FD),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF0070BA),
              size: 20,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 10,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}