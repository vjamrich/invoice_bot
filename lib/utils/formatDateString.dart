import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';


DateTime? formatDateString({
  String? date,
  String format = "dd.MM.yyyy",
}) {
  try{
    if(date == null) {
      return null;
    }
    DateTime outputDate = DateFormat(format).parse(date);

    return outputDate;
  } on FormatException catch (e) {
    debugPrint(e.toString());
    return null;
  }
}
