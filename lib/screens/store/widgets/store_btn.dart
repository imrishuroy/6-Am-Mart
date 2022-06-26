import 'package:flutter/material.dart';

class StoreButton extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final Color backColor;
  final Function() onPress;

  const StoreButton({
    Key? key,
    required this.title,
    required this.width,
    required this.height,
    required this.backColor,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(28)),
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.all(0),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(backColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28.0),
            ),
          ),
        ),
        onPressed: onPress,
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 10,
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
        ),
      ),
    );
  }
}
