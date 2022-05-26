import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(left: 14),
      width: size.width * 0.8,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 202, 202, 202),
              blurRadius: 1, // soften the shadow
              spreadRadius: 1.4, //extend the shadow
              offset: Offset(
                1, // Move to right 10  horizontally
                1.8, // Move to bottom 10 Vertically
              ),
            )
          ]),
      child: TextField(
        cursorColor: Colors.black87,
        decoration: InputDecoration(
            hintText: 'what you wish for ?',
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            suffixIcon: Icon(
              Icons.circle_outlined,
              color: Colors.black,
            )),
      ),
    );
  }
}
