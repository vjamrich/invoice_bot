import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:invoice_bot/structure/invoice.dart';
import 'package:invoice_bot/structure/notice.dart';

import 'package:invoice_bot/views/homePage/generatePage.dart';
import 'package:invoice_bot/views/homePage/overviewPage.dart';
import 'package:invoice_bot/views/homePage/uploadPage.dart';


class HomePage extends StatefulWidget {

  const HomePage({
    Key? key
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int activePage = 0;
  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = <Widget>[
      UploadPage(
        onAnalyse: (Notice notice, List<Invoice>? xmlInvoices) {
          pages += [
            OverviewPage(
              notice: notice,
              xmlInvoices: xmlInvoices,
              onBack: () => _switchPage(0),
              onGenerate: () => _switchPage(2),
            ),
            GeneratePage(
              notice: notice,
              xmlInvoices: xmlInvoices,
              onBack: () => _switchPage(1),
            ),
          ];
          _switchPage(1);
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: pages[activePage],
    );
  }


  void _switchPage(int pageIndex) {
    setState(() {
      activePage = pageIndex;
    });
  }
}
