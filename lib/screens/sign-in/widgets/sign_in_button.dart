import 'package:flutter/material.dart';

class SignButton extends StatelessWidget {
  final String title;
  final Function() onClick;
  final bool loading;

  const SignButton(
      {Key? key,
      required this.title,
      required this.onClick,
      this.loading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: 56,
      width: size.width * 0.38,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(28)),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromRGBO(69, 165, 36, 1)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28.0),
            ),
          ),
        ),
        onPressed: !loading ? onClick : () => {},
        child: !loading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: size.width * 0.38 - 50,
                    alignment: Alignment.center,
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          height: 1,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Color.fromRGBO(255, 255, 255, 1)),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_right_alt,
                    color: Color.fromRGBO(255, 255, 255, 1),
                  )
                ],
              )
            : const SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
