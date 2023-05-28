import 'package:flutter/material.dart';
import 'package:invoice_bot/utils/theme.dart' as theme;


class PrimaryButton extends StatelessWidget {

  final Function? onPressed;
  final Widget child;

  const PrimaryButton({
    this.onPressed,
    required this.child,
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed?.call(),
      style: ButtonStyle(
          backgroundColor: const MaterialStatePropertyAll(theme.accentColor),
          overlayColor: MaterialStatePropertyAll(theme.textPrimaryColor.withOpacity(0.05)),
          elevation: const MaterialStatePropertyAll(0.0),
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: theme.borderRadius))
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SelectionContainer.disabled(child: child),
      ),
    );
  }
}
