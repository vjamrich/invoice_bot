import 'dart:typed_data';

import 'package:invoice_bot/structure/invoice.dart';
import 'package:invoice_bot/structure/vat.dart';


List<Invoice> convertXml(Uint8List data) {
  List<Invoice> invoices = <Invoice>[];

  // TODO

  invoices = <Invoice>[
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
  ];

  return invoices;
}
