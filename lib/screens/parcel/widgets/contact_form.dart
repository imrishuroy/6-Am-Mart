import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/screens/parcel/cubit/parcel_cubit.dart';

final _textDecoration = InputDecoration(
  border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: Colors.grey.shade400)),
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: Colors.grey.shade400)),
  disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: Colors.grey.shade400)),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: Colors.grey.shade400)),
);

class ContactForm extends StatelessWidget {
  final bool isSender;
  const ContactForm({Key? key, required this.isSender}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final parcelCubit = context.read<ParcelCubit>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 20.0,
        ),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          //  mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 12.0),
            const Text(
              'Add Contact Details',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.9,
              ),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              onChanged: (value) =>
                  parcelCubit.mobileNumberChanged(value, isSender: isSender),
              validator: (value) {
                if (value!.length < 10 || value.length > 12) {
                  return 'Invalid mobile no.';
                }
                return null;
              },
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration:
                  _textDecoration.copyWith(hintText: '10-digit mobile number'),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              onChanged: (value) =>
                  parcelCubit.nameChanged(value, isSender: isSender),
              validator: (value) {
                if (value!.length < 3) {
                  return 'Name to short';
                }
                return null;
              },
              keyboardType: TextInputType.name,
              decoration: _textDecoration.copyWith(hintText: 'Contact name'),
            ),
            const SizedBox(height: 50.0),
            SizedBox(
              height: 50.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                child: const Text(
                  'Add Contact',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 15.5,
                    letterSpacing: 0.9,
                  ),
                ),
                onPressed: () {
                  final state = context.read<ParcelCubit>().state;
                  final Map<String, String?> data = {};
                  if (isSender) {
                    data['name'] = state.senderName;
                    data['phone'] = state.senderPhNo;
                  } else {
                    data['name'] = state.receiverName;
                    data['phone'] = state.receiverPhNo;
                  }
                  Navigator.of(context).pop(data);
                },
              ),
            ),
            const SizedBox(height: 20.0)
          ],
        ),
      ),
    );
  }
}
