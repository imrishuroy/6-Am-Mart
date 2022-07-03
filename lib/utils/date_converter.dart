import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '/blocs/config/app_config_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/translations/locale_keys.g.dart';

class DateConverter {
  static String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd hh:mm:ss a').format(dateTime);
  }

  static String dateToTimeOnly(DateTime dateTime,
      {required BuildContext context}) {
    return DateFormat(_timeFormatter(context)).format(dateTime);
  }

  static String dateToDateAndTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }

  static String dateTimeStringToDateTime(String dateTime,
      {required BuildContext context}) {
    return DateFormat('dd MMM yyyy  ${_timeFormatter(context)}')
        .format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime));
  }

  static String dateTimeStringToDateOnly(String dateTime) {
    return DateFormat('dd MMM yyyy')
        .format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime));
  }

  static DateTime dateTimeStringToDate(String dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime);
  }

  static DateTime isoStringToLocalDate(String dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').parse(dateTime);
  }

  static String isoStringToDateTimeString(String dateTime,
      {required BuildContext context}) {
    return DateFormat('dd MMM yyyy  ${_timeFormatter(context)}')
        .format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalDateOnly(String dateTime) {
    return DateFormat('dd MMM yyyy').format(isoStringToLocalDate(dateTime));
  }

  static String stringToLocalDateOnly(String dateTime) {
    return DateFormat('dd MMM yyyy')
        .format(DateFormat('yyyy-MM-dd').parse(dateTime));
  }

  static String localDateToIsoString(DateTime dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(dateTime);
  }

  static String convertTimeToTime(String time,
      {required BuildContext context}) {
    return DateFormat(_timeFormatter(context))
        .format(DateFormat('HH:mm').parse(time));
  }

  static DateTime convertStringTimeToDate(String time) {
    return DateFormat('HH:mm').parse(time);
  }

  static bool isAvailable(BuildContext context, String start, String end,
      {DateTime? time}) {
    DateTime currentTime;
    if (time != null) {
      currentTime = time;
    } else {
      currentTime = DateTime.now();
    }
    // ignore: unnecessary_null_comparison
    DateTime dateTimestart = start != null
        ? DateFormat('HH:mm').parse(start)
        : DateTime(currentTime.year);
    // ignore: unnecessary_null_comparison
    DateTime dateEnd = end != null
        ? DateFormat('HH:mm').parse(end)
        : DateTime(
            currentTime.year, currentTime.month, currentTime.day, 23, 59, 59);
    DateTime startTime = DateTime(
        currentTime.year,
        currentTime.month,
        currentTime.day,
        dateTimestart.hour,
        dateTimestart.minute,
        dateTimestart.second);
    DateTime endTime = DateTime(currentTime.year, currentTime.month,
        currentTime.day, dateEnd.hour, dateEnd.minute, dateEnd.second);
    if (endTime.isBefore(startTime)) {
      if (currentTime.isBefore(startTime) && currentTime.isBefore(endTime)) {
        startTime = startTime.add(const Duration(days: -1));
      } else {
        endTime = endTime.add(const Duration(days: 1));
      }
    }
    return currentTime.isAfter(startTime) && currentTime.isBefore(endTime);
  }

  static String _timeFormatter(BuildContext context) {
    return context.read<AppConfigBloc>().state.configModel?.timeformat == '24'
        ? 'HH:mm'
        : 'hh:mm a';
  }

  static String convertFromMinute(int minMinute, int maxMinute) {
    int firstValue = minMinute;
    int secondValue = maxMinute;
    String type = 'min';
    if (minMinute >= 525600) {
      firstValue = (minMinute / 525600).floor();
      secondValue = (maxMinute / 525600).floor();
      type = 'year';
    } else if (minMinute >= 43200) {
      firstValue = (minMinute / 43200).floor();
      secondValue = (maxMinute / 43200).floor();
      type = 'month';
    } else if (minMinute >= 10080) {
      firstValue = (minMinute / 10080).floor();
      secondValue = (maxMinute / 10080).floor();
      type = 'week';
    } else if (minMinute >= 1440) {
      firstValue = (minMinute / 1440).floor();
      secondValue = (maxMinute / 1440).floor();
      type = 'day';
    } else if (minMinute >= 60) {
      firstValue = (minMinute / 60).floor();
      secondValue = (maxMinute / 60).floor();
      type = 'hour';
    }
    return '$firstValue-$secondValue ${LocaleKeys.type.tr()}';
  }
}
