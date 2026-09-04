import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';

class CardPaymentScreen extends StatefulWidget {
  final double amount;

  const CardPaymentScreen({
    super.key,
    required this.amount,
  });

  @override
  State<CardPaymentScreen> createState() =>
      _CardPaymentScreenState();
}

class _CardPaymentScreenState extends State<CardPaymentScreen> {
  final TextEditingController nameController =
  TextEditingController();

  final TextEditingController cardController =
  TextEditingController();

  final TextEditingController expiryController =
  TextEditingController();

  final TextEditingController cvvController =
  TextEditingController();

  bool saveCard = false;
  bool obscureCvv = true;

  @override
  void initState() {
    super.initState();

    nameController.addListener(_refreshPreview);
    cardController.addListener(_refreshPreview);
    expiryController.addListener(_refreshPreview);
  }

  void _refreshPreview() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    nameController.removeListener(_refreshPreview);
    cardController.removeListener(_refreshPreview);
    expiryController.removeListener(_refreshPreview);

    nameController.dispose();
    cardController.dispose();
    expiryController.dispose();
    cvvController.dispose();

    super.dispose();
  }

  String get previewName {
    final value = nameController.text.trim();

    return value.isEmpty
        ? 'CARDHOLDER NAME'
        : value.toUpperCase();
  }

  String get previewNumber {
    final value = cardController.text.trim();

    return value.isEmpty
        ? '••••  ••••  ••••  ••••'
        : value;
  }

  String get previewExpiry {
    final value = expiryController.text.trim();

    return value.isEmpty ? 'MM/YY' : value;
  }

  // ============================================================
  // VALIDATION
  // ============================================================

  void _paySecurely() {
    FocusScope.of(context).unfocus();

    final name = nameController.text.trim();

    final cardNumber =
    cardController.text.replaceAll(' ', '');

    final expiry = expiryController.text.trim();

    final cvv = cvvController.text.trim();

    if (name.isEmpty) {
      _showError(
        'Please enter the cardholder name',
      );

      return;
    }

    if (cardNumber.length != 16) {
      _showError(
        'Please enter a valid 16-digit card number',
      );

      return;
    }

    if (expiry.length != 5) {
      _showError(
        'Please enter a valid expiry date',
      );

      return;
    }

    if (cvv.length < 3) {
      _showError(
        'Please enter a valid CVV',
      );

      return;
    }

    ScaffoldMessenger.of(context)
        .hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Card payment of '
              '\$${widget.amount.toStringAsFixed(2)} ready',
        ),
        backgroundColor: AppColors.navy,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    // Backend integration later.
    //
    // Important:
    // Raw card number / CVV should not be stored.
    // The payment gateway should tokenize sensitive data.
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context)
        .hideCurrentSnackBar();

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

  // ============================================================
  // PAGE
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            // Fixed header
            _buildHeader(),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.fromLTRB(
                  24,
                  16,
                  24,
                  10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPageTitle(),

                    const SizedBox(height: 14),

                    _buildCardPreview(),

                    const SizedBox(height: 16),

                    _buildAmountCard(),

                    const SizedBox(height: 16),

                    const Text(
                      'Card Details',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 12),

                    _buildCardholderField(),

                    const SizedBox(height: 12),

                    _buildCardNumberField(),

                    const SizedBox(height: 12),

                    Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _buildExpiryField(),
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: _buildCvvField(),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    _buildSaveCardOption(),

                    const SizedBox(height: 6),
                  ],
                ),
              ),
            ),

            // Fixed bottom payment button
            _buildBottomPaymentBar(),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      color: AppColors.navy,
      padding: const EdgeInsets.fromLTRB(
        8,
        8,
        18,
        10,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 22,
            ),
          ),

          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.orange,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.credit_card_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),

          const SizedBox(width: 11),

          const Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  'Card Payment',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                SizedBox(height: 2),

                Text(
                  'Secure debit or credit card payment',
                  style: TextStyle(
                    color: Color(0xFFD7E1F0),
                    fontSize: 8.5,
                  ),
                ),
              ],
            ),
          ),

          const Column(
            children: [
              Icon(
                Icons.lock_outline_rounded,
                color: Colors.white,
                size: 16,
              ),

              SizedBox(height: 2),

              Text(
                'Secure',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 7,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PAGE TITLE
  // ============================================================

  Widget _buildPageTitle() {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.shield_outlined,
          color: AppColors.navy,
          size: 22,
        ),

        SizedBox(width: 10),

        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                'Enter Your Card Details',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),

              SizedBox(height: 3),

              Text(
                'Your payment information is protected and encrypted.',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // LIVE CARD PREVIEW
  // ============================================================

  Widget _buildCardPreview() {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 250,
      ),
      width: double.infinity,
      height: 178,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF00245E),
            Color(0xFF00408F),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(21),
        boxShadow: [
          BoxShadow(
            color: AppColors.navy.withOpacity(
              0.18,
            ),
            blurRadius: 18,
            offset: const Offset(
              0,
              8,
            ),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 30,
                decoration: BoxDecoration(
                  color: const Color(
                    0xFFEACB75,
                  ),
                  borderRadius:
                  BorderRadius.circular(
                    7,
                  ),
                ),
              ),

              const Spacer(),

              Container(
                width: 31,
                height: 31,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.contactless_rounded,
                  color: AppColors.navy,
                  size: 21,
                ),
              ),
            ],
          ),

          const Spacer(),

          Text(
            previewNumber,
            maxLines: 1,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              letterSpacing: 2,
              fontWeight: FontWeight.w600,
            ),
          ),

          const Spacer(),

          Row(
            crossAxisAlignment:
            CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'CARD HOLDER',
                      style: TextStyle(
                        color: Color(
                          0xFFBFD1EE,
                        ),
                        fontSize: 7,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      previewName,
                      overflow:
                      TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10.5,
                        fontWeight:
                        FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  const Text(
                    'EXPIRES',
                    style: TextStyle(
                      color: Color(
                        0xFFBFD1EE,
                      ),
                      fontSize: 7,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    previewExpiry,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10.5,
                      fontWeight:
                      FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 20),

              const Text(
                'VISA',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // AMOUNT
  // ============================================================

  Widget _buildAmountCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 17,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(
            0xFFE1E6EE,
          ),
        ),
      ),
      child: Row(
        children: [
          const Text(
            'Amount to Pay',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),

          const Spacer(),

          Text(
            '\$${widget.amount.toStringAsFixed(2)}',
            style: const TextStyle(
              color: AppColors.orange,
              fontSize: 19,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CARDHOLDER NAME
  // ============================================================

  Widget _buildCardholderField() {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        _buildLabel(
          'Cardholder Name',
        ),

        const SizedBox(height: 7),

        TextField(
          controller: nameController,
          textCapitalization:
          TextCapitalization.words,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          decoration: _inputDecoration(
            hint: 'Name on card',
            prefixIcon:
            Icons.person_outline_rounded,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // CARD NUMBER
  // ============================================================

  Widget _buildCardNumberField() {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        _buildLabel(
          'Card Number',
        ),

        const SizedBox(height: 7),

        TextField(
          controller: cardController,
          keyboardType:
          TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter
                .digitsOnly,
            LengthLimitingTextInputFormatter(
              16,
            ),
            CardNumberFormatter(),
          ],
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 1,
          ),
          decoration: _inputDecoration(
            hint:
            '1234 5678 9012 3456',
            prefixIcon:
            Icons.credit_card_rounded,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // EXPIRY
  // ============================================================

  Widget _buildExpiryField() {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        _buildLabel(
          'Expiry Date',
        ),

        const SizedBox(height: 7),

        TextField(
          controller: expiryController,
          keyboardType:
          TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter
                .digitsOnly,
            LengthLimitingTextInputFormatter(
              4,
            ),
            ExpiryDateFormatter(),
          ],
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          decoration: _inputDecoration(
            hint: 'MM/YY',
            prefixIcon:
            Icons.calendar_today_outlined,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // CVV
  // ============================================================

  Widget _buildCvvField() {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        _buildLabel(
          'CVV',
        ),

        const SizedBox(height: 7),

        TextField(
          controller: cvvController,
          obscureText: obscureCvv,
          keyboardType:
          TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter
                .digitsOnly,
            LengthLimitingTextInputFormatter(
              4,
            ),
          ],
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          decoration: _inputDecoration(
            hint: 'CVV',
            prefixIcon:
            Icons.lock_outline_rounded,
          ).copyWith(
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscureCvv =
                  !obscureCvv;
                });
              },
              icon: Icon(
                obscureCvv
                    ? Icons
                    .visibility_outlined
                    : Icons
                    .visibility_off_outlined,
                color:
                AppColors.textSecondary,
                size: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // SAVE CARD
  // ============================================================

  Widget _buildSaveCardOption() {
    return InkWell(
      onTap: () {
        setState(() {
          saveCard = !saveCard;
        });
      },
      borderRadius:
      BorderRadius.circular(8),
      child: Row(
        children: [
          Checkbox(
            value: saveCard,
            activeColor: AppColors.orange,
            side: const BorderSide(
              color: Color(
                0xFF98A2B3,
              ),
            ),
            onChanged: (value) {
              setState(() {
                saveCard =
                    value ?? false;
              });
            },
          ),

          const Expanded(
            child: Text(
              'Save this card securely for future payments',
              style: TextStyle(
                color:
                AppColors.textPrimary,
                fontSize: 10.5,
                fontWeight:
                FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // FIXED BOTTOM BUTTON
  // ============================================================

  Widget _buildBottomPaymentBar() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        24,
        9,
        24,
        11,
      ),
      decoration: const BoxDecoration(
        color: Color(
          0xFFF7F9FC,
        ),
        border: Border(
          top: BorderSide(
            color: Color(
              0xFFE5EAF1,
            ),
          ),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton.icon(
          onPressed: _paySecurely,
          icon: const Icon(
            Icons.lock_rounded,
            size: 17,
          ),
          label: Text(
            'Pay \$${widget.amount.toStringAsFixed(2)} Securely',
            style: const TextStyle(
              fontSize: 14,
              fontWeight:
              FontWeight.w700,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor:
            AppColors.orange,
            foregroundColor:
            Colors.white,
            elevation: 0,
            shape:
            RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(
                10,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // LABEL
  // ============================================================

  Widget _buildLabel(
      String label,
      ) {
    return Text(
      label,
      style: const TextStyle(
        color: AppColors.textPrimary,
        fontSize: 11.5,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  // ============================================================
  // FIELD DECORATION
  // ============================================================

  InputDecoration _inputDecoration({
    required String hint,
    required IconData prefixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Color(
          0xFF98A2B3,
        ),
        fontSize: 12,
      ),
      filled: true,
      fillColor: Colors.white,
      prefixIcon: Icon(
        prefixIcon,
        color: AppColors.navy,
        size: 18,
      ),
      isDense: true,
      contentPadding:
      const EdgeInsets.symmetric(
        horizontal: 13,
        vertical: 14,
      ),
      border: OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(
          10,
        ),
        borderSide: const BorderSide(
          color: Color(
            0xFFDCE3ED,
          ),
        ),
      ),
      enabledBorder:
      OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(
          10,
        ),
        borderSide: const BorderSide(
          color: Color(
            0xFFDCE3ED,
          ),
        ),
      ),
      focusedBorder:
      OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(
          10,
        ),
        borderSide: const BorderSide(
          color: AppColors.orange,
          width: 1.4,
        ),
      ),
    );
  }
}

// ============================================================
// CARD NUMBER FORMATTER
// ============================================================

class CardNumberFormatter
    extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    String digits =
    newValue.text.replaceAll(
      ' ',
      '',
    );

    if (digits.length > 16) {
      digits =
          digits.substring(
            0,
            16,
          );
    }

    final buffer =
    StringBuffer();

    for (
    int i = 0;
    i < digits.length;
    i++
    ) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' ');
      }

      buffer.write(
        digits[i],
      );
    }

    final result =
    buffer.toString();

    return TextEditingValue(
      text: result,
      selection:
      TextSelection.collapsed(
        offset: result.length,
      ),
    );
  }
}

// ============================================================
// EXPIRY FORMATTER
// ============================================================

class ExpiryDateFormatter
    extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    String digits =
    newValue.text.replaceAll(
      '/',
      '',
    );

    if (digits.length > 4) {
      digits =
          digits.substring(
            0,
            4,
          );
    }

    String result = digits;

    if (digits.length >= 3) {
      result =
      '${digits.substring(0, 2)}/${digits.substring(2)}';
    }

    return TextEditingValue(
      text: result,
      selection:
      TextSelection.collapsed(
        offset: result.length,
      ),
    );
  }
}