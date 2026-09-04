import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../data/mock_transactions.dart';
import '../../models/transaction_model.dart';
import 'transaction_details_screen.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String selectedFilter = 'All';

  List<TransactionModel> get filteredTransactions {
    if (selectedFilter == 'Money In') {
      return mockTransactions
          .where((transaction) => transaction.isIncoming)
          .toList();
    }

    if (selectedFilter == 'Money Out') {
      return mockTransactions
          .where((transaction) => !transaction.isIncoming)
          .toList();
    }

    return mockTransactions;
  }

  void openDetails(TransactionModel transaction) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TransactionDetailsScreen(
          transaction: transaction,
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
            _buildFilters(),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  10,
                  20,
                  30,
                ),
                itemCount: filteredTransactions.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final transaction = filteredTransactions[index];

                  return _TransactionCard(
                    transaction: transaction,
                    onTap: () => openDetails(transaction),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 14, 14, 8),
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

          const SizedBox(width: 4),

          const Expanded(
            child: Text(
              'Transactions',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.filter_alt_outlined,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _FilterButton(
            label: 'All',
            selected: selectedFilter == 'All',
            onTap: () {
              setState(() {
                selectedFilter = 'All';
              });
            },
          ),

          const SizedBox(width: 10),

          _FilterButton(
            label: 'Money In',
            selected: selectedFilter == 'Money In',
            onTap: () {
              setState(() {
                selectedFilter = 'Money In';
              });
            },
          ),

          const SizedBox(width: 10),

          _FilterButton(
            label: 'Money Out',
            selected: selectedFilter == 'Money Out',
            onTap: () {
              setState(() {
                selectedFilter = 'Money Out';
              });
            },
          ),
        ],
      ),
    );
  }
}

class _FilterButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          height: 40,
          decoration: BoxDecoration(
            color: selected ? AppColors.navy : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: selected
                  ? AppColors.navy
                  : AppColors.border,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: selected
                  ? Colors.white
                  : AppColors.textPrimary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _TransactionCard extends StatelessWidget {
  final TransactionModel transaction;
  final VoidCallback onTap;

  const _TransactionCard({
    required this.transaction,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 16,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: const Color(0xFFE9EDF4),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: transaction.iconColor.withOpacity(0.10),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: transaction.iconText != null
                    ? Text(
                  transaction.iconText!,
                  style: TextStyle(
                    color: transaction.iconColor,
                    fontSize:
                    transaction.iconText == 'N' ? 19 : 23,
                    fontWeight: FontWeight.w800,
                  ),
                )
                    : Icon(
                  transaction.icon,
                  size: 21,
                  color: transaction.iconColor,
                ),
              ),

              const SizedBox(width: 13),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.title,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      transaction.subtitle,
                      style: const TextStyle(
                        color: Color(0xFF98A2B3),
                        fontSize: 10.5,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              Text(
                transaction.isIncoming
                    ? '+ ${transaction.amount}'
                    : '- ${transaction.amount}',
                style: TextStyle(
                  color: transaction.isIncoming
                      ? AppColors.success
                      : AppColors.textPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}