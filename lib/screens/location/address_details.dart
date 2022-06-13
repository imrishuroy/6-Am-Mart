import 'package:flutter/material.dart';
import 'package:six_am_mart/utils/utils.dart';

import '/models/address_model.dart';

class AddressDetails extends StatelessWidget {
  final AddressModel addressDetails;
  const AddressDetails({
    Key? key,
    required this.addressDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('-------${addressDetails.toJson()}');
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            addressDetails.address ?? 'N/A',
            style: robotoRegular.copyWith(fontSize: 12.0),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 5),
          Wrap(children: [
            (addressDetails.streetNumber != null &&
                    addressDetails.streetNumber!.isNotEmpty)
                ? Text(
                    'Street Number : ${addressDetails.streetNumber ?? 'N/A'}',
                    style: robotoRegular.copyWith(fontSize: 10.0),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                : const SizedBox(),
            (addressDetails.house != null && addressDetails.house!.isNotEmpty)
                ? Text(
                    (addressDetails.streetNumber != null ? ', ' : '') +
                        'house' +
                        ': ' +
                        addressDetails.house!,
                    style: robotoRegular.copyWith(fontSize: 10.0),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                : const SizedBox(),
            (addressDetails.floor != null && addressDetails.floor!.isNotEmpty)
                ? Text(
                    ((addressDetails.streetNumber != null ||
                                addressDetails.house != null)
                            ? ', '
                            : '') +
                        'floor' +
                        ': ' +
                        addressDetails.floor!,
                    style: robotoRegular.copyWith(fontSize: 10.0),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                : SizedBox(),
          ]),
        ]);
  }
}
