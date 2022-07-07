import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/constants/app_constants.dart';
import '/helpers/dimensions.dart';
import '/utils/utils.dart';
import '/blocs/localization/localization_cubit.dart';
import '/models/language_model.dart';

class LanguageWidget extends StatelessWidget {
  final LanguageModel languageModel;

  final int index;
  const LanguageWidget({
    Key? key,
    required this.languageModel,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizationCubit = context.read<LocalizationCubit>();
    return InkWell(
      onTap: () {
        localizationCubit.setLanguage(
          Locale(
            AppConstants.languages[index].languageCode,
            AppConstants.languages[index].countryCode,
          ),
        );

        localizationCubit.setSelectIndex(index);
      },
      child: Container(
        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
        margin: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 5,
              spreadRadius: 1,
            )
          ],
        ),
        child: Stack(children: [
          Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                height: 65,
                width: 65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                  border: Border.all(
                    color: Theme.of(context).textTheme.bodyText1?.color ??
                        Colors.black,
                    width: 1,
                  ),
                ),
                alignment: Alignment.center,
                child: Image.asset(
                  languageModel.imageUrl,
                  width: 36,
                  height: 36,
                  color: languageModel.languageCode == 'en' ||
                          languageModel.languageCode == 'ar'
                      ? Theme.of(context).textTheme.bodyText1?.color
                      : null,
                ),
              ),
              const SizedBox(height: Dimensions.paddingSizeLarge),
              Text(languageModel.languageName, style: robotoRegular),
            ]),
          ),
          localizationCubit.state.selectedIndex == index
              ? Positioned(
                  top: 0,
                  right: 0,
                  child: Icon(Icons.check_circle,
                      color: Theme.of(context).primaryColor, size: 25),
                )
              : const SizedBox.shrink(),
        ]),
      ),
    );
  }
}
