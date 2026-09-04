import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'cards_screen.dart';

class CardDetailsScreen extends StatefulWidget {
  final WalletCard card;

  final VoidCallback onDefaultChanged;
  final ValueChanged<bool> onFrozenChanged;
  final VoidCallback onRemove;

  const CardDetailsScreen({
    super.key,
    required this.card,
    required this.onDefaultChanged,
    required this.onFrozenChanged,
    required this.onRemove,
  });

  @override
  State<CardDetailsScreen> createState() =>
      _CardDetailsScreenState();
}

class _CardDetailsScreenState
    extends State<CardDetailsScreen> {
  WalletCard get card =>
      widget.card;

  void _toggleFreeze() {
    final value =
    !card.isFrozen;

    widget.onFrozenChanged(value);

    setState(() {
      card.isFrozen = value;
    });

    ScaffoldMessenger.of(context)
        .hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          value
              ? 'Card frozen'
              : 'Card unfrozen',
        ),
        backgroundColor:
        AppColors.navy,
        behavior:
        SnackBarBehavior.floating,
      ),
    );
  }

  void _makeDefault() {
    if (card.isDefault) {
      return;
    }

    widget.onDefaultChanged();

    setState(() {
      card.isDefault = true;
    });

    ScaffoldMessenger.of(context)
        .hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Default card updated',
        ),
        backgroundColor:
        AppColors.navy,
        behavior:
        SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _removeCard() async {
    final remove =
    await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor:
          Colors.transparent,
          child: Container(
            padding:
            const EdgeInsets.fromLTRB(
              22,
              24,
              22,
              20,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.circular(
                18,
              ),
            ),
            child: Column(
              mainAxisSize:
              MainAxisSize.min,
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration:
                  const BoxDecoration(
                    color:
                    Color(0xFFFFF0E8),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons
                        .delete_outline_rounded,
                    color:
                    AppColors.orange,
                    size: 27,
                  ),
                ),

                const SizedBox(height: 17),

                const Text(
                  'Remove Card?',
                  style: TextStyle(
                    color: AppColors
                        .textPrimary,
                    fontSize: 18,
                    fontWeight:
                    FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'Are you sure you want to remove the card ending in ${card.lastFour}?',
                  textAlign:
                  TextAlign.center,
                  style: const TextStyle(
                    color: AppColors
                        .textSecondary,
                    fontSize: 10.5,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 22),

                Row(
                  children: [
                    Expanded(
                      child:
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pop(
                            dialogContext,
                            false,
                          );
                        },
                        style:
                        OutlinedButton
                            .styleFrom(
                          foregroundColor:
                          AppColors
                              .textPrimary,
                          side:
                          const BorderSide(
                            color:
                            AppColors
                                .border,
                          ),
                          minimumSize:
                          const Size(
                            0,
                            46,
                          ),
                        ),
                        child:
                        const Text(
                          'Cancel',
                        ),
                      ),
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    Expanded(
                      child:
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(
                            dialogContext,
                            true,
                          );
                        },
                        style:
                        ElevatedButton
                            .styleFrom(
                          backgroundColor:
                          AppColors
                              .error,
                          foregroundColor:
                          Colors.white,
                          elevation: 0,
                          minimumSize:
                          const Size(
                            0,
                            46,
                          ),
                        ),
                        child:
                        const Text(
                          'Remove',
                          style: TextStyle(
                            fontWeight:
                            FontWeight
                                .w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    if (remove != true ||
        !mounted) {
      return;
    }

    widget.onRemove();

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),

            Expanded(
              child:
              SingleChildScrollView(
                physics:
                const BouncingScrollPhysics(),
                padding:
                const EdgeInsets.fromLTRB(
                  20,
                  18,
                  20,
                  30,
                ),
                child: Column(
                  children: [
                    _buildCard(),

                    const SizedBox(
                      height: 24,
                    ),

                    _buildStatus(),

                    const SizedBox(
                      height: 22,
                    ),

                    _buildActions(),

                    const SizedBox(
                      height: 24,
                    ),

                    _buildInformation(),

                    const SizedBox(
                      height: 26,
                    ),

                    _buildRemoveButton(),
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
            'Card Details',
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

  Widget _buildCard() {
    return AnimatedOpacity(
      duration:
      const Duration(
        milliseconds: 180,
      ),
      opacity:
      card.isFrozen ? 0.7 : 1,
      child: Container(
        width: double.infinity,
        height: 205,
        padding:
        const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              card.startColor,
              card.endColor,
            ],
            begin:
            Alignment.topLeft,
            end:
            Alignment.bottomRight,
          ),
          borderRadius:
          BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: card.startColor
                  .withOpacity(0.2),
              blurRadius: 18,
              offset:
              const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  card.nickname,
                  style:
                  const TextStyle(
                    color:
                    Colors.white,
                    fontSize: 11,
                    fontWeight:
                    FontWeight.w600,
                  ),
                ),

                const Spacer(),

                if (card.isDefault)
                  Container(
                    padding:
                    const EdgeInsets
                        .symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    decoration:
                    BoxDecoration(
                      color:
                      AppColors.orange,
                      borderRadius:
                      BorderRadius
                          .circular(7),
                    ),
                    child:
                    const Text(
                      'DEFAULT',
                      style:
                      TextStyle(
                        color:
                        Colors.white,
                        fontSize: 7,
                        fontWeight:
                        FontWeight
                            .w700,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(
              height: 20,
            ),

            Row(
              children: [
                Container(
                  width: 42,
                  height: 30,
                  decoration:
                  BoxDecoration(
                    color:
                    const Color(
                      0xFFEACB75,
                    ),
                    borderRadius:
                    BorderRadius
                        .circular(7),
                  ),
                ),

                const Spacer(),

                const Icon(
                  Icons
                      .contactless_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ],
            ),

            const Spacer(),

            Text(
              '••••  ••••  ••••  ${card.lastFour}',
              style:
              const TextStyle(
                color: Colors.white,
                fontSize: 18,
                letterSpacing: 1.8,
                fontWeight:
                FontWeight.w600,
              ),
            ),

            const Spacer(),

            Row(
              children: [
                Expanded(
                  child: Text(
                    card.holder,
                    style:
                    const TextStyle(
                      color:
                      Colors.white,
                      fontSize: 10,
                      fontWeight:
                      FontWeight
                          .w600,
                    ),
                  ),
                ),

                Text(
                  card.expiry,
                  style:
                  const TextStyle(
                    color:
                    Colors.white,
                    fontSize: 10,
                    fontWeight:
                    FontWeight
                        .w600,
                  ),
                ),

                const SizedBox(
                  width: 22,
                ),

                Text(
                  card.type,
                  style:
                  const TextStyle(
                    color:
                    Colors.white,
                    fontSize: 14,
                    fontWeight:
                    FontWeight
                        .w800,
                    fontStyle:
                    FontStyle
                        .italic,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatus() {
    return Container(
      padding:
      const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(12),
        border: Border.all(
          color:
          const Color(
            0xFFE4E9F1,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration:
            BoxDecoration(
              color: card.isFrozen
                  ? const Color(
                0xFFF2F4F7,
              )
                  : const Color(
                0xFFECFDF3,
              ),
              shape:
              BoxShape.circle,
            ),
            child: Icon(
              card.isFrozen
                  ? Icons
                  .ac_unit_rounded
                  : Icons
                  .check_rounded,
              color: card.isFrozen
                  ? AppColors
                  .textSecondary
                  : AppColors
                  .success,
              size: 19,
            ),
          ),

          const SizedBox(
            width: 12,
          ),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment
                  .start,
              children: [
                Text(
                  card.isFrozen
                      ? 'Card Frozen'
                      : 'Card Active',
                  style:
                  const TextStyle(
                    color: AppColors
                        .textPrimary,
                    fontSize: 12,
                    fontWeight:
                    FontWeight
                        .w700,
                  ),
                ),

                const SizedBox(
                  height: 3,
                ),

                Text(
                  card.isFrozen
                      ? 'Payments are temporarily disabled'
                      : 'Your card is ready for payments',
                  style:
                  const TextStyle(
                    color: AppColors
                        .textSecondary,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    return Row(
      children: [
        Expanded(
          child: _ActionButton(
            icon: card.isFrozen
                ? Icons
                .lock_open_rounded
                : Icons
                .ac_unit_rounded,
            title: card.isFrozen
                ? 'Unfreeze'
                : 'Freeze',
            onTap: _toggleFreeze,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: _ActionButton(
            icon:
            Icons.star_outline_rounded,
            title: card.isDefault
                ? 'Default'
                : 'Make Default',
            selected:
            card.isDefault,
            onTap: _makeDefault,
          ),
        ),
      ],
    );
  }

  Widget _buildInformation() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(13),
        border: Border.all(
          color:
          const Color(
            0xFFE4E9F1,
          ),
        ),
      ),
      child: Column(
        children: [
          _InfoRow(
            label: 'Card Name',
            value: card.nickname,
          ),

          const Divider(
            height: 1,
            color:
            Color(0xFFF0F2F6),
          ),

          _InfoRow(
            label: 'Card Type',
            value: card.type,
          ),

          const Divider(
            height: 1,
            color:
            Color(0xFFF0F2F6),
          ),

          _InfoRow(
            label: 'Card Number',
            value:
            '•••• ${card.lastFour}',
          ),

          const Divider(
            height: 1,
            color:
            Color(0xFFF0F2F6),
          ),

          _InfoRow(
            label: 'Expires',
            value: card.expiry,
          ),
        ],
      ),
    );
  }

  Widget _buildRemoveButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton.icon(
        onPressed: _removeCard,
        icon: const Icon(
          Icons
              .delete_outline_rounded,
          size: 18,
        ),
        label: const Text(
          'Remove Card',
          style: TextStyle(
            fontWeight:
            FontWeight.w700,
          ),
        ),
        style:
        OutlinedButton.styleFrom(
          foregroundColor:
          AppColors.error,
          side: const BorderSide(
            color: AppColors.error,
          ),
          shape:
          RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(
              10,
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionButton
    extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool selected;

  const _ActionButton({
    required this.icon,
    required this.title,
    required this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected
          ? const Color(
        0xFFFFF5ED,
      )
          : Colors.white,
      borderRadius:
      BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius:
        BorderRadius.circular(12),
        child: Container(
          height: 82,
          decoration: BoxDecoration(
            borderRadius:
            BorderRadius.circular(
              12,
            ),
            border: Border.all(
              color: selected
                  ? AppColors.orange
                  : const Color(
                0xFFE4E9F1,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment:
            MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: selected
                    ? AppColors.orange
                    : AppColors.navy,
                size: 22,
              ),

              const SizedBox(
                height: 7,
              ),

              Text(
                title,
                style: TextStyle(
                  color: selected
                      ? AppColors.orange
                      : AppColors
                      .textPrimary,
                  fontSize: 10.5,
                  fontWeight:
                  FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow
    extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 14,
      ),
      child: Row(
        children: [
          Text(
            label,
            style:
            const TextStyle(
              color: AppColors
                  .textSecondary,
              fontSize: 10.5,
            ),
          ),

          const Spacer(),

          Text(
            value,
            style:
            const TextStyle(
              color: AppColors
                  .textPrimary,
              fontSize: 11,
              fontWeight:
              FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}