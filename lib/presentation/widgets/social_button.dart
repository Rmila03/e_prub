import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String imagePath;
  final VoidCallback onPressed;

  const SocialButton({
    super.key,
    required this.imagePath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: CircleAvatar(
        radius: 24,
        backgroundColor: Colors.white,
        child: Image.asset(
          imagePath,
          height: 28,
          width: 28,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
