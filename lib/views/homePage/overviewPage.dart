import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:data_table_2/data_table_2.dart';

import 'package:invoice_bot/structure/invoice.dart';
import 'package:invoice_bot/structure/notice.dart';
import 'package:invoice_bot/structure/vat.dart';
import 'package:invoice_bot/widgets/noticeHeader.dart';
import 'package:invoice_bot/utils/theme.dart' as theme;
import 'package:invoice_bot/widgets/primaryButton.dart';
import 'package:invoice_bot/widgets/secondaryButton.dart';


class OverviewPage extends StatelessWidget {

  final Notice notice;
  final List<Invoice>? xmlInvoices;
  final VoidCallback? onGenerate;
  final VoidCallback? onBack;

  const OverviewPage({
    required this.notice,
    this.xmlInvoices,
    this.onGenerate,
    this.onBack,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1150.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          NoticeHeader(notice: notice),
          const SizedBox(height: 14.0),
          _table(notice),
          const SizedBox(height: 14.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SecondaryButton(
                onPressed: () => onBack?.call(),
                child: const Text(
                  "Back",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: theme.accentSecondaryColor,
                  ),
                ),
              ),
              const SizedBox(width: 14.0),
              PrimaryButton(
                onPressed: () => onGenerate?.call(),
                child: const Text(
                  "Generate",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: theme.textPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget _table(Notice notice) {

    const TextStyle headerTextStyle = TextStyle(
      fontSize: 16.0,
      color: theme.textPrimaryColor,
      fontWeight: FontWeight.bold,
    );

    const TextStyle cellTextStyle = TextStyle(
      fontSize: 16.0,
      color: theme.textSecondaryColor,
    );

    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: theme.bgPrimaryColor,
        borderRadius: theme.borderRadius,
        border: Border.all(
          color: theme.borderColor,
          width: theme.borderWidth,
        ),
      ),
      child: DataTable(
        dividerThickness: 0.0,
        columns: const <DataColumn2>[
          DataColumn2(label: Text("Status", style: headerTextStyle)),
          DataColumn2(label: Text("Invoice Number", style: headerTextStyle)),
          DataColumn2(label: Text("VAT Base (CZK)", style: headerTextStyle)),
          DataColumn2(label: Text("VAT Amount (CZK)", style: headerTextStyle)),
          DataColumn2(label: Text("Tax Point", style: headerTextStyle)),
        ],
        rows: List<DataRow2>.generate(notice.invoices?.length ?? 0, (int index) {

          final Invoice invoice = notice.invoices![index];

          String taxPoint = "";
          if(invoice.taxPoint != null) {
            taxPoint = DateFormat("dd MMM yyyy").format(invoice.taxPoint!);
          }

          Widget issueCell = Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 8.0,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6.0),
              const Text("No Issues found", style: cellTextStyle),
            ],
          );

          return DataRow2(
            color: MaterialStatePropertyAll(
                index.isEven ? theme.borderColor.withOpacity(0.2) : Colors
                    .transparent),
            cells: <DataCell>[
              DataCell(issueCell),
              DataCell(Text(invoice.invoiceNumber, style: cellTextStyle)),
              DataCell(Text(invoice.vats.first.vatBase.toString(), style: cellTextStyle)),
              DataCell(Text(invoice.vats.first.vatAmount.toString(), style: cellTextStyle)),
              DataCell(Text(taxPoint, style: cellTextStyle)),
            ],
          );
        }),
      ),
    );
  }
}
