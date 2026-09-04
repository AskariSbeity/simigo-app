import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: AppTextStyles.label,
        ),

        const SizedBox(height: 8),

        TextField(
          controller: widget.controller,
          obscureText: obscureText,
          keyboardType: widget.keyboardType,
          style: AppTextStyles.body,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: AppTextStyles.body.copyWith(
              color: AppColors.textSecondary,
              fontSize: 13,
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
              icon: Icon(
                obscureText
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                size: 20,
                color: AppColors.textSecondary,
              ),
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
            )
                : null,
          ),
        ),
      ],
    );
  }
}