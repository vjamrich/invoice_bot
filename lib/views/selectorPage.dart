import 'package:flutter/material.dart';
import 'package:vat_appeal_bot/views/homePage.dart';

import 'package:vat_appeal_bot/utils/theme.dart' as theme;
import 'package:vat_appeal_bot/views/aboutPage.dart';
import 'package:vat_appeal_bot/views/termsPage.dart';


class SelectorPage extends StatefulWidget {
  const SelectorPage({Key? key}) : super(key: key);

  @override
  State<SelectorPage> createState() => _SelectorPageState();
}


class _SelectorPageState extends State<SelectorPage> {

  final ScrollController controller = ScrollController();
  late String activePage;

  @override
  void initState() {
    super.initState();
    activePage = getPages().keys.first;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.bgSecondaryColor,
      body: Column(
        children: <Widget>[
          _header(),
          Expanded(
            child: RawScrollbar(
              controller: controller,
              thumbVisibility: true,
              padding: const EdgeInsets.all(8.0),
              thickness: 8.0,
              thumbColor: theme.borderColor,
              radius: Radius.circular(theme.borderRadius.bottomLeft.x),
              child: ListView(
                shrinkWrap: false,
                controller: controller,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: SelectionArea(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 0),
                        child: getPages()[activePage],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  List<Widget> getTabs(Map<String, Widget> pages) {
    List<Widget> tabs = [];

    for(String key in pages.keys) {
      tabs.add(
        TextButton(
          onPressed: () {
            setState(() {
              activePage = key;
            });
          },
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(activePage == key ? theme.borderColor.withOpacity(0.6) : Colors.transparent),
            overlayColor: MaterialStatePropertyAll(theme.borderColor.withOpacity(0.2)),
          ),
          child: Text(
            key,
            style: const TextStyle(
              fontSize: 16.0,
              color: theme.textPrimaryColor,
            ),
          ),
        ),
      );

      if(pages.keys.last != key) {
        tabs.add(const SizedBox(width: 8.0));
      }
    }

    return tabs;
  }


  Widget _header() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: theme.bgPrimaryColor,
        border: Border(
          bottom: BorderSide(
            color: theme.borderColor,
            width: theme.borderWidth,
          ),
        ),
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/pwc_logo.png",
            height: 27.0,
          ),
          const SizedBox(width: 6.0),
          const Text(
            "VAT Appeal Bot",
            style: TextStyle(
              fontSize: 18.0,
              color: theme.textPrimaryColor,
            ),
          ),
          const Spacer(),
        ] + getTabs(getPages()),
      ),
    );
  }


  Map<String, Widget> getPages() => {
    "Home": HomePage(key: UniqueKey()),
    "About": const AboutPage(),
    "Terms & Conditions": const TermsPage(),
  };
}
