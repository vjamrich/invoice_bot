import 'package:flutter/foundation.dart';
import 'package:invoice_bot/utils/formatVatString.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'package:invoice_bot/structure/invoice.dart';
import 'package:invoice_bot/structure/notice.dart';
import 'package:invoice_bot/structure/vat.dart';
import 'package:invoice_bot/utils/formatDateString.dart';


Notice? convertPdf(Uint8List data) {
  try{
    final PdfDocument document = PdfDocument(inputBytes: data);
    final String text = PdfTextExtractor(document).extractText();
    document.dispose();

    final RegExp tinRegExp = RegExp(r"DIČ:\s+(\S+)");
    final RegExp startDateRegExp = RegExp(r"od (\d{2}\.\d{2}\.\d{4})");
    final RegExp endDateRegExp = RegExp(r"do (\d{2}\.\d{2}\.\d{4})");
    final RegExp invoiceVatId = RegExp(r"(DIČ dod.|DIČ odb.):\s+(\S+)");
    final RegExp invoiceNumberRegExp = RegExp(r"Ev\.č\.:\s+(\d+)\s*");
    final RegExp taxPointRegExp = RegExp(r"DPPD: (\d{2}\.\d{2}\.\d{4})");
    final RegExp vatBase1RegExp = RegExp(r" ZD1:\s*([0-9\s.]+)");
    final RegExp vatAmount1RegExp = RegExp(r" D1:\s*([0-9\s.]+)");
    final RegExp vatBase2RegExp = RegExp(r" ZD2:\s*([0-9\s.]+)");
    final RegExp vatAmount2RegExp = RegExp(r" D2:\s*([0-9\s.]+)");
    final RegExp vatBase3RegExp = RegExp(r" ZD3:\s*([0-9\s.]+)");
    final RegExp vatAmount3RegExp = RegExp(r" D3:\s*([0-9\s.]+)");
    // Daňový\s+subjekt\s+v\s+oddílu\s+(\S+)

    List<String> splitText = text.split(RegExp(r" {2,}"));
    final String? tin = tinRegExp.firstMatch(text)?.group(1);
    final String? companyName = tin != null ? splitText[splitText.indexOf(tin)+1] : null;
    final String? startDate = startDateRegExp.firstMatch(text)?.group(1);
    final String? endDate = endDateRegExp.firstMatch(text)?.group(1);
    final List<RegExpMatch> invoiceVatIdMatches = invoiceVatId.allMatches(text).toList();
    final List<RegExpMatch> invoiceNumberMatches = invoiceNumberRegExp.allMatches(text).toList();
    final List<RegExpMatch> taxPointMatches = taxPointRegExp.allMatches(text).toList();
    final List<RegExpMatch> vatBase1Matches = vatBase1RegExp.allMatches(text).toList();
    final List<RegExpMatch> vatAmount1Matches = vatAmount1RegExp.allMatches(text).toList();
    final List<RegExpMatch> vatBase2Matches = vatBase2RegExp.allMatches(text).toList();
    final List<RegExpMatch> vatAmount2Matches = vatAmount2RegExp.allMatches(text).toList();
    final List<RegExpMatch> vatBase3Matches = vatBase3RegExp.allMatches(text).toList();
    final List<RegExpMatch> vatAmount3Matches = vatAmount3RegExp.allMatches(text).toList();

    if(companyName == null || tin == null) {
      return null;
    }

    List<Invoice> invoices = <Invoice>[];
    // TODO issue if we do not have same amount of matches - it will most likely error
    for(int index = 0; index < invoiceNumberMatches.length; index++) {
      final String? invoiceVatId = invoiceVatIdMatches[index].group(2); // TODO group 1 is capturing, if it's supplier or provider
      final InvoiceType invoiceType = invoiceVatIdMatches[index].group(1) == "DIČ odb." ? InvoiceType.purchaser : InvoiceType.supplier;
      final String? invoiceNumber = invoiceNumberMatches[index].group(1);
      final DateTime? taxPoint = formatDateString(date: taxPointMatches[index].group(1));
      final double? vatBase1 = formatVatString(vatBase1Matches[index].group(1));
      final double? vatAmount1 = formatVatString(vatAmount1Matches[index].group(1));
      final double? vatBase2 = formatVatString(vatBase2Matches[index].group(1));
      final double? vatAmount2 = formatVatString(vatAmount2Matches[index].group(1));
      final double? vatBase3 = formatVatString(vatBase3Matches[index].group(1));
      final double? vatAmount3 = formatVatString(vatAmount3Matches[index].group(1));

      if(invoiceNumber != null && invoiceVatId != null) {

        List<Vat> vats = <Vat>[];
        if(vatBase1 != null && vatAmount1 != null) {
          int vatRate = 0;
          if(vatBase1 != 0) {
            vatRate = (vatAmount1 / vatBase1 * 100).round();
          }
          vats.add(Vat(
            vatBase: vatBase1,
            vatAmount: vatAmount1,
            vatRate: vatRate,
          ));
        }
        if(vatBase2 != null && vatAmount2 != null) {
          int vatRate = 0;
          if(vatBase2 != 0) {
            vatRate = (vatAmount2 / vatBase2 * 100).round();
          }
          vats.add(Vat(
            vatBase: vatBase2,
            vatAmount: vatAmount2,
            vatRate: vatRate,
          ));
        }
        if(vatBase3 != null && vatAmount3 != null) {
          int vatRate = 0;
          if(vatBase3 != 0) {
            vatRate = (vatAmount3 / vatBase3 * 100).round();
          }
          vats.add(Vat(
            vatBase: vatBase3,
            vatAmount: vatAmount3,
            vatRate: vatRate,
          ));
        }

        invoices.add(Invoice(
          invoiceVatId: invoiceVatId,
          invoiceNumber: invoiceNumber,
          invoiceType: invoiceType,
          taxPoint: taxPoint,
          vats: vats,
        ));
      }
    }

    final Notice notice = Notice(
      companyName: companyName,
      tin: tin,
      startDate: formatDateString(date: startDate),
      endDate: formatDateString(date: endDate),
      invoices: invoices,
    );

    return notice;
  } catch(e) {
    debugPrint(e.toString());
    return null;
  }
}
