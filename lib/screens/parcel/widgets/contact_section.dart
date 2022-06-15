import 'package:flutter/material.dart';

class AddressSection extends StatelessWidget {
  final String? address;
  final String? phNo;
  final String? contactPersonName;

  const AddressSection({
    super.key,
    this.address,
    this.phNo,
    this.contactPersonName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(contactPersonName ?? ''),
        const SizedBox(height: 5.0),
        Text(address ?? ''),
        const SizedBox(height: 5.0),
        Text(phNo ?? '')
      ],
    );
  }
}
