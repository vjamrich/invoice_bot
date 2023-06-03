import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:vat_appeal_bot/utils/theme.dart' as theme;


class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1150.0,
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
            "About",
            style: TextStyle(
              fontSize: 20.0,
              color: theme.textPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          const Text(
            "Welcome to the VAT Appeal Bot web app, a tool designed for the Tax & Legal team of PwC Czech Republic. "
            "This app helps you to generate a response email for your clients based on a received notice. It is fast, easy and accurate.",
            style: TextStyle(
              fontSize: 16.0,
              color: theme.textSecondaryColor,
            ),
          ),
          const SizedBox(height: 16.0),
          const Text(
            "How it works",
            style: TextStyle(
              fontSize: 16.0,
              color: theme.textPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          const Text(
            "To use this app, you need to upload a received notice in a pdf format (please ensure the notice is not password protected). "
            "The app will analyse the notice and extract the relevant information, such as the company name, TIN, invoice numbers, and dates."
            "\n"
            "Based on the content of the notice, the app will generate an email response for your client, following the best practices of PwC Tax & Legal services. "
            "The email will include a greeting, a summary of the invoices of concern, and a closing remarks."
            "\n"
            "You can review and edit the generated email before copying and sending it to your client. "
            "Please ensure that the generated text is accurate and appropriate for your client’s situation.",
            style: TextStyle(
              fontSize: 16.0,
              color: theme.textSecondaryColor,
            ),
          ),
          const SizedBox(height: 16.0),
          const Text(
            "Contact us",
            style: TextStyle(
              fontSize: 16.0,
              color: theme.textPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Wrap(
            children: [
              const Text(
                "If you have any questions, feedback or issues with this app, please contact us at ",
                style: TextStyle(
                  fontSize: 16.0,
                  color: theme.textSecondaryColor,
                ),
              ),
              SelectionContainer.disabled(
                child: GestureDetector(
                  child: const Text(
                    "cz_vatappealbot@pwc.com",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: theme.accentSecondaryColor,
                      decoration: TextDecoration.underline,
                      decorationColor: theme.accentSecondaryColor,
                    ),
                  ),
                  onTap: () async {
                    try {
                      await launchUrl(Uri.parse("mailto:cz_vatappealbot@pwc.com?subject=VAT Appeal Bot Feedback"));
                    } catch (e) {
                      debugPrint(e.toString());
                    }
                  },
                ),
              ),
              const Text(
                ". ",
                style: TextStyle(
                  fontSize: 16.0,
                  color: theme.textSecondaryColor,
                ),
              ),
              const Text(
                "We appreciate your input and we are always looking for ways to improve our service. Thank you for using VAT Appeal Bot!",
                style: TextStyle(
                  fontSize: 16.0,
                  color: theme.textSecondaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
