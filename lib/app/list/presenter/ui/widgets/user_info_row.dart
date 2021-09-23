import 'package:flutter/material.dart';

class UserInfoRow extends StatelessWidget {
  final IconData icon;
  final String? text;
  const UserInfoRow({Key? key, required this.icon, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
          child: Icon(icon),
        ),
        Expanded(
          child: Text(
            text ?? '',
            overflow: TextOverflow.fade,
          ),
        ),
      ],
    );
  }
}
