import 'package:flutter/material.dart';
import 'package:invoice_bot/utils/getTemplate.dart';

import 'package:oktoast/oktoast.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

import 'package:invoice_bot/utils/theme.dart' as theme;
import 'package:invoice_bot/structure/invoice.dart';
import 'package:invoice_bot/structure/notice.dart';
import 'package:invoice_bot/widgets/noticeHeader.dart';
import 'package:invoice_bot/widgets/primaryButton.dart';
import 'package:invoice_bot/widgets/secondaryButton.dart';
import 'package:rich_clipboard/rich_clipboard.dart';


class GeneratePage extends StatelessWidget {

  final Notice notice;
  final List<Invoice>? xmlInvoices;
  final VoidCallback? onBack;

  const GeneratePage({
    required this.notice,
    this.xmlInvoices,
    this.onBack,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final QuillEditorController controller = QuillEditorController();

    return SizedBox(
      width: 1150.0,
      child: Column(
        children: <Widget>[
          NoticeHeader(notice: notice),
          const SizedBox(height: 14.0),
          _richText(controller),
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
                child: const Text(
                  "Copy",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: theme.textPrimaryColor,
                  ),
                ),
                onPressed: () async {
                  final String plainText = await controller.getPlainText();
                  final String htmlText = await controller.getText();
                  await RichClipboard.setData(RichClipboardData(
                    text: plainText,
                    html: htmlText,
                  ));
                  showToast("Message copied to clipboard");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget _richText(QuillEditorController controller) {
    return Container(
      decoration: BoxDecoration(
        color: theme.bgPrimaryColor,
        borderRadius: theme.borderRadius,
        border: Border.all(
          color: theme.borderColor,
          width: theme.borderWidth,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SelectionContainer.disabled(
              child: ToolBar(
                controller: controller,
                toolBarColor: Colors.transparent,
                iconColor: theme.textSecondaryColor,
                activeIconColor: theme.accentSecondaryColor,
                padding: const EdgeInsets.only(right: 12.0),
                toolBarConfig: const <ToolBarStyle>[
                  ToolBarStyle.bold,
                  ToolBarStyle.italic,
                  ToolBarStyle.underline,
                  ToolBarStyle.size,
                  ToolBarStyle.align,
                  ToolBarStyle.indentMinus,
                  ToolBarStyle.indentAdd,
                  ToolBarStyle.listOrdered,
                  ToolBarStyle.listBullet,
                ],
              ),
            ),
          ),
          const Divider(
            color: theme.borderColor,
            height: 0.0,
            indent: 0.0,
            endIndent: 0.0,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: QuillHtmlEditor(
              text: getTemplate(notice),
              hintText: "",
              controller: controller,
              minHeight: 250.0,
              backgroundColor: Colors.transparent,
              textStyle: const TextStyle(
                fontSize: 16.0,
                color: theme.textPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
