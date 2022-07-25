import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ProfileTile({
    Key key,
    this.icon,
    this.label,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 10.0),
            Text(
              label,
              style: const TextStyle(fontSize: 17.0),
            )
          ],
        ),
      ),
    );
  }
}
