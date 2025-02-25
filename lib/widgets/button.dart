import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.label, this.onPressed});
  final String label;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 180,
        height: 42,
        child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all<Color>(Color(0xFF3BB476))),
            onPressed: onPressed,
            child: Text(
              label,
              style: const TextStyle(
                  fontSize: 18, fontFamily: 'Inter', color: Colors.white),
            )));
  }
}
