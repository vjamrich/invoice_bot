import 'package:flutter/material.dart';
import 'package:invoice_bot/utils/theme.dart' as theme;


class TermsPage extends StatelessWidget {
  const TermsPage({Key? key}) : super(key: key);

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
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Terms & Conditions",
            style: TextStyle(
              fontSize: 20.0,
              color: theme.textPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas ex tellus, venenatis vitae varius nec, dictum sed massa. Aenean in erat sed sapien gravida rhoncus ut ac dui. Mauris magna magna, pellentesque quis suscipit vel, volutpat sed sem. Nulla convallis pharetra urna. Quisque sed libero ultricies diam ultrices tempor ac eu enim. Cras sit amet odio ac nisi congue malesuada. Proin congue molestie lacinia. Quisque ultrices lorem vitae ex convallis sollicitudin. Curabitur sit amet mi id urna auctor varius. Maecenas ut purus cursus lacus sodales hendrerit. \n\n Mauris consequat tempus faucibus. Donec non cursus eros. Quisque ut nisl nec ante finibus pharetra at sit amet dolor. Suspendisse vitae ante ultrices eros facilisis lobortis vel et metus. Fusce hendrerit est at vulputate eleifend. Aenean vel tellus ultricies, fringilla nisi a, ornare justo. Donec interdum, est quis rhoncus gravida, eros dolor semper leo, eu dignissim ex metus in diam. Praesent a metus tortor. Donec at justo lorem. Cras id justo non sem rutrum bibendum. Quisque sit amet eros dictum nisl vestibulum dapibus ut porta purus. In in tortor nunc. Nam nibh arcu, maximus nec consectetur sit amet, malesuada et leo. Sed id augue nisi. Ut commodo nulla mi, a facilisis orci blandit nec.",
            style: TextStyle(
              fontSize: 16.0,
              color: theme.textSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
