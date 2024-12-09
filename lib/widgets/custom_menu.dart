import 'package:flutter/material.dart';

class CustomMenu extends StatelessWidget {
  final List<Map<String, dynamic>> categories;

  const CustomMenu({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: categories.map((category) {
        return Column(
          children: [
            InkWell(
              onTap: category['onTap'],
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  category['icon'],
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              category['label'],
              style: const TextStyle(fontSize: 12),
            ),
          ],
        );
      }).toList(),
    );
  }
}
