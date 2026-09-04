import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';
import '../payment/payment_method_screen.dart';

class AddMoneyScreen extends StatefulWidget {
  const AddMoneyScreen({super.key});

  @override
  State<AddMoneyScreen> createState() => _AddMoneyScreenState();
}

class _AddMoneyScreenState extends State<AddMoneyScreen> {
  final TextEditingController amountController =
  TextEditingController(text: '100.00');

  String selectedPaymentMethod = 'paypal';

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  void selectPaymentMethod(String value) {
    setState(() {
      selectedPaymentMethod = value;
    });
  }

  void continuePayment() {
    FocusScope.of(context).unfocus();

    final amount = amountController.text.trim();

    if (amount.isEmpty) {
      _showError('Please enter an amount');
      return;
    }

    final parsedAmount = double.tryParse(amount);

    if (parsedAmount == null || parsedAmount <= 0) {
      _showError('Please enter a valid amount');
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentMethodScreen(
          amount: parsedAmount,
          initialMethod: selectedPaymentMethod,
        ),
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
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
            _buildHeader(),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(
                  20,
                  18,
                  20,
                  32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAmountSection(),

                    const SizedBox(height: 30),

                    const Text(
                      'Select Payment Method',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 14),

                    PaymentMethodCard(
                      value: 'paypal',
                      selectedValue: selectedPaymentMethod,
                      title: 'PayPal',
                      subtitle: 'PayPal balance or linked card',
                      icon: Icons.paypal_rounded,
                      iconColor: const Color(0xFF0070BA),
                      onTap: () {
                        selectPaymentMethod('paypal');
                      },
                    ),

                    const SizedBox(height: 12),

                    PaymentMethodCard(
                      value: 'card',
                      selectedValue: selectedPaymentMethod,
                      title: 'Card Payment',
                      subtitle: 'Debit/Credit card',
                      icon: Icons.credit_card_rounded,
                      iconColor: AppColors.navy,
                      onTap: () {
                        selectPaymentMethod('card');
                      },
                    ),

                    const SizedBox(height: 12),

                    PaymentMethodCard(
                      value: 'bank',
                      selectedValue: selectedPaymentMethod,
                      title: 'Bank Transfer',
                      subtitle: 'Transfer from bank account',
                      icon: Icons.account_balance_rounded,
                      iconColor: AppColors.navy,
                      onTap: () {
                        selectPaymentMethod('bank');
                      },
                    ),

                    const SizedBox(height: 12),

                    PaymentMethodCard(
                      value: 'upi',
                      selectedValue: selectedPaymentMethod,
                      title: 'UPI',
                      subtitle: 'Pay using UPI apps',
                      icon: Icons.bolt_rounded,
                      iconColor: const Color(0xFFFF8A00),
                      onTap: () {
                        selectPaymentMethod('upi');
                      },
                    ),

                    const SizedBox(height: 34),

                    _buildContinueButton(),

                    const SizedBox(height: 12),
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
        4,
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
              size: 24,
            ),
          ),

          const SizedBox(width: 3),

          const Text(
            'Add Money',
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

  Widget _buildAmountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Enter Amount',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 9),

        Container(
          height: 58,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color(0xFFDCE3ED),
            ),
          ),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  '\$',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              const SizedBox(width: 7),

              Expanded(
                child: TextField(
                  controller: amountController,
                  keyboardType:
                  const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d*\.?\d{0,2}'),
                    ),
                  ],
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    filled: false,
                    hintText: '0.00',
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: continuePayment,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.orange,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          ),
        ),
        child: const Text(
          'Continue',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

// ============================================================
// PAYMENT METHOD CARD
// ============================================================

class PaymentMethodCard extends StatelessWidget {
  final String value;
  final String selectedValue;

  final String title;
  final String subtitle;

  final IconData icon;
  final Color iconColor;

  final VoidCallback onTap;

  const PaymentMethodCard({
    super.key,
    required this.value,
    required this.selectedValue,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });

  bool get isSelected => value == selectedValue;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 15,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFFFFF8F3)
                : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? AppColors.orange
                  : const Color(0xFFDCE3ED),
              width: isSelected ? 1.4 : 1,
            ),
            boxShadow: isSelected
                ? [
              BoxShadow(
                color: AppColors.orange.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ]
                : null,
          ),
          child: Row(
            children: [
              Container(
                width: 43,
                height: 43,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.09),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 22,
                ),
              ),

              const SizedBox(width: 13),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 21,
                height: 21,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected
                      ? AppColors.orange
                      : Colors.transparent,
                  border: Border.all(
                    color: isSelected
                        ? AppColors.orange
                        : const Color(0xFFB8C2D1),
                    width: 1.5,
                  ),
                ),
                child: isSelected
                    ? const Icon(
                  Icons.check_rounded,
                  size: 14,
                  color: Colors.white,
                )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}