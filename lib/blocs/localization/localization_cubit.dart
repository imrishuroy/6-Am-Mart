import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/config/shared_prefs.dart';
import '/constants/app_constants.dart';
import '/models/failure.dart';
import '/models/language_model.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit() : super(LocalizationState.initial());

  void setLanguage(Locale locale) {
    emit(state.copyWith(locale: locale));

    if (state.locale.languageCode == 'ar') {
      emit(state.copyWith(isLtr: false));
    } else {
      emit(state.copyWith(isLtr: true));
    }

    saveLanguage(locale);
    // HomeScreen.loadData(true);
    // update();
  }

  void loadCurrentLanguage() async {
    final languageCode =
        await SharedPrefs().getStringValue(key: AppConstants.languageCode);
    final countryCode =
        await SharedPrefs().getStringValue(key: AppConstants.languageCode);
    if (languageCode != null && countryCode != null) {
      emit(state.copyWith(locale: Locale(languageCode, countryCode)));
    }

    emit(state.copyWith(isLtr: state.locale.languageCode != 'ar'));

    for (int index = 0; index < AppConstants.languages.length; index++) {
      if (AppConstants.languages[index].languageCode ==
          state.locale.languageCode) {
        emit(state.copyWith(selectedIndex: index));

        break;
      }
    }

    emit(state.copyWith(languages: AppConstants.languages));
  }

  void saveLanguage(Locale locale) async {
    SharedPrefs().setStringValue(
        key: AppConstants.languageCode, value: locale.languageCode);

    if (locale.countryCode != null) {
      SharedPrefs().setStringValue(
          key: AppConstants.countryCode, value: locale.countryCode!);
    }
  }

  void setSelectIndex(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  void searchLanguage(String query) {
    if (query.isEmpty) {
      emit(state.copyWith(languages: AppConstants.languages));
    } else {
      emit(state.copyWith(selectedIndex: -1, languages: []));

      AppConstants.languages.forEach((language) async {
        if (language.languageName.toLowerCase().contains(query.toLowerCase())) {
          emit(state.copyWith(
              languages: List.from(state.languages)..add(language)));
        }
      });
    }
  }
}
