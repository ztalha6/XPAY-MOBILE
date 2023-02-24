import 'package:flutter/material.dart';

class OutlineIconButton extends StatelessWidget {
  final Widget child;
  final Color? borderColor;
  final Function()? onPressed;
  final double? width;
  const OutlineIconButton({
    Key? key,
    required this.child,
    this.borderColor,
    this.onPressed,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: borderColor ?? Colors.black),
        shape: const RoundedRectangleBorder(),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: width ?? 10),
        child: child,
      ),
    );
  }
}
