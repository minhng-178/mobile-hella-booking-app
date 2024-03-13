DateTime calculateEndDate(DateTime startDate, String duration) {
  RegExp regExp = RegExp(r'\d+');
  String? match = regExp.stringMatch(duration);

  if (match == null) {
    return startDate;
  }

  int days = int.parse(match);
  DateTime endDate = startDate.add(Duration(days: days));

  return endDate;
}
