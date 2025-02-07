import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:travel_app/constant_widgets/widget_ui_components.dart';
class EventDialogues{

  static showEvent(BuildContext context, String title, String message ) {

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      insetPadding: const EdgeInsets.symmetric(vertical: 200),
      content: Container(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          spacing: 20,
          children: [
            TextWidget(
              text: title,
              fontSize: 20,
              isBold: true,
            ),
            TextWidget(
              text: message,
              fontSize: 14,
              isBold: true,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Handle action when the button is pressed
            Navigator.pop(context); // Close the dialog
          },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(Colors.blue), // Set background color to blue
            foregroundColor: WidgetStateProperty.all<Color>(Colors.white), // Set text color to white
          ),
          child: const TextWidget(
            text: 'Close',
            color: Colors.white, // Customize the button text color
          ),
        ),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}