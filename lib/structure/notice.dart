import 'package:invoice_bot/structure/invoice.dart';


class Notice {

  String? companyName;
  String? tin;
  DateTime? startDate;
  DateTime? endDate;
  List<Invoice> invoices;

  Notice({
    this.companyName,
    this.tin,
    this.startDate,
    this.endDate,
    this.invoices = const <Invoice>[],
  });
}
