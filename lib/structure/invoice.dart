import 'package:vat_appeal_bot/structure/vat.dart';


enum InvoiceType{
  supplier,
  purchaser,
}


class Invoice {

  String invoiceVatId;
  String invoiceNumber;
  InvoiceType invoiceType;
  DateTime? taxPoint;
  List<Vat> vats;

  Invoice({
    required this.invoiceVatId,
    required this.invoiceNumber,
    required this.invoiceType,
    this.vats = const <Vat>[],
    this.taxPoint,
  });
}
