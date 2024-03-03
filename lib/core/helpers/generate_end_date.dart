DateTime calculateEndDate(DateTime startDate, String duration) {
  // Extract the number of days from the duration string
  int days = int.parse(duration.split(' ')[0]);

  // Add the number of days to the start date to get the end date
  DateTime endDate = startDate.add(Duration(days: days));

  return endDate;
}
