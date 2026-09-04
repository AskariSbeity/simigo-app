import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'add_card_screen.dart';
import 'card_details_screen.dart';

class WalletCard {
  final String id;
  final String type;
  final String lastFour;
  final String holder;
  final String expiry;
  final String nickname;
  final Color startColor;
  final Color endColor;

  bool isDefault;
  bool isFrozen;

  WalletCard({
    required this.id,
    required this.type,
    required this.lastFour,
    required this.holder,
    required this.expiry,
    required this.nickname,
    required this.startColor,
    required this.endColor,
    this.isDefault = false,
    this.isFrozen = false,
  });
}

class CardsScreen extends StatefulWidget {
  const CardsScreen({super.key});

  @override
  State<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  final List<WalletCard> cards = [
    WalletCard(
      id: '1',
      type: 'VISA',
      lastFour: '4242',
      holder: 'JOHN DOE',
      expiry: '08/29',
      nickname: 'Personal Card',
      startColor: const Color(0xFF00245E),
      endColor: const Color(0xFF0051A8),
      isDefault: true,
    ),
    WalletCard(
      id: '2',
      type: 'MASTERCARD',
      lastFour: '8891',
      holder: 'JOHN DOE',
      expiry: '11/28',
      nickname: 'Work Card',
      startColor: const Color(0xFF161B26),
      endColor: const Color(0xFF344054),
    ),
  ];

  Future<void> _openAddCard() async {
    final newCard = await Navigator.push<WalletCard>(
      context,
      MaterialPageRoute(
        builder: (_) => const AddCardScreen(),
      ),
    );

    if (newCard == null || !mounted) {
      return;
    }

    setState(() {
      // If the newly added card is selected as default,
      // remove default status from every other card.
      if (newCard.isDefault) {
        for (final card in cards) {
          card.isDefault = false;
        }
      }

      // If this is the first card in the wallet,
      // automatically make it the default card.
      if (cards.isEmpty) {
        newCard.isDefault = true;
      }

      cards.add(newCard);
    });

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          newCard.isDefault
              ? 'Card added and set as default'
              : 'Card added successfully',
        ),
        backgroundColor: AppColors.navy,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Future<void> _openCardDetails(
      WalletCard card,
      ) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CardDetailsScreen(
          card: card,

          // -------------------------------------------------------
          // SET DEFAULT
          // -------------------------------------------------------
          onDefaultChanged: () {
            setState(() {
              for (final item in cards) {
                item.isDefault = item.id == card.id;
              }
            });
          },

          // -------------------------------------------------------
          // FREEZE / UNFREEZE
          // -------------------------------------------------------
          onFrozenChanged: (value) {
            setState(() {
              card.isFrozen = value;
            });
          },

          // -------------------------------------------------------
          // REMOVE CARD
          // -------------------------------------------------------
          onRemove: () {
            setState(() {
              final wasDefault = card.isDefault;

              cards.removeWhere(
                    (item) => item.id == card.id,
              );

              // If the removed card was the default,
              // automatically make the first remaining card default.
              if (cards.isNotEmpty &&
                  (wasDefault ||
                      !cards.any(
                            (item) => item.isDefault,
                      ))) {
                for (final item in cards) {
                  item.isDefault = false;
                }

                cards.first.isDefault = true;
              }
            });
          },
        ),
      ),
    );

    if (mounted) {
      setState(() {});
    }
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
              child: cards.isEmpty
                  ? _buildEmptyState()
                  : _buildCardsList(),
            ),
          ],
        ),
      ),

      floatingActionButton: cards.isEmpty
          ? null
          : FloatingActionButton(
        onPressed: _openAddCard,
        backgroundColor: AppColors.orange,
        foregroundColor: Colors.white,
        elevation: 3,
        child: const Icon(
          Icons.add_rounded,
        ),
      ),
    );
  }

  // =========================================================
  // HEADER
  // =========================================================

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        10,
        10,
        20,
        6,
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
            ),
          ),

          const SizedBox(width: 3),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Cards',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Manage your payment cards',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 9.5,
                  ),
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: _openAddCard,
            icon: const Icon(
              Icons.add_circle_outline_rounded,
              color: AppColors.orange,
              size: 25,
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // CARDS LIST
  // =========================================================

  Widget _buildCardsList() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(
        20,
        18,
        20,
        100,
      ),
      children: [
        _buildSecurityBanner(),

        const SizedBox(height: 22),

        const Text(
          'Your Cards',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 14),

        ...cards.map(
              (card) => Padding(
            padding: const EdgeInsets.only(
              bottom: 18,
            ),
            child: _WalletCardWidget(
              card: card,
              onTap: () {
                _openCardDetails(card);
              },
            ),
          ),
        ),

        const SizedBox(height: 2),

        _buildAddCardButton(),
      ],
    );
  }

  // =========================================================
  // SECURITY BANNER
  // =========================================================

  Widget _buildSecurityBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5FA),
        borderRadius: BorderRadius.circular(11),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.shield_outlined,
            color: AppColors.navy,
            size: 19,
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              '${cards.length} '
                  '${cards.length == 1 ? 'card' : 'cards'} '
                  'connected to your wallet',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          const Icon(
            Icons.lock_outline_rounded,
            color: AppColors.navy,
            size: 16,
          ),
        ],
      ),
    );
  }

  // =========================================================
  // ADD CARD BUTTON
  // =========================================================

  Widget _buildAddCardButton() {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: _openAddCard,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          height: 70,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: const Color(0xFFDCE3ED),
            ),
          ),
          child: const Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Color(0xFFFFF2E8),
                child: Icon(
                  Icons.add_rounded,
                  color: AppColors.orange,
                ),
              ),

              SizedBox(width: 13),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add New Card',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    SizedBox(height: 3),

                    Text(
                      'Connect another payment card',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 9,
                      ),
                    ),
                  ],
                ),
              ),

              Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFF98A2B3),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================
  // EMPTY STATE
  // =========================================================

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 82,
              height: 82,
              decoration: const BoxDecoration(
                color: Color(0xFFF0F4F9),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.credit_card_off_outlined,
                color: AppColors.navy,
                size: 38,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'No Cards Yet',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 19,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Add a payment card to make wallet payments '
                  'faster and easier.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 10.5,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: 190,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: _openAddCard,
                icon: const Icon(
                  Icons.add_rounded,
                ),
                label: const Text(
                  'Add Your First Card',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
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
    );
  }
}

