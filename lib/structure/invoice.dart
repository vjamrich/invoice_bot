import 'package:invoice_bot/structure/vat.dart';


class Invoice {

  String invoiceVatId;
  String invoiceNumber;
  DateTime? taxPoint;
  List<Vat> vats;

  Invoice({
    required this.invoiceVatId,
    required this.invoiceNumber,
    this.vats = const <Vat>[],
    this.taxPoint,
  });
}
