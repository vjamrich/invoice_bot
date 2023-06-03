DateTime getDeadline(DateTime receivedDate) {

  DateTime deadline = receivedDate.add(const Duration(days: 17));

  bool isWeekend = _isWeekend(deadline);
  bool isHoliday = _isCzechHoliday(deadline);
  while(isWeekend || isHoliday) {
    deadline = deadline.add(const Duration(days: 1));
    isWeekend = _isWeekend(deadline);
    isHoliday = _isCzechHoliday(deadline);
  }

  return deadline;
}


bool _isWeekend(DateTime date) {
  bool isWeekend = date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;

  return isWeekend;
}


bool _isCzechHoliday(DateTime date) {
  final year = date.year;
  List<DateTime> holidays = <DateTime>[
    // Restoration Day
    DateTime(year, 1, 1),
    // Labour Day
    DateTime(year, 5, 1),
    // Victory Day
    DateTime(year, 5, 8),
    // Saints Cyril and Methodius Day
    DateTime(year, 7, 5),
    // Jan Hus Day
    DateTime(year, 7, 6),
    // Statehood Day
    DateTime(year, 9, 28),
    // Independent Czechoslovak State Day
    DateTime(year, 10, 28),
    // Struggle for Freedom and Democracy Day
    DateTime(year, 11, 17),
    // Christmas Eve
    DateTime(year, 12, 24),
    // Christmas Day
    DateTime(year, 12, 25),
    // St. Stephen's Day
    DateTime(year, 12, 26),
  ];
  // Good Friday
  holidays += <DateTime>[
    DateTime(2023, 4, 7),
    DateTime(2024, 3, 29),
    DateTime(2025, 4, 18),
    DateTime(2026, 4, 3),
    DateTime(2027, 3, 26),
  ];
  // Easter Monday
  holidays += <DateTime>[
    DateTime(2023, 4, 10),
    DateTime(2024, 4, 1),
    DateTime(2025, 4, 21),
    DateTime(2026, 4, 6),
    DateTime(2027, 3, 29),
  ];
  final bool isHoliday = holidays.contains(date);

  return isHoliday;
}
