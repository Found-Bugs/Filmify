import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String fieldName; // Nama field
  final Color fieldNameColor; // Warna field name
  final String hintText; // Teks petunjuk
  final bool isPassword; // Apakah field ini untuk password
  final IconData? suffixIcon; // Ikon opsional di dalam field
  final BorderSide? borderSide; // Border opsional

  const CustomTextField({
    super.key,
    required this.fieldName,
    required this.fieldNameColor,
    required this.hintText,
    this.isPassword = false,
    this.suffixIcon,
    this.borderSide,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            fieldName,
            style: TextStyle(
              fontSize: 16,
              color: fieldNameColor, // Gunakan parameter warna
            ),
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          obscureText: isPassword,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.black45),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: borderSide ?? BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            suffixIcon: suffixIcon != null
                ? Icon(suffixIcon, color: Colors.grey)
                : null,
          ),
        ),
      ],
    );
  }
}
