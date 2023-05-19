import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:invoice_bot/structure/invoice.dart';
import 'package:invoice_bot/structure/notice.dart';
import 'package:invoice_bot/utils/convertPdf.dart';
import 'package:invoice_bot/utils/convertXml.dart';
import 'package:invoice_bot/utils/uploadFile.dart';
import 'package:invoice_bot/widgets/primaryButton.dart';

import 'package:invoice_bot/utils/theme.dart' as theme;
import 'package:invoice_bot/widgets/secondaryButton.dart';
import 'package:oktoast/oktoast.dart';


class UploadPage extends StatefulWidget {

  final Function(Notice notice, List<Invoice>? xmlInvoices)? onAnalyse;

  const UploadPage({
    this.onAnalyse,
    Key? key,
  }) : super(key: key);

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {

  bool isNoticeUploaded = false;
  Notice? notice;
  bool isXmlInvoicesUploaded = false;
  List<Invoice>? xmlInvoices;

  bool _isHighlight = false;
  late DropzoneViewController controller;
  final List<String> mime = <String>["application/pdf", "text/xml"];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          width: 480.0,
          padding: const EdgeInsets.all(16.0),
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
              const Text(
                "Upload your files",
                style: TextStyle(
                  fontSize: 20.0,
                  color: theme.textPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              _uploadFileIndicator(
                title: "Notice | PDF",
                description: isNoticeUploaded ? "uploaded successfully" : "(required)",
                isPicked: isNoticeUploaded,
              ),
              const SizedBox(height: 14.0),
              _uploadFileIndicator(
                title: "Invoices | XML",
                description: isXmlInvoicesUploaded ? "uploaded successfully" : "(optional)",
                isPicked: isXmlInvoicesUploaded,
              ),
              const SizedBox(height: 16.0),
              _divider(),
              const SizedBox(height: 16.0),
              _dropZone(),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        PrimaryButton(
          onPressed: () {
            if(notice != null) {
              widget.onAnalyse?.call(notice!, xmlInvoices);
            } else {
              showToast("Upload notice before continuing");
            }
          },
          child: const Text(
            "Analyse",
            style: TextStyle(
              fontSize: 16.0,
              color: theme.textPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }


  Future<void> onSelect(dynamic event) async {
    final Uint8List data = await uploadFile(event, controller);
    final String dataMime = await controller.getFileMIME(event);

    if(dataMime == "text/xml") {
      xmlInvoices = convertXml(data);
      isXmlInvoicesUploaded = true;
      showToast("XML uploaded successfully");
    } else if(dataMime == "application/pdf") {
      notice = convertPdf(data);
      isNoticeUploaded = true;
      showToast("Notice uploaded successfully");
    } else {
      showToast("Invalid file");
    }

    setState(() {
      _isHighlight = false;
    });
  }


  Widget _divider() => const Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Expanded(
        child: Divider(
          color: theme.borderColor,
          height: 0.0,
          indent: 0.0,
          endIndent: 10.0,
        ),
      ),
      Text(
        "OR",
        style: TextStyle(
          fontSize: 12.0,
          color: theme.textSecondaryColor,
        ),
      ),
      Expanded(
        child: Divider(
          color: theme.borderColor,
          height: 0.0,
          indent: 10.0,
          endIndent: 0.0,
        ),
      ),
    ],
  );


  Widget _uploadFileIndicator({
    required String title,
    required String description,
    bool isPicked = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Icon(
          isPicked ? Icons.check_circle_outline_rounded : Icons.upload_file,
          color: theme.textSecondaryColor,
          size: 35.0,
        ),
        const SizedBox(width: 4.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 16.0,
                color: theme.textPrimaryColor,
                // fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12.0,
                color: theme.textSecondaryColor,
              ),
            ),
          ],
        ),
        const Spacer(),
        SecondaryButton(
          onPressed: () async {
            final List<dynamic> events = await controller.pickFiles(mime: mime);
            if(events.isEmpty) return;
            onSelect(events.first);
          },
          child: const Text(
            "Choose",
            style: TextStyle(
              fontSize: 16.0,
              color: theme.accentSecondaryColor,
            ),
          ),
        ),
      ],
    );
  }


  Widget _dropZone() {

    TextStyle style = const TextStyle(
      fontSize: 16.0,
      color: theme.textSecondaryColor,
    );

    TextStyle hyperlinkStyle = const TextStyle(
      fontSize: 16.0,
      color: theme.accentSecondaryColor,
      decoration: TextDecoration.underline,
      decorationColor: theme.accentSecondaryColor,
    );

    return AspectRatio(
      aspectRatio: 1.2,
      child: Container(
        // height: 100.0,
        width: double.maxFinite,
        color: _isHighlight ? theme.borderColor.withOpacity(0.1) : Colors.transparent,
        child: DottedBorder(
          borderType: BorderType.RRect,
          color: theme.textPrimaryColor,
          strokeWidth: 1,
          dashPattern: const [6,2],
          radius: Radius.circular(theme.borderRadius.bottomLeft.x),
          padding: const EdgeInsets.all(24.0),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              DropzoneView(
                onCreated: (controller) => this.controller = controller,
                onDrop: (dynamic event) => onSelect(event),
                mime: mime,
                onHover:  ()  => setState(() => _isHighlight = true),
                onLeave:  ()  => setState(() => _isHighlight = false),
                onLoaded: ()  => setState(() => _isHighlight = false),
                onError:  (e) => showToast("Error uploading file")
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Drag and drop or ",
                    style: style,
                  ),
                  GestureDetector(
                    child: Text(
                      "choose file",
                      style: hyperlinkStyle,
                    ),
                    onTap: () async {
                      final List<dynamic> events = await controller.pickFiles(mime: mime);
                      if(events.isEmpty) return;
                      onSelect(events.first);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
