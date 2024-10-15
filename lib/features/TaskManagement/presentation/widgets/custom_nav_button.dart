import 'package:flutter/material.dart';

class CustomNavButton extends StatelessWidget {
  final void Function()? onTap;
  final int state;
  final int index;
  final String text;
  const CustomNavButton({
    super.key,
    this.onTap,
    required this.state,
    required this.index,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 110,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          color: state == index
              ? const Color(0xff00CA5D)
              : const Color(0xFF00CA5D).withOpacity(0.1),
        ),
        child: Text(
          text,
          style: textStyle(state, index),
        ),
      ),
    );
  }
}

TextStyle textStyle(int state, int index) {
  return TextStyle(
    color: state == index ? Colors.white : Colors.green,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );
}
