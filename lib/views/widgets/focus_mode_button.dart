import 'package:flutter/material.dart';

class FocusModeButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isActive;

  const FocusModeButton({
    super.key,
    required this.onPressed,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2E7D7D), // Cor de fundo
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        minimumSize: const Size(double.infinity, 60), // Largura total
      ),
      child: Text(
        isActive ? 'Foco Mode - On' : 'Foco Mode',
        style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}