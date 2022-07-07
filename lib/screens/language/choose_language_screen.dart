import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:six_am_mart/widgets/loading_indicator.dart';
import '/blocs/localization/localization_cubit.dart';
import '/constants/app_constants.dart';
import '/helpers/dimensions.dart';
import '/helpers/responsive_helper.dart';
import '/translations/locale_keys.g.dart';
import '/utils/utils.dart';
import '/widgets/custom_appbar.dart';
import '/widgets/custom_button.dart';
import '/widgets/footer_view.dart';
import '/widgets/menu_drawer.dart';
import '/widgets/show_snakbar.dart';
import 'widget/language_widget.dart';

class ChooseLanguageScreen extends StatefulWidget {
  static const String routeName = '/chooseLang';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const ChooseLanguageScreen(),
    );
  }

  final bool fromMenu;
  const ChooseLanguageScreen({Key? key, this.fromMenu = false})
      : super(key: key);

  @override
  State<ChooseLanguageScreen> createState() => _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {
  @override
  void initState() {
    context.read<LocalizationCubit>().loadCurrentLanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (widget.fromMenu || ResponsiveHelper.isDesktop(context))
          ? CustomAppBar(title: LocaleKeys.language.tr(), backButton: true)
          : null,
      endDrawer: const MenuDrawer(),
      body: SafeArea(
        child: BlocConsumer<LocalizationCubit, LocalizationState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state.status == LocalizationStatus.loading) {
              return const LoadingIndicator();
            }
            return Column(
              children: [
                Expanded(
                    child: Center(
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: ResponsiveHelper.isDesktop(context)
                          ? EdgeInsets.zero
                          : const EdgeInsets.all(Dimensions.paddingSizeLarge),
                      child: Center(
                          child: FooterView(
                        minHeight: 0.615,
                        child: SizedBox(
                          width: Dimensions.webMaxWidth,
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                    child:
                                        Image.asset(Images.logo, width: 200)),
                                // Center(child: Text(AppConstants.APP_NAME, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge))),
                                const SizedBox(height: 30),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: Dimensions.paddingSizeSmall),
                                  child: Text(LocaleKeys.select_language.tr(),
                                      style: robotoMedium),
                                ),
                                const SizedBox(
                                    height: Dimensions.paddingSizeSmall),

                                GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        ResponsiveHelper.isDesktop(context)
                                            ? 4
                                            : ResponsiveHelper.isTab(context)
                                                ? 3
                                                : 2,
                                    childAspectRatio: (1 / 1),
                                  ),
                                  itemCount: state.languages.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) =>
                                      LanguageWidget(
                                    languageModel: state.languages[index],
                                    index: index,
                                  ),
                                ),
                                const SizedBox(
                                    height: Dimensions.paddingSizeLarge),

                                Text(LocaleKeys.you_can_change_language.tr(),
                                    style: robotoRegular.copyWith(
                                      fontSize: Dimensions.fontSizeSmall,
                                      color: Theme.of(context).disabledColor,
                                    )),

                                ResponsiveHelper.isDesktop(context)
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            top: Dimensions.paddingSizeLarge),
                                        child: LanguageSaveButton(
                                          fromMenu: widget.fromMenu,
                                          localizationCubit:
                                              context.read<LocalizationCubit>(),
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ]),
                        ),
                      )),
                    ),
                  ),
                )),
                ResponsiveHelper.isDesktop(context)
                    ? const SizedBox.shrink()
                    : LanguageSaveButton(
                        localizationCubit: context.read<LocalizationCubit>(),
                        fromMenu: widget.fromMenu,
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class LanguageSaveButton extends StatelessWidget {
  final LocalizationCubit localizationCubit;
  final bool fromMenu;
  const LanguageSaveButton(
      {Key? key, required this.localizationCubit, required this.fromMenu})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      buttonText: LocaleKeys.save.tr(),
      margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      onPressed: () {
        print('${localizationCubit.state.selectedIndex}');
        if (localizationCubit.state.selectedIndex == 0) {
          context.setLocale(const Locale('en'));

          print(context.locale.toString());
        } else {
          context.setLocale(const Locale('ar'));

          print(context.locale.toString());
        }
        if (localizationCubit.state.languages.isNotEmpty &&
            localizationCubit.state.selectedIndex != -1) {
          localizationCubit.setLanguage(Locale(
            AppConstants
                .languages[localizationCubit.state.selectedIndex].languageCode,
            AppConstants
                .languages[localizationCubit.state.selectedIndex].countryCode,
          ));

          if (fromMenu) {
            Navigator.pop(context);
          } else {
            //
            //Get.offNamed(RouteHelper.getOnBoardingRoute());
          }
        } else {
          ShowSnackBar.showSnackBar(context,
              title: LocaleKeys.select_a_language.tr());
        }
      },
    );
  }
}
