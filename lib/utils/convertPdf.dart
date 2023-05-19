import 'dart:typed_data';

import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'package:invoice_bot/structure/invoice.dart';
import 'package:invoice_bot/structure/notice.dart';
import 'package:invoice_bot/structure/vat.dart';


Notice convertPdf(Uint8List data) {
  final PdfDocument document = PdfDocument(inputBytes: data);
  final String text = PdfTextExtractor(document).extractText();
  document.dispose();

  //TODO

  final Notice notice = Notice(
    companyName: "ABC Corp s.r.o.",
    tin: "5892 n58 93",
    startDate: DateTime.now(),
    endDate: DateTime.now().subtract(const Duration(days: 125)),
    invoices: <Invoice>[
      Invoice(
          invoiceNumber: "0957285082793",
          taxPoint: DateTime.now(),
          vats: <Vat>[Vat(vatBase: 784.87, vatAmount: 673821.84)]
      ),
      Invoice(
          invoiceNumber: "7085243750532",
          taxPoint: DateTime.now(),
          vats: <Vat>[Vat(vatBase: 947.05, vatAmount: 673821.84)]
      ),
      Invoice(
          invoiceNumber: "57832075823",
          taxPoint: DateTime.now(),
          vats: <Vat>[Vat(vatBase: 594.80, vatAmount: 673821.84)]
      ),
      Invoice(
          invoiceNumber: "34721859703",
          taxPoint: DateTime.now(),
          vats: <Vat>[Vat(vatBase: 817.03, vatAmount: 673821.84)]
      ),
    ],
  );

  return notice;
}
