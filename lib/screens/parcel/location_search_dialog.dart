import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '/helpers/dimensions.dart';
import '/models/prediction_model.dart';
import '/repositories/location/location_repository.dart';

class LocationSearchDialog extends StatefulWidget {
  final GoogleMapController mapController;
  final bool isPickedUp;
  const LocationSearchDialog({
    Key? key,
    required this.mapController,
    this.isPickedUp = false,
  }) : super(key: key);

  @override
  State<LocationSearchDialog> createState() => _LocationSearchDialogState();
}

class _LocationSearchDialogState extends State<LocationSearchDialog> {
  @override
  Widget build(BuildContext context) {
    //final TextEditingController _controller = TextEditingController();

    return Container(
      //  margin: EdgeInsets.only(top: ResponsiveHelper.isWeb() ? 80 : 0),
      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      alignment: Alignment.topCenter,
      child: Material(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
        child: SizedBox(
          width: Dimensions.webMaxWidth,
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              // controller: _controller,
              textInputAction: TextInputAction.search,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.streetAddress,
              decoration: InputDecoration(
                hintText: 'Search Location',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(style: BorderStyle.none, width: 0),
                ),
                hintStyle: Theme.of(context).textTheme.headline2?.copyWith(
                      fontSize: 14.0,
                      color: Theme.of(context).disabledColor,
                    ),
                filled: true,
                fillColor: Theme.of(context).cardColor,
              ),
              style: Theme.of(context).textTheme.headline2?.copyWith(
                    color: Theme.of(context).textTheme.bodyText1?.color,
                    fontSize: 16.0,
                  ),
            ),
            suggestionsCallback: (pattern) async {
              return await context
                  .read<LocationRepository>()
                  .searchLocation(text: pattern);
              // return await Get.find<LocationController>().searchLocation(context, pattern);
            },
            itemBuilder: (context, PredictionModel? suggestion) {
              return Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                child: Row(children: [
                  const Icon(Icons.location_on),
                  Expanded(
                    child: Text(
                      suggestion?.description ?? 'N/A',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline2?.copyWith(
                            color: Theme.of(context).textTheme.bodyText1?.color,
                            fontSize: 16.0,
                          ),
                    ),
                  ),
                ]),
              );
            },
            onSuggestionSelected: (PredictionModel? suggestion) async {
              print('Picked place -- ${suggestion?.placeId}');
              if (suggestion?.placeId != null) {
                final latLng = await context
                    .read<LocationRepository>()
                    .getPlaceDetails(placeId: suggestion!.placeId!);
                if (latLng != null) {
                  widget.mapController.animateCamera(CameraUpdate.newLatLng(
                      LatLng(latLng.latitude, latLng.longitude)));
                }
              }

              // dismissing the pop up

              // if (isPickedUp == null) {
              //   // Get.find<LocationController>().setLocation(suggestion.placeId, suggestion.description, mapController);
              // } else {
              //   // Get.find<ParcelController>().setLocationFromPlace(suggestion.placeId, suggestion.description, isPickedUp);
              // }
              //Get.back();
              if (!mounted) return;

              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }
}
