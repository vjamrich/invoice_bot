import 'package:vat_appeal_bot/structure/invoice.dart';


class Notice {

  String? companyName;
  String? tin;
  DateTime? receivedDate;
  DateTime? startDate;
  DateTime? endDate;
  List<Invoice> invoices;

  Notice({
    this.companyName,
    this.tin,
    this.receivedDate,
    this.startDate,
    this.endDate,
    this.invoices = const <Invoice>[],
  });
}
