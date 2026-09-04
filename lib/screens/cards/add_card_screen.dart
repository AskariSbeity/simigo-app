import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';
import 'cards_screen.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() =>
      _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final nicknameController =
  TextEditingController();

  final nameController =
  TextEditingController();

  final cardController =
  TextEditingController();

  final expiryController =
  TextEditingController();

  final cvvController =
  TextEditingController();

  bool setDefault = false;
  bool hideCvv = true;

  @override
  void dispose() {
    nicknameController.dispose();
    nameController.dispose();
    cardController.dispose();
    expiryController.dispose();
    cvvController.dispose();

    super.dispose();
  }

  void _addCard() {
    FocusScope.of(context).unfocus();

    final nickname =
    nicknameController.text.trim();

    final name =
    nameController.text.trim();

    final cardNumber =
    cardController.text.replaceAll(
      ' ',
      '',
    );

    final expiry =
    expiryController.text.trim();

    final cvv =
    cvvController.text.trim();

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

    final lastFour =
    cardNumber.substring(12);

    final card = WalletCard(
      id: DateTime.now()
          .millisecondsSinceEpoch
          .toString(),
      type: _detectCardType(cardNumber),
      lastFour: lastFour,
      holder: name.toUpperCase(),
      expiry: expiry,
      nickname: nickname.isEmpty
          ? 'My Card'
          : nickname,
      startColor:
      const Color(0xFF00245E),
      endColor:
      const Color(0xFF0051A8),
      isDefault: setDefault,
    );

    Navigator.pop(
      context,
      card,
    );
  }

  String _detectCardType(
      String number,
      ) {
    if (number.startsWith('4')) {
      return 'VISA';
    }

    if (number.startsWith('5')) {
      return 'MASTERCARD';
    }

    return 'CARD';
  }

  void _showError(
      String message,
      ) {
    ScaffoldMessenger.of(context)
        .hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
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
                physics:
                const BouncingScrollPhysics(),
                keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior
                    .onDrag,
                padding:
                const EdgeInsets.fromLTRB(
                  20,
                  18,
                  20,
                  24,
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    _buildIntro(),

                    const SizedBox(height: 22),

                    _buildField(
                      title: 'Card Nickname',
                      hint:
                      'Personal Card',
                      controller:
                      nicknameController,
                      icon:
                      Icons.label_outline_rounded,
                    ),

                    const SizedBox(height: 15),

                    _buildField(
                      title:
                      'Cardholder Name',
                      hint: 'Name on card',
                      controller:
                      nameController,
                      icon:
                      Icons.person_outline_rounded,
                    ),

                    const SizedBox(height: 15),

                    _buildCardNumber(),

                    const SizedBox(height: 15),

                    Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child:
                          _buildExpiry(),
                        ),

                        const SizedBox(
                          width: 14,
                        ),

                        Expanded(
                          child: _buildCvv(),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    _buildDefaultOption(),

                    const SizedBox(height: 18),

                    _buildSecurityNotice(),

                    const SizedBox(height: 26),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child:
                      ElevatedButton.icon(
                        onPressed: _addCard,
                        icon: const Icon(
                          Icons
                              .add_card_rounded,
                          size: 19,
                        ),
                        label: const Text(
                          'Add Card',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight:
                            FontWeight.w700,
                          ),
                        ),
                        style:
                        ElevatedButton.styleFrom(
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
      padding:
      const EdgeInsets.fromLTRB(
        10,
        10,
        20,
        5,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color:
              AppColors.textPrimary,
            ),
          ),

          const Text(
            'Add New Card',
            style: TextStyle(
              color:
              AppColors.textPrimary,
              fontSize: 20,
              fontWeight:
              FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntro() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.navy,
        borderRadius:
        BorderRadius.circular(14),
      ),
      child: const Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor:
            AppColors.orange,
            child: Icon(
              Icons.credit_card_rounded,
              color: Colors.white,
            ),
          ),

          SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  'Connect a Card',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight:
                    FontWeight.w700,
                  ),
                ),

                SizedBox(height: 4),

                Text(
                  'Add a debit or credit card to your wallet.',
                  style: TextStyle(
                    color:
                    Color(0xFFD7E1F0),
                    fontSize: 9.5,
                  ),
                ),
              ],
            ),
          ),

          Icon(
            Icons.lock_outline_rounded,
            color: Colors.white,
            size: 18,
          ),
        ],
      ),
    );
  }

  Widget _buildField({
    required String title,
    required String hint,
    required TextEditingController
    controller,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        _label(title),

        const SizedBox(height: 7),

        TextField(
          controller: controller,
          decoration:
          _decoration(
            hint,
            icon,
          ),
        ),
      ],
    );
  }

  Widget _buildCardNumber() {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        _label('Card Number'),

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
            AddCardNumberFormatter(),
          ],
          decoration: _decoration(
            '1234 5678 9012 3456',
            Icons.credit_card_rounded,
          ),
        ),
      ],
    );
  }

  Widget _buildExpiry() {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        _label('Expiry Date'),

        const SizedBox(height: 7),

        TextField(
          controller:
          expiryController,
          keyboardType:
          TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter
                .digitsOnly,
            LengthLimitingTextInputFormatter(
              4,
            ),
            AddCardExpiryFormatter(),
          ],
          decoration: _decoration(
            'MM/YY',
            Icons
                .calendar_today_outlined,
          ),
        ),
      ],
    );
  }

  Widget _buildCvv() {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        _label('CVV'),

        const SizedBox(height: 7),

        TextField(
          controller: cvvController,
          obscureText: hideCvv,
          keyboardType:
          TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter
                .digitsOnly,
            LengthLimitingTextInputFormatter(
              4,
            ),
          ],
          decoration: _decoration(
            'CVV',
            Icons.lock_outline_rounded,
          ).copyWith(
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  hideCvv = !hideCvv;
                });
              },
              icon: Icon(
                hideCvv
                    ? Icons
                    .visibility_outlined
                    : Icons
                    .visibility_off_outlined,
                color: AppColors
                    .textSecondary,
                size: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDefaultOption() {
    return InkWell(
      onTap: () {
        setState(() {
          setDefault =
          !setDefault;
        });
      },
      child: Row(
        children: [
          Checkbox(
            value: setDefault,
            activeColor:
            AppColors.orange,
            onChanged: (value) {
              setState(() {
                setDefault =
                    value ?? false;
              });
            },
          ),

          const Expanded(
            child: Text(
              'Set as my default payment card',
              style: TextStyle(
                color:
                AppColors.textPrimary,
                fontSize: 11,
                fontWeight:
                FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityNotice() {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(
          0xFFF1F5FA,
        ),
        borderRadius:
        BorderRadius.circular(11),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.shield_outlined,
            color: AppColors.navy,
            size: 20,
          ),

          SizedBox(width: 10),

          Expanded(
            child: Text(
              'Your card details will be securely tokenized by the payment provider. Sensitive card data should never be stored directly in the app.',
              style: TextStyle(
                color:
                AppColors.textSecondary,
                fontSize: 9,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(
      String text,
      ) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.textPrimary,
        fontSize: 11.5,
        fontWeight:
        FontWeight.w600,
      ),
    );
  }

  InputDecoration _decoration(
      String hint,
      IconData icon,
      ) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Color(0xFF98A2B3),
        fontSize: 11,
      ),
      filled: true,
      fillColor: Colors.white,
      prefixIcon: Icon(
        icon,
        color: AppColors.navy,
        size: 18,
      ),
      enabledBorder:
      OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(10),
        borderSide:
        const BorderSide(
          color: AppColors.border,
        ),
      ),
      focusedBorder:
      OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(10),
        borderSide:
        const BorderSide(
          color: AppColors.orange,
          width: 1.4,
        ),
      ),
    );
  }
}

class AddCardNumberFormatter
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
          digits.substring(0, 16);
    }

    final buffer =
    StringBuffer();

    for (int i = 0;
    i < digits.length;
    i++) {
      if (i > 0 &&
          i % 4 == 0) {
        buffer.write(' ');
      }

      buffer.write(digits[i]);
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

class AddCardExpiryFormatter
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
          digits.substring(0, 4);
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