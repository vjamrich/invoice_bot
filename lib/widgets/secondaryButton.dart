import 'package:flutter/material.dart';
import 'package:invoice_bot/utils/theme.dart' as theme;


class SecondaryButton extends StatelessWidget {

  final Function? onPressed;
  final Widget child;

  const SecondaryButton({
    this.onPressed,
    required this.child,
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => onPressed?.call(),
      style: ButtonStyle(
          overlayColor: MaterialStatePropertyAll(theme.accentSecondaryColor.withOpacity(0.05)),
          elevation: const MaterialStatePropertyAll(0.0),
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: theme.borderRadius))
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }
}
