import 'package:intl/intl.dart';

import 'package:invoice_bot/structure/invoice.dart';
import 'package:invoice_bot/structure/notice.dart';
import 'package:invoice_bot/structure/vat.dart';


// Not doable
// - Greeting -> Dear xxx
// - Getting due date - can not extract day
// - Name of the supplier
// - Assumes all invoices are in CZK
// - Shorter form of the company name
// Remaining
// - Control statement sections
// - proper singular / plural form for invoice(s) was / were
String getTemplate(Notice notice) {

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
  "The tax authorities identified that the following invoice(s) were not reported by ${notice.companyName} in section A.4. "
  "of the control statement as sales of goods/services to Helena Pospisilova (VAT ID ${notice.invoices.first.invoiceVatId}) whereas "
  "they were reported by the purchaser in section B.2. of the control statement as goods purchased from "
  "${notice.companyName}:"
  "<br><br>"
  "<ul>${_getInvoiceTemplate(notice.invoices)}</ul>"
  "<br>"
  "Moreover, the authorities identified that the following invoice(s) were reported by ${notice.companyName} in section "
  "B.2. of the control statement as goods/services purchased from its supplier with "
  "VAT ID ${notice.invoices.first.invoiceVatId} whereas it was not reported by the supplier in section A.4. of the control "
  "statement as sales of goods/services to ${notice.companyName}:"
  "<br><br>"
  "<b>Please kindly double check these transactions and let us know whether confirmation, update "
  "or amendment of these transactions is needed. Alternatively, please provide us with the copies "
  "of the respective invoices so we can double check the correctness of their reporting. </b>"
  "<br><br>"
  "Please note that the reply to the tax appeal has to be made in the form of a subsequent control "
  "statement with confirmation (in case your data are correct), update or amendment of the questioned "
  "transaction (if they were incorrectly reported)."
  "<br><br>"
  "The deadline for submission of the subsequent control statement regarding the above is "
  "17 calendar days after the official letter was received. Therefore, the action from your "
  "side is required within the given deadline, otherwise the tax authorities will automatically assess the "
  "sanction of CZK 30,000 (approximately EUR 1,100), which applies if the subsequent control statement "
  "is not submitted in time."
  "<br><br>"
  "If you have any questions, please do not hesitate to contact us.";

  return emailTemplate;
}


String _getInvoiceTemplate(List<Invoice> invoices) {
  String invoiceTemplate = "";
  for(final Invoice invoice in invoices) {
    // TODO no bang operators on date (the same goes for date above)
    invoiceTemplate += "<li>Invoice no. <b>${invoice.invoiceNumber}</b>, tax point ${DateFormat("dd MMMM yyyy").format(invoice.taxPoint!)}";
    for(final Vat vat in invoice.vats) {
      if(vat.vatAmount != 0.0 && vat.vatBase != 0.0) {
        invoiceTemplate += ", tax base (for VAT rate ${vat.vatRate}%) in CZK ${NumberFormat.currency(symbol: "").format(vat.vatBase)}, VAT amount (${vat.vatRate}%) in CZK ${NumberFormat.currency(symbol: "").format(vat.vatAmount)}";
      }
    }
    invoiceTemplate += "</li>";
  }

  return invoiceTemplate;
}
