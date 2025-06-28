String convertDateTimetoString(DateTime dateTime) {
  String year = dateTime.year.toString(); // year
  String month = dateTime.month.toString(); // month
  String date = dateTime.day.toString(); // day

  // Add leading zero if needed
  if (month.length == 1) {
    month = "0$month";
  }
  if (date.length == 1) {
    date = "0$date";
  }

  return year + month + date; // Format: yyyymmdd
}
