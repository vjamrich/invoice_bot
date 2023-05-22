import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:invoice_bot/views/homePage.dart';

import 'package:invoice_bot/utils/theme.dart' as theme;
import 'package:invoice_bot/views/aboutPage.dart';
import 'package:invoice_bot/views/termsPage.dart';


class SelectorPage extends StatefulWidget {
  const SelectorPage({Key? key}) : super(key: key);

  @override
  State<SelectorPage> createState() => _SelectorPageState();
}


class _SelectorPageState extends State<SelectorPage> {

  final ScrollController controller = ScrollController();

  late String activePage;
  final Map<String, Widget> pages = {
    "Home": const HomePage(key: ValueKey("homePage")),
    "About": const AboutPage(),
    "Terms & Conditions": const TermsPage(),
  };


  @override
  void initState() {
    super.initState();
    activePage = pages.keys.first;
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
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 0),
                      child: pages[activePage],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // const Spacer(),
          // Padding(
          //   padding: const EdgeInsets.all(24.0),
          //   child: _footer(),
          // ),
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
          )
        )
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/pwc_logo.png",
            height: 24.0,
          ),
          const SizedBox(width: 6.0),
          const Text(
            "Invoice Bot",
            style: TextStyle(
              fontSize: 20.0,
              color: theme.textPrimaryColor,
            ),
          ),
          const Spacer(),
        ] + getTabs(pages),
      ),
    );
  }


  Widget _footer() {

    TextStyle style = const TextStyle(
      fontSize: 12.0,
      color: theme.textSecondaryColor,
    );

    TextStyle hyperlinkStyle = const TextStyle(
      fontSize: 12.0,
      color: theme.accentSecondaryColor,
      decoration: TextDecoration.underline,
      decorationColor: theme.accentSecondaryColor,
    );

    return Wrap(
      children: [
        Text(
          "© 2023 PwC. All rights reserved. PwC refers to the PwC network and/or one or more of its member firms, each of which is a separate legal entity. Please see ",
          style: style,
        ),
        GestureDetector(
          child: Text(
            "www.pwc.com/structure",
            style: hyperlinkStyle,
          ),
          onTap: () async {
            try {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  content: Text(
                    "Error opening the page. Please try again.",
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              );
              // await launchUrl(Uri.parse("https://www.pwc.com/structure"));
            } catch (e) {
              debugPrint(e.toString());
            }
          },
        ),
        Text(
          " for further details.",
          style: style,
        )
      ],
    );
  }
}
