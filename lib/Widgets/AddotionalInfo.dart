import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddotionalInfo extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;

  const AddotionalInfo(this.icon, this.iconColor, this.label);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Icon(
          this.icon,
          color: this.iconColor,
          size: 20,
        ),
        SizedBox(width: 3),
        Text(this.label, style: TextStyle(color: this.iconColor)),
        SizedBox(width: 8,height: 20),
      ],
    );
  }
}
