import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final bool disabled;
  final String label;
  final void Function () onPressed;

  Button({ this.disabled, this.label, this.onPressed });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
          onPressed: onPressed,
          child: Text(label.toUpperCase()),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              disabled ?
                Theme.of(context).disabledColor :
                Theme.of(context).primaryColor
            )
          ),
      ),
    );
  }
}
