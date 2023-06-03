import 'package:intl/intl.dart';

import 'package:vat_appeal_bot/structure/invoice.dart';
import 'package:vat_appeal_bot/structure/notice.dart';
import 'package:vat_appeal_bot/structure/vat.dart';
import 'package:vat_appeal_bot/utils/getDeadline.dart';


String getTemplate(Notice notice) {

  final bool isPlural = notice.invoices.length > 1;
  final DateTime deadline = getDeadline(notice.receivedDate!);

  final String emailTemplate =
  "Dear Sir/Madam,"
  "<br><br>"
  "Please be informed that we received an official tax appeal from the Czech tax authorities regarding the "
  "control statement of ${notice.companyName} submitted for ${DateFormat("MMMM yyyy").format(notice.endDate!)}. We would like to "
  "ask you for a quick cooperation as there are only 17 calendar days for the reply. We attached to this "
  "email a copy of the letter."
  "<br><br>"
  "As the tax authorities identified discrepancies between the control statement of ${notice.companyName} and the "
  "control statement of its business partner, they request ${notice.companyName} either"
  "<br><br>"
  "<ol>"
      "<li>to confirm the validity of the originally filed control statement, or</li>"
      "<li>to correct the originally reported transactions.</li>"
  "</ol>"
  "<br>"
  "${_getStatementTemplate(notice)}"
  "<b>Please kindly double check ${isPlural ? "these transactions" : "this transaction"} and let us know whether confirmation, update "
  "or amendment of ${isPlural ? "these transactions" : "this transaction"} is needed. Alternatively, please provide us with the ${isPlural ? "copies" : "copy"} "
  "of the respective ${isPlural ? "invoices" : "invoice"} so we can double check the correctness of ${isPlural ? "their" : "its"} reporting. </b>"
  "<br><br>"
  "Please note that the reply to the tax appeal has to be made in the form of a subsequent control "
  "statement with confirmation (in case your data are correct), update or amendment of the questioned "
  "transaction (if they were incorrectly reported)."
  "<br><br>"
  "The deadline for submission of the subsequent control statement regarding the above is "
  "<b>on ${DateFormat("EEEE").format(deadline)}, ${DateFormat("dd MMMM yyyy").format(deadline)}</b> (17 calendar days after the official letter was received). Therefore, the action from your "
  "side is required within the given deadline, otherwise the tax authorities will automatically assess the "
  "sanction of CZK 30,000 (approximately EUR 1,100), which applies if the subsequent control statement "
  "is not submitted in time."
  "<br><br>"
  "If you have any questions, please do not hesitate to contact us.";

  return emailTemplate;
}


String _getStatementTemplate(Notice notice) {

  List<List<Invoice>> groupedInvoices = <List<Invoice>>[];
  for (InvoiceType type in InvoiceType.values) {
    List<Invoice> invoicesByType = notice.invoices.where((Invoice invoice) {
      return invoice.invoiceType == type;
    }).toList();
    if(invoicesByType.isNotEmpty) {
      groupedInvoices.add(invoicesByType);
    }
  }

  String statementTemplate = "";
  for(List<Invoice> invoices in groupedInvoices) {
    final bool areMultipleVatIds = _areMultipleVatIds(invoices);
    final bool isPurchaser = invoices.first.invoiceType == InvoiceType.purchaser;

    statementTemplate += "${statementTemplate.isEmpty ? "The" : "Moreover, the"} tax authorities identified that the following invoice${invoices.length > 1 ? "s were" : " was"} ${isPurchaser ? "not" : ""} reported by ${notice.companyName} in section "
    "${isPurchaser ? "A.4." : "B.2."} of the control statement as ${isPurchaser ? "sales of goods/services to its purchaser" : "goods/services purchased from its supplier"}"
    "${areMultipleVatIds ? "" : " with VAT ID <b>${notice.invoices.first.invoiceVatId}</b>"} whereas ${invoices.length > 1 ? "they were" : "it was"} ${isPurchaser ? "" : "not"} reported by the purchaser in section ${isPurchaser ? "B.2." : "A.4."} of the control "
    "statement as goods/services ${isPurchaser ? "purchased from" : "sold to"} ${notice.companyName}:"
    "<br><br>"
    "<ul>${_getInvoiceTemplate(invoices)}</ul>"
    "<br>";
  }

  return statementTemplate;
}


String _getInvoiceTemplate(List<Invoice> invoices) {
  bool areMultipleVatIds = _areMultipleVatIds(invoices);

  String invoiceTemplate = "";
  for(final Invoice invoice in invoices) {
    // TODO no bang operators on date (the same goes for date above)
    invoiceTemplate += "<li>${areMultipleVatIds ? "VAT ID <b>${invoice.invoiceVatId}</b>, " : ""}Invoice no. <b>${invoice.invoiceNumber}</b>, tax point ${DateFormat("dd MMMM yyyy").format(invoice.taxPoint!)}";
    for(final Vat vat in invoice.vats) {
      if(vat.vatAmount != 0.0 && vat.vatBase != 0.0) {
        invoiceTemplate += ", tax base (for VAT rate ${vat.vatRate}%) in CZK ${NumberFormat.currency(symbol: "").format(vat.vatBase)}, VAT amount (${vat.vatRate}%) in CZK ${NumberFormat.currency(symbol: "").format(vat.vatAmount)}";
      }
    }
    invoiceTemplate += "</li>";
  }

  return invoiceTemplate;
}


bool _areMultipleVatIds(List<Invoice> invoices) {
  Set<String> vatIdsSet = <String>{};
  List<Invoice> uniqueVatIds = invoices.where((Invoice invoice) => vatIdsSet.add(invoice.invoiceVatId)).toList();
  bool areMultipleVatIds = uniqueVatIds.length > 1;

  return !areMultipleVatIds;
}
