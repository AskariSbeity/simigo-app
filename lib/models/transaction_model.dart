import 'package:flutter/material.dart';

class TransactionModel {
  final String id;
  final String title;
  final String subtitle;
  final String amount;
  final String date;
  final String paymentMethod;
  final String status;

  final bool isIncoming;

  final IconData? icon;
  final String? iconText;

  final Color iconColor;

  const TransactionModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
    required this.paymentMethod,
    required this.status,
    required this.isIncoming,
    required this.iconColor,
    this.icon,
    this.iconText,
  });
}