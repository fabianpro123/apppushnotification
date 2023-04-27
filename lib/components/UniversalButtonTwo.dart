import 'package:flutter/material.dart';

class UniversalButtonTwo extends StatelessWidget {
  final String buttonText;
  final Function()? onPressed;
  final Color? textColor;
  final Color? buttonColor;

  const UniversalButtonTwo({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    this.textColor,
    this.buttonColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: buttonColor ?? const Color.fromRGBO(19, 44, 89, 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              color: textColor ?? Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
