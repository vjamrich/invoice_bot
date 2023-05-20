import 'package:flutter/foundation.dart';


double? formatVatString(String? vat) {
  try{
    if(vat == null) {
      return null;
    }
    double? outputVat = double.parse(vat.replaceAll(" ", ""));

    return outputVat;
  } on FormatException catch(e) {
    debugPrint(e.toString());
    return null;
  }
}
