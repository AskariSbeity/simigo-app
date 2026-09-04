import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../models/transaction_model.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionDetailsScreen({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            20,
            10,
            20,
            30,
          ),
          child: Column(
            children: [
              _buildHeader(context),

              const SizedBox(height: 28),

              _buildTransactionIcon(),

              const SizedBox(height: 18),

              Text(
                transaction.title,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                transaction.isIncoming
                    ? '+${transaction.amount}'
                    : '-${transaction.amount}',
                style: TextStyle(
                  color: transaction.isIncoming
                      ? AppColors.success
                      : AppColors.textPrimary,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                transaction.date,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),

              const SizedBox(height: 35),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: const Color(0xFFE9EDF4),
                  ),
                ),
                child: Column(
                  children: [
                    _DetailRow(
                      label: 'Transaction ID',
                      value: transaction.id,
                    ),

                    const Divider(
                      height: 1,
                      color: Color(0xFFF0F2F6),
                    ),

                    _DetailRow(
                      label: 'Payment Method',
                      value: transaction.paymentMethod,
                    ),

                    const Divider(
                      height: 1,
                      color: Color(0xFFF0F2F6),
                    ),

                    _DetailRow(
                      label: 'Status',
                      value: transaction.status,
                      valueColor: AppColors.success,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Receipt sharing will be added later',
                        ),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.share_outlined,
                    size: 19,
                  ),
                  label: const Text(
                    'Share Receipt',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.orange,
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
    );
  }

  Widget _buildHeader(BuildContext context) {
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
          'Transaction Details',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionIcon() {
    return Container(
      width: 76,
      height: 76,
      decoration: BoxDecoration(
        color: transaction.iconColor.withOpacity(0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.center,
      child: transaction.iconText != null
          ? Text(
        transaction.iconText!,
        style: TextStyle(
          color: transaction.iconColor,
          fontSize: transaction.iconText == 'N' ? 31 : 38,
          fontWeight: FontWeight.w800,
        ),
      )
          : Icon(
        transaction.icon,
        size: 34,
        color: transaction.iconColor,
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _DetailRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
      ),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),

          const Spacer(),

          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: valueColor ?? AppColors.textPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}