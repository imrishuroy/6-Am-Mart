import 'package:flutter/material.dart';
import '/screens/menu/menu_screen.dart';

class MenuBottomSheet extends StatefulWidget {
  const MenuBottomSheet({Key? key}) : super(key: key);

  @override
  State<MenuBottomSheet> createState() => _MenuBottomSheetState();
}

class _MenuBottomSheetState extends State<MenuBottomSheet> {
  @override
  void initState() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return const MenuScreen();
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
