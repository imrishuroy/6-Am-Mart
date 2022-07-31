import 'package:flutter/material.dart';

class MenuTile extends StatelessWidget {
  final IconData icon;
  final String iconImg;
  final String label;
  final VoidCallback onTap;

  const MenuTile({
    Key key,
    this.icon,
    this.label,
    this.iconImg,
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
            iconImg != null
                ? Image.asset(
                    iconImg,
                    width: 25.0,
                    height: 25.0,
                    color: Colors.black,
                  )
                : Icon(icon),
            const SizedBox(width: 12.0),
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
