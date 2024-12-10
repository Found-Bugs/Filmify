import 'package:flutter/material.dart';

class CustomMenuProfile extends StatelessWidget {
  final IconData icon;
  final String text;
  final String? trailingText;
  final Color? textColor;
  final VoidCallback? onTap;

  const CustomMenuProfile({
    super.key,
    required this.icon,
    required this.text,
    this.trailingText,
    this.textColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, size: 24, color: textColor ?? Colors.black),
                  const SizedBox(width: 16),
                  Text(
                    text,
                    style: TextStyle(
                        color: textColor ?? Colors.black, fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
