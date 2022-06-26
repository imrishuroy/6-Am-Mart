import 'package:flutter/material.dart';
import '/constants/constants.dart';

class ParcelTile extends StatelessWidget {
  final String labelText;
  final String iconText;
  final String? address;
  final String? name;
  final String? phoneNo;
  final bool isSender;
  final VoidCallback pickAddress;
  final VoidCallback pickContact;

  const ParcelTile({
    super.key,
    required this.labelText,
    required this.iconText,
    this.address,
    this.name,
    this.phoneNo,
    required this.isSender,
    required this.pickAddress,
    required this.pickContact,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 160.0,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 5.0,
        ),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: pickAddress,
              child: Row(
                children: [
                  Column(
                    children: [
                      if (!isSender) const SizedBox(height: 10.0),
                      if (!isSender)
                        Padding(
                          padding: EdgeInsets.only(top: isSender ? 0.0 : 2.0),
                          child: Container(
                            height: 10,
                            color: green,
                            width: 2.0,
                          ),
                        ),
                      Padding(
                        padding: EdgeInsets.only(top: isSender ? 20.0 : 0.0),
                        child: CircleAvatar(
                          radius: 13.0,
                          backgroundColor: green,
                          child: Center(
                            child: Text(
                              iconText,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 13.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      if (isSender)
                        Container(
                          height: 10,
                          color: green,
                          width: 2.0,
                        )
                    ],
                  ),
                  const SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: isSender ? 12 : 10.0),
                      Text(
                        labelText,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.only(left: 35.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: [
                      Expanded(
                        child: Text(address ?? ''),
                      ),
                      Icon(Icons.navigate_next, color: Colors.grey.shade500),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    phoneNo ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const Divider(thickness: 1.3),
                ],
              ),
            ),

            const SizedBox(height: 5.0),
            GestureDetector(
              onTap: pickContact,
              child: Row(
                children: [
                  Icon(
                    Icons.add_call,
                    color: Colors.grey.shade600,
                    size: 20.0,
                  ),
                  const SizedBox(width: 12.0),
                  const Text(
                    'Add Phone No.',
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 15.0),
          ],
        ),
      ),
    );
  }
}
