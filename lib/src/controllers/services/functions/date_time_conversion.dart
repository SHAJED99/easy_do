// ignore_for_file: non_constant_identifier_names


extension DateTimeExtensions on DateTime {
  // String get customWeekDayAbbreviation => (_weekDay[weekday] ?? "").customCutString(ending: 2).customCapitalizeFirstLetter;
  // String get custom_MMMM => DateFormat('MMMM').format(this);
  // String get custom_hh_mm_a => DateFormat('hh:mm a').format(this);
  // String get custom_d_MMM_EEE => DateFormat('d MMM : EEE').format(this);

  // bool customIsSameDay({DateTime? otherDate}) {
  //   DateTime today = otherDate ?? DateTime.now();
  //   return today.year == year && today.month == month && today.day == day;
  // }

  // bool customIsSameMonth({DateTime? otherDate}) {
  //   DateTime today = otherDate ?? DateTime.now();
  //   return today.year == year && today.month == month;
  // }

  // TimeOfDay get customConvertToTimeOfDay => TimeOfDay(hour: hour, minute: minute);

  // List<DateTime> customRange({DateTime? startingTime, DateRange dateRange = DateRange.day}) {
  //   DateTime start = startingTime ?? DateTime.now();

  //   List<DateTime> dateList = [];
  //   for (DateTime date = start; date.isBefore(this) || date.isAtSameMomentAs(this); date = _add(date, dateRange)) {
  //     dateList.add(date);
  //   }

  //   return dateList;
  // }

  // bool customInBetweenDay({required DateTime startTime, DateTime? endTime}) {
  //   if (customIsSameDay(otherDate: startTime)) return true;
  //   if (endTime == null) return isAfter(startTime);

  //   if (customIsSameDay(otherDate: endTime)) return true;
  //   return isAfter(startTime) && isBefore(endTime);
  // }

  // bool customInBetweenHour({required DateTime startTime, DateTime? endTime}) {
  //   if (year == startTime.year && month == startTime.month && day == startTime.day && hour == startTime.hour) return true;
  //   if (endTime == null) return isAfter(startTime);

  //   if (year == endTime.year && month == endTime.month && day == endTime.day && hour == endTime.hour) return true;
  //   return isAfter(startTime) && isBefore(endTime);
  // }

  // DateTime get customConvertToDateTimeHour => DateTime(year, month, day, hour);
  // DateTime get customConvertToDateTimeDate => DateTime(year, month, day);
  // DateTime get customConvertToDateTimeMonth => DateTime(year, month);

  // String get customConvertToDateTimeDateString => DateFormat('dd-MMM-yy').format(this);

  String get customToAPI {
    String r = toUtc().toIso8601String();

    return r;
  }
}

// const Map<int, String> _weekDay = {
//   DateTime.saturday: "saturday",
//   DateTime.sunday: "sunday",
//   DateTime.monday: "monday",
//   DateTime.tuesday: "tuesday",
//   DateTime.wednesday: "wednesday",
//   DateTime.thursday: "thursday",
//   DateTime.friday: "friday",
// };

// enum DateRange {
//   year,
//   month,
//   day,
//   hour,
//   minute,
//   second,
//   milliseconds,
//   microsecond,
// }

// DateTime _add(DateTime currentTime, DateRange dateRange) {
//   DateTime res;
//   if (dateRange == DateRange.day || dateRange == DateRange.hour || dateRange == DateRange.minute) {
//     res = currentTime.add(Duration(
//       days: dateRange == DateRange.day ? 1 : 0,
//       hours: dateRange == DateRange.hour ? 1 : 0,
//       minutes: dateRange == DateRange.minute ? 1 : 0,
//       seconds: dateRange == DateRange.second ? 1 : 0,
//       milliseconds: dateRange == DateRange.milliseconds ? 1 : 0,
//       microseconds: dateRange == DateRange.microsecond ? 1 : 0,
//     ));
//   } else {
//     res = currentTime.copyWith(
//       year: dateRange == DateRange.year ? currentTime.year + 1 : currentTime.year,
//       month: dateRange == DateRange.month ? currentTime.month + 1 : currentTime.month,
//     );
//   }

//   return res;
// }


// 2023-12-19T11:55:50.520Z
// 2023-12-19 18:00:00.000