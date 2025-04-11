import 'package:flutter/material.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  final double strength;
  final String text;
  final Color color;

  const PasswordStrengthIndicator({
    super.key,
    required this.strength,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'قوة كلمة المرور:',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: strength,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(color),
          minHeight: 5,
          borderRadius: BorderRadius.circular(2.5),
        ),
      ],
    );
  }
}

