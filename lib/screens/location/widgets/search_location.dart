import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import '/helpers/dimensions.dart';
import '/screens/parcel/location_search_dialog.dart';
import '/utils/utils.dart';

class SearchLocationWidget extends StatelessWidget {
  final GoogleMapController? mapController;
  final String? pickedAddress;
  final bool isEnabled;
  final bool isPickedUp;
  final String? hint;

  const SearchLocationWidget({
    super.key,
    this.mapController,
    required this.pickedAddress,
    this.isEnabled = false,
    this.isPickedUp = false,
    this.hint,
  });
  // const SearchLocationWidget({
  //   required this.mapController,
  //   required this.pickedAddress,
  //   required this.isEnabled,
  //   this.isPickedUp,
  //   this.hint,
  // });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (mapController != null) {
          await showDialog(
            context: context,
            builder: (context) {
              return LocationSearchDialog(
                isPickedUp: isPickedUp,
                mapController: mapController!,
              );
            },
          );
        }

        // Get.dialog(LocationSearchDialog(
        //     mapController: mapController, isPickedUp: isPickedUp));
        // if (isEnabled != null) {
        //   Get.find<ParcelController>().setIsPickedUp(isPickedUp, true);
        // }
      },
      child: Container(
        height: 50,
        padding:
            const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: 2,
            )

            // isEnabled != null
            //     ? Border.all(
            //         color: isEnabled
            //             ? Theme.of(context).primaryColor
            //             : Theme.of(context).disabledColor,
            //         width: isEnabled ? 2 : 1,
            //       )
            //     : null,
            ),
        child: Row(children: [
          Icon(
            Icons.location_on,
            size: 25,
            color: Theme.of(context).primaryColor,
            // (isEnabled == null || isEnabled)
            //     ? Theme.of(context).primaryColor
            //     : Theme.of(context).disabledColor,
          ),
          const SizedBox(width: Dimensions.paddingSizeExtraSmall),
          Expanded(
            child: (pickedAddress != null)
                ? Text(
                    pickedAddress ?? 'Search your place',
                    style: robotoRegular.copyWith(fontSize: 16.0),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                : Text(
                    hint ?? 'Search your place',
                    style: robotoRegular.copyWith(
                        fontSize: 16.0, color: Theme.of(context).hintColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
          ),
          const SizedBox(width: Dimensions.paddingSizeSmall),
          Icon(Icons.search,
              size: 25, color: Theme.of(context).textTheme.bodyText1?.color),
        ]),
      ),
    );
  }
}
