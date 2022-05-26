import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final String placeholder;
  final String defaultValue;
  final Function(String) onChange;
  final TextInputType type;
  final bool isFull;

  const CustomTextField({
    Key? key,
    required this.title,
    required this.placeholder,
    required this.onChange,
    this.defaultValue = '',
    this.isFull = false,
    this.type = TextInputType.text,
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
            width: isFull ? size.width : size.width * 0.845,
            child: TextField(
              // controller: new TextEditingController(text: widget.defaultValue)
              //   ..selection = TextSelection.fromPosition(
              //       new TextPosition(offset: widget.defaultValue.length)),
              onChanged: onChange,
              keyboardType: type,
              textCapitalization: TextCapitalization.sentences,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Color.fromRGBO(0, 0, 0, 1)),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0),
                border: InputBorder.none,
                hintStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Color.fromRGBO(136, 136, 126, 0.26)),
                hintText: placeholder,
              ),
            ),
          )
        ],
      ),
    );
  }
}
