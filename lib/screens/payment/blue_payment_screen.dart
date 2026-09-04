import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class BluePaymentScreen extends StatefulWidget {
  final double amount;

  const BluePaymentScreen({
    super.key,
    required this.amount,
  });

  @override
  State<BluePaymentScreen> createState() => _BluePaymentScreenState();
}

class _BluePaymentScreenState extends State<BluePaymentScreen> {
  bool processing = false;

  Future<void> continueToBlue() async {
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
          'Blue checkout will be connected to the backend later',
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
                    const SizedBox(height: 16),

                    Container(
                      width: 92,
                      height: 92,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEAF2FF),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'blue',
                        style: TextStyle(
                          color: Color(0xFF1465D8),
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    const Text(
                      'Pay with Blue',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Continue securely using your Blue account.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                      ),
                    ),

                    const SizedBox(height: 28),

                    _buildAmountCard(),

                    const SizedBox(height: 24),

                    _buildFeature(
                      Icons.bolt_rounded,
                      'Quick checkout',
                      'Fast wallet top-up using Blue.',
                    ),

                    _buildFeature(
                      Icons.lock_outline_rounded,
                      'Secure payment',
                      'Payment will be processed through the Blue gateway.',
                    ),

                    _buildFeature(
                      Icons.verified_user_outlined,
                      'Verified confirmation',
                      'The final payment result will be confirmed by the backend.',
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton.icon(
                        onPressed:
                        processing ? null : continueToBlue,
                        icon: const Icon(
                          Icons.lock_rounded,
                          size: 17,
                        ),
                        label: processing
                            ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                            : Text(
                          'Continue with Blue • \$${widget.amount.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1465D8),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
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
          const Text(
            'blue',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Blue Payment',
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
              color: Color(0xFF1465D8),
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
              color: const Color(0xFFEAF2FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF1465D8),
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