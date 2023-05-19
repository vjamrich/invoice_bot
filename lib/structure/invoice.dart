import 'package:invoice_bot/structure/vat.dart';


class Invoice {

  String invoiceNumber;
  DateTime? taxPoint;
  List<Vat> vats;

  Invoice({
    required this.invoiceNumber,
    this.vats = const <Vat>[],
    this.taxPoint,
  });
}
