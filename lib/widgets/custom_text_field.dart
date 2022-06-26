import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final String hintText;
  final String defaultValue;
  final Function(String) onChange;
  final TextInputType type;
  final bool isFull;
  final String? initialValue;
  final bool isPassowrdField;
  final Widget? suffixIcon;
  final String? Function(String? value) validator;
  final bool textAlignVerticle;

  const CustomTextField({
    Key? key,
    required this.title,
    required this.hintText,
    required this.onChange,
    this.defaultValue = '',
    this.isFull = false,
    this.type = TextInputType.text,
    this.initialValue,
    this.suffixIcon,
    this.isPassowrdField = false,
    required this.validator,
    this.textAlignVerticle = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: size.height * 0.023),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Color.fromRGBO(0, 0, 0, 1),
            ),
          ),
          SizedBox(
            width: size.width * 0.845,
            //width: isFull ? size.width : size.width * 0.845,
            child: TextFormField(
              initialValue: initialValue,
              obscureText: isPassowrdField,
              textAlignVertical:
                  textAlignVerticle ? TextAlignVertical.center : null,
              // textAlignVertical:
              //     isPassowrdField ? TextAlignVertical.center : null,
              validator: validator,
              onChanged: onChange,
              keyboardType: type,
              textCapitalization: TextCapitalization.sentences,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Color.fromRGBO(0, 0, 0, 1)),
              decoration: InputDecoration(
                suffixIcon: suffixIcon,
                contentPadding: const EdgeInsets.all(0),
                border: InputBorder.none,
                hintStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Color.fromRGBO(136, 136, 126, 0.26),
                ),
                hintText: hintText,
              ),
            ),
          )
        ],
      ),
    );
  }
}
