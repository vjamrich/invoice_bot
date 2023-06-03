import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:vat_appeal_bot/structure/notice.dart';
import 'package:vat_appeal_bot/utils/theme.dart' as theme;
import 'package:oktoast/oktoast.dart';
import 'package:vat_appeal_bot/widgets/secondaryButton.dart';


class NoticeHeader extends StatefulWidget {

  final Notice notice;
  final bool isDateEditable;

  const NoticeHeader({
    required this.notice,
    this.isDateEditable = true,
    Key? key,
  }) : super(key: key);

  @override
  State<NoticeHeader> createState() => _NoticeHeaderState();
}


class _NoticeHeaderState extends State<NoticeHeader> {
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
            widget.notice.companyName ?? "(undefined)",
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
                "TIN: ${widget.notice.tin ?? '(undefined)'}",
                style: const TextStyle(
                  fontSize: 16.0,
                  color: theme.textSecondaryColor,
                ),
              ),
              const SizedBox(width: 4.0),
              IconButton(
                onPressed: () async {
                  if(widget.notice.tin != null && widget.notice.tin!.isNotEmpty) {
                    await Clipboard.setData(ClipboardData(text: widget.notice.tin!));
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
              const Text(
                "Received Date: ",
                style: TextStyle(
                  fontSize: 16.0,
                  color: theme.textSecondaryColor,
                ),
              ),
              Text(
                _date(),
                style: widget.notice.receivedDate != null
                    ? const TextStyle(
                  fontSize: 16.0,
                  color: theme.textSecondaryColor,
                )
                    : const TextStyle(
                  fontSize: 16.0,
                  color: Colors.redAccent,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.redAccent,
                ),
              ),
              const SizedBox(width: 4.0),
              widget.isDateEditable
                  ? IconButton(
                    onPressed: () async {
                      DateTime? receivedDate = await showDatePicker(
                        context: context,
                        initialDate: widget.notice.receivedDate ?? DateTime.now(),
                        firstDate: DateTime.now().subtract(const Duration(days: 365)),
                        lastDate: DateTime.now(),
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data: ThemeData.dark().copyWith(
                              colorScheme: ColorScheme.fromSwatch(
                                primarySwatch: theme.materialAccentColor,
                                cardColor: theme.bgPrimaryColor,
                                brightness: Brightness.dark,
                              ),
                              dialogBackgroundColor: theme.bgSecondaryColor,
                            ),
                            child: child!,
                          );
                        },
                      );

                      setState(() {
                        widget.notice.receivedDate = receivedDate;
                      });
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(
                      Icons.edit_calendar,
                      size: 17.0,
                      color: theme.textSecondaryColor,
                    ),
                  )
                  : const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }

  String _dateRange() {
    String startDate = "(undefined)";
    if(widget.notice.startDate != null) {
      startDate = DateFormat("dd MMM yyyy").format(widget.notice.startDate!);
    }

    String endDate = "(undefined)";
    if(widget.notice.endDate != null) {
      endDate = DateFormat("dd MMM yyyy").format(widget.notice.endDate!);
    }

    return "$startDate - $endDate";
  }

  String _date() {
    String receivedDate = "not selected";
    if(widget.notice.receivedDate != null) {
      receivedDate = DateFormat("dd MMM yyyy").format(widget.notice.receivedDate!);
    }

    return receivedDate;
  }
}
