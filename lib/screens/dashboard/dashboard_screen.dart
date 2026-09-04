import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../data/mock_transactions.dart';
import '../../models/transaction_model.dart';
import '../money/add_money_screen.dart';
import '../cards/cards_screen.dart';
import '../more/more_screen.dart';
import '../transactions/transaction_details_screen.dart';
import '../transactions/transactions_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String selectedCurrency = 'USD';

  void openTransactions() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const TransactionsScreen(),
      ),
    );
  }

  void openAddMoney() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AddMoneyScreen(),
      ),
    );
  }

  void openTransactionDetails(TransactionModel transaction) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TransactionDetailsScreen(
          transaction: transaction,
        ),
      ),
    );
  }

  void showComingSoon(String title) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$title screen will be added next'),
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
    final recentTransactions = mockTransactions.take(4).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              _buildTopSection(),

              const SizedBox(height: 4),

              _buildMainActions(),

              const SizedBox(height: 28),

              _buildQuickActions(),

              const SizedBox(height: 28),

              _buildRecentTransactions(recentTransactions),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================
  // TOP SECTION
  // =========================================================

  Widget _buildTopSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        20,
        20,
        20,
        0,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFE9EEF7),
                ),
                child: const Icon(
                  Icons.person_rounded,
                  color: Color(0xFF667085),
                  size: 23,
                ),
              ),

              const SizedBox(width: 12),

              const Expanded(
                child: Text(
                  'Hello, John Doe',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              Stack(
                clipBehavior: Clip.none,
                children: [
                  IconButton(
                    onPressed: () {
                      showComingSoon('Notifications');
                    },
                    icon: const Icon(
                      Icons.notifications_none_rounded,
                      color: AppColors.textPrimary,
                      size: 25,
                    ),
                  ),

                  Positioned(
                    right: 9,
                    top: 8,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.orange,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 18),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(
              20,
              20,
              18,
              20,
            ),
            decoration: BoxDecoration(
              color: AppColors.navy,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.navy.withOpacity(0.16),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Balance',
                        style: TextStyle(
                          color: Color(0xFFDDE6F5),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      SizedBox(height: 7),

                      Text(
                        '\$1,250.75',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                ),

                _buildCurrencySelector(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencySelector() {
    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.11),
        borderRadius: BorderRadius.circular(9),
        border: Border.all(
          color: Colors.white.withOpacity(0.08),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedCurrency,
          dropdownColor: AppColors.navy,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.white,
            size: 18,
          ),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
          items: const [
            DropdownMenuItem(
              value: 'USD',
              child: Text('USD'),
            ),
            DropdownMenuItem(
              value: 'EUR',
              child: Text('EUR'),
            ),
            DropdownMenuItem(
              value: 'LBP',
              child: Text('LBP'),
            ),
          ],
          onChanged: (value) {
            if (value == null) {
              return;
            }

            setState(() {
              selectedCurrency = value;
            });
          },
        ),
      ),
    );
  }

  // =========================================================
  // MAIN ACTIONS
  // =========================================================

  Widget _buildMainActions() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        18,
        22,
        18,
        0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _MainAction(
            icon: Icons.account_balance_wallet_outlined,
            label: 'Add Money',
            onTap: openAddMoney,
          ),

          _MainAction(
            icon: Icons.north_east_rounded,
            label: 'Send Money',
            onTap: () {
              showComingSoon('Send Money');
            },
          ),

          _MainAction(
            icon: Icons.qr_code_scanner_rounded,
            label: 'Scan & Pay',
            onTap: () {
              showComingSoon('Scan & Pay');
            },
          ),

          _MainAction(
            icon: Icons.more_horiz_rounded,
            label: 'More',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MoreScreen(),
                ),
              );
            },
          ),
    ]),
    );
  }

  // =========================================================
  // QUICK ACTIONS
  // =========================================================

  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Actions',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 17),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 17,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xFFE9EDF4),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _QuickAction(
                  icon: Icons.receipt_long_outlined,
                  label: 'Transactions',
                  onTap: openTransactions,
                ),

                _QuickAction(
                  icon: Icons.add_circle_outline_rounded,
                  label: 'Add Money',
                  onTap: openAddMoney,
                ),

                _QuickAction(
                  icon: Icons.credit_card_rounded,
                  label: 'Cards',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CardsScreen(),
                      ),
                    );
                  },
                ),

                _QuickAction(
                  icon: Icons.local_offer_outlined,
                  label: 'Offers',
                  onTap: () {
                    showComingSoon('Offers');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // RECENT TRANSACTIONS
  // =========================================================

  Widget _buildRecentTransactions(
      List<TransactionModel> transactions,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Transactions',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 12),

          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xFFE9EDF4),
              ),
            ),
            child: Column(
              children: [
                ...List.generate(
                  transactions.length,
                      (index) {
                    final transaction = transactions[index];

                    return Column(
                      children: [
                        _DashboardTransactionTile(
                          transaction: transaction,
                          onTap: () {
                            openTransactionDetails(transaction);
                          },
                        ),

                        if (index != transactions.length - 1)
                          const Padding(
                            padding: EdgeInsets.only(left: 62),
                            child: Divider(
                              height: 1,
                              color: Color(0xFFF0F2F6),
                            ),
                          ),
                      ],
                    );
                  },
                ),

                const Divider(
                  height: 1,
                  color: Color(0xFFF0F2F6),
                ),

                InkWell(
                  onTap: openTransactions,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(14),
                  ),
                  child: const SizedBox(
                    height: 50,
                    child: Center(
                      child: Text(
                        'View All',
                        style: TextStyle(
                          color: AppColors.navy,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
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

// ===========================================================
// MAIN ACTION WIDGET
// ===========================================================

class _MainAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _MainAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: SizedBox(
        width: 78,
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.orange,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.orange.withOpacity(0.18),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 23,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              label,
              maxLines: 1,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===========================================================
// QUICK ACTION WIDGET
// ===========================================================

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 75,
        child: Column(
          children: [
            Container(
              width: 39,
              height: 39,
              decoration: BoxDecoration(
                color: const Color(0xFFF4F7FB),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                size: 20,
                color: AppColors.navy,
              ),
            ),

            const SizedBox(height: 7),

            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 9.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===========================================================
// DASHBOARD TRANSACTION TILE
// ===========================================================

class _DashboardTransactionTile extends StatelessWidget {
  final TransactionModel transaction;
  final VoidCallback onTap;

  const _DashboardTransactionTile({
    required this.transaction,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 14,
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
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
                  transaction.iconText == 'N' ? 17 : 21,
                  fontWeight: FontWeight.w800,
                ),
              )
                  : Icon(
                transaction.icon,
                color: transaction.iconColor,
                size: 19,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.title,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    transaction.subtitle,
                    style: const TextStyle(
                      color: Color(0xFF98A2B3),
                      fontSize: 9.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            Text(
              transaction.isIncoming
                  ? '+ ${transaction.amount}'
                  : '- ${transaction.amount}',
              style: TextStyle(
                color: transaction.isIncoming
                    ? AppColors.success
                    : AppColors.textPrimary,
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}