// ===========================================================
// WALLET CARD
// ===========================================================

class _WalletCardWidget extends StatelessWidget {
  final WalletCard card;
  final VoidCallback onTap;

  const _WalletCardWidget({
    required this.card,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedOpacity(
        duration: const Duration(
          milliseconds: 180,
        ),
        opacity: card.isFrozen ? 0.72 : 1,
        child: Container(
          width: double.infinity,
          height: 205,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                card.startColor,
                card.endColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: card.startColor.withOpacity(0.20),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------------------------------------------------
              // TOP
              // ---------------------------------------------------

              Row(
                children: [
                  Container(
                    constraints: const BoxConstraints(
                      maxWidth: 150,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.13),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Text(
                      card.nickname,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const Spacer(),

                  if (card.isDefault)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.orange,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: const Text(
                        'DEFAULT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 7,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                  if (card.isFrozen) ...[
                    const SizedBox(width: 7),

                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.14),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.ac_unit_rounded,
                        color: Colors.white,
                        size: 13,
                      ),
                    ),
                  ],
                ],
              ),

              const SizedBox(height: 17),

              // ---------------------------------------------------
              // CHIP / CONTACTLESS
              // ---------------------------------------------------

              Row(
                children: [
                  _buildChip(),

                  const Spacer(),

                  const Icon(
                    Icons.contactless_rounded,
                    color: Colors.white,
                    size: 27,
                  ),
                ],
              ),

              const Spacer(),

              // ---------------------------------------------------
              // CARD NUMBER
              // ---------------------------------------------------

              Text(
                '••••  ••••  ••••  ${card.lastFour}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  letterSpacing: 1.8,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const Spacer(),

              // ---------------------------------------------------
              // BOTTOM INFORMATION
              // ---------------------------------------------------

              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'CARD HOLDER',
                          style: TextStyle(
                            color: Color(0xFFCAD5E6),
                            fontSize: 7,
                          ),
                        ),

                        const SizedBox(height: 3),

                        Text(
                          card.holder,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 12),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'EXPIRES',
                        style: TextStyle(
                          color: Color(0xFFCAD5E6),
                          fontSize: 7,
                        ),
                      ),

                      const SizedBox(height: 3),

                      Text(
                        card.expiry,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(width: 22),

                  Text(
                    card.type,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip() {
    return Container(
      width: 42,
      height: 30,
      decoration: BoxDecoration(
        color: const Color(0xFFEACB75),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 13,
            top: 0,
            bottom: 0,
            child: Container(
              width: 1,
              color: const Color(0xFFB99A4B),
            ),
          ),
          Positioned(
            right: 13,
            top: 0,
            bottom: 0,
            child: Container(
              width: 1,
              color: const Color(0xFFB99A4B),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 14,
            child: Container(
              height: 1,
              color: const Color(0xFFB99A4B),
            ),
          ),
        ],
      ),
    );
  }
}