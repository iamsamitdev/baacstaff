import 'package:flutter/material.dart';

class Utility {
  /** Alert Dialog **/

  static Utility utility = null;

  static Utility getInstance() {
    if (utility == null) {
      utility = Utility();
    }

    return utility;
  }

  showAlertDialog(
      BuildContext context, String alertTitle, String alertMessage) {
    // set up the buttons
    // Widget cancelButton = FlatButton(
    //   child: Text("Cancel"),
    //   onPressed:  () {
    //     Navigator.pop(context);
    //   },
    // );

    Widget okButton = FlatButton(
      child: Text("ตกลง"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog

    AlertDialog alert = AlertDialog(
      title: Text(alertTitle),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[Text(alertMessage)],
        ),
      ),
      actions: [
        // cancelButton,

        okButton,
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

  /** End Alert Dialog **/

}
