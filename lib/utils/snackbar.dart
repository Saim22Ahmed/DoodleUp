// make a util of snackbar using riverpod

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// make riverpod controller which cntains all the utils and i can call them when needed

final utilsProvider = ChangeNotifierProvider<Utils>((ref) => Utils());

class Utils extends ChangeNotifier {
  void showSnackBar(BuildContext context) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Fields shouldn't be empty",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        duration: Duration(seconds: 2),
        dismissDirection: DismissDirection.horizontal,
      ));
}
