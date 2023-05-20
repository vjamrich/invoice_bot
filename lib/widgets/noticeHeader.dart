import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:invoice_bot/structure/notice.dart';
import 'package:invoice_bot/utils/theme.dart' as theme;
import 'package:oktoast/oktoast.dart';


class NoticeHeader extends StatelessWidget {

  final Notice notice;

  const NoticeHeader({
    required this.notice,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
      decoration: BoxDecoration(
        color: theme.bgPrimaryColor,
        borderRadius: theme.borderRadius,
        border: Border.all(
          color: theme.borderColor,
          width: theme.borderWidth,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            notice.companyName ?? "(undefined)",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 34.0,
              color: theme.textPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "TIN: ${notice.tin ?? '(undefined)'}", // TODO copy button
                style: const TextStyle(
                  fontSize: 16.0,
                  color: theme.textSecondaryColor,
                ),
              ),
              const SizedBox(width: 4.0),
              IconButton(
                onPressed: () async {
                  if(notice.tin != null && notice.tin!.isNotEmpty) {
                    await Clipboard.setData(ClipboardData(text: notice.tin!));
                    showToast("TIN copied to clipboard");
                  } else {
                    showToast("TIN is not available");
                  }
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(
                  Icons.copy,
                  size: 16.0,
                  color: theme.textSecondaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Icon(
                Icons.calendar_today,
                size: 16.0,
                color: theme.textSecondaryColor,
              ),
              const SizedBox(width: 4.0),
              _date(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _date() {
    String startDate = "(undefined)";
    if(notice.startDate != null) {
      startDate = DateFormat("dd MMM yyyy").format(notice.startDate!);
    }

    String endDate = "(undefined)";
    if(notice.endDate != null) {
      endDate = DateFormat("dd MMM yyyy").format(notice.endDate!);
    }

    return Text(
      "$startDate - $endDate",
      style: const TextStyle(
        fontSize: 16.0,
        color: theme.textSecondaryColor,
      ),
    );
  }
}
