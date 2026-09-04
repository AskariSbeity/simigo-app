import 'package:flutter/material.dart';

import '../models/transaction_model.dart';

const List<TransactionModel> mockTransactions = [
  TransactionModel(
    id: 'TXN1234567890',
    title: 'Amazon Purchase',
    subtitle: 'Today, 10:30 AM',
    amount: '\$45.00',
    date: '23 May 2024, 10:30 AM',
    paymentMethod: 'PayPal',
    status: 'Completed',
    isIncoming: false,
    iconText: 'a',
    iconColor: Color(0xFFFF9900),
  ),

  TransactionModel(
    id: 'TXN2234567890',
    title: 'Add Money',
    subtitle: 'Today, 09:15 AM',
    amount: '\$200.00',
    date: '23 May 2024, 09:15 AM',
    paymentMethod: 'Card Payment',
    status: 'Completed',
    isIncoming: true,
    icon: Icons.add_circle_outline_rounded,
    iconColor: Color(0xFF12B76A),
  ),

  TransactionModel(
    id: 'TXN3234567890',
    title: 'Netflix Subscription',
    subtitle: 'Yesterday, 08:45 PM',
    amount: '\$15.99',
    date: '22 May 2024, 08:45 PM',
    paymentMethod: 'Visa Card',
    status: 'Completed',
    isIncoming: false,
    iconText: 'N',
    iconColor: Color(0xFFE50914),
  ),

  TransactionModel(
    id: 'TXN4234567890',
    title: 'Starbucks',
    subtitle: 'Yesterday, 07:30 PM',
    amount: '\$5.75',
    date: '22 May 2024, 07:30 PM',
    paymentMethod: 'Wallet',
    status: 'Completed',
    isIncoming: false,
    icon: Icons.local_cafe_rounded,
    iconColor: Color(0xFF00754A),
  ),

  TransactionModel(
    id: 'TXN5234567890',
    title: 'Uber Ride',
    subtitle: '23 May 2024, 06:20 PM',
    amount: '\$18.50',
    date: '23 May 2024, 06:20 PM',
    paymentMethod: 'Wallet',
    status: 'Completed',
    isIncoming: false,
    icon: Icons.local_taxi_rounded,
    iconColor: Color(0xFF111827),
  ),

  TransactionModel(
    id: 'TXN6234567890',
    title: 'Salary',
    subtitle: '23 May 2024, 09:00 AM',
    amount: '\$1,000.00',
    date: '23 May 2024, 09:00 AM',
    paymentMethod: 'Bank Transfer',
    status: 'Completed',
    isIncoming: true,
    icon: Icons.account_balance_wallet_outlined,
    iconColor: Color(0xFF12B76A),
  ),
];