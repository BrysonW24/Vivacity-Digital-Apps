import 'package:flutter/material.dart';

class ButtonStyles {
  static final ButtonStyle primaryButton = ElevatedButton.styleFrom(
    backgroundColor: Colors.blueAccent,
    foregroundColor: Colors.white,
    textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  );

  static final ButtonStyle secondaryButton = OutlinedButton.styleFrom(
    foregroundColor: Colors.blueAccent,
    side: BorderSide(color: Colors.blueAccent),
    textStyle: TextStyle(fontSize: 16),
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  );

  static final ButtonStyle textButton = TextButton.styleFrom(
    foregroundColor: Colors.blueAccent,
    textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  );

  static final ButtonStyle dangerButton = ElevatedButton.styleFrom(
    backgroundColor: Colors.redAccent,
    foregroundColor: Colors.white,
    textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  );

  static final ButtonStyle disabledButton = ElevatedButton.styleFrom(
    backgroundColor: Colors.grey,
    foregroundColor: Colors.white,
    textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  );

}
