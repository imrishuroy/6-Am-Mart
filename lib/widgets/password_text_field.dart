import 'package:flutter/material.dart';

class PasswordInput extends StatelessWidget {
  final String title;
  final Function(String) onChange;

  final bool isPassword;

  const PasswordInput(
      {super.key,
      required this.title,
      required this.onChange,
      required this.isPassword});

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
                color: Color.fromRGBO(0, 0, 0, 1)),
          ),
          SizedBox(
            width: size.width * 0.845,
            child: TextField(
              //controller: widget.controller,
              onChanged: onChange,
              textAlignVertical: TextAlignVertical.center,
              obscureText: isPassword,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0),
                border: InputBorder.none,
                suffixIcon: IconButton(
                  onPressed: () {
                    // setState(() {
                    //   isObscureText = !isObscureText;
                    // });
                  },
                  icon: const Icon(Icons.visibility_off),
                ),
                hintStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Color.fromRGBO(136, 136, 126, 0.26)),
                hintText: ' * * * * * * * * * ',
              ),
            ),
          )
        ],
      ),
    );
  }
}
