import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final drawingScreenProvider = ChangeNotifierProvider<DrawingScreenProvider>(
  (ref) => DrawingScreenProvider(),
);

class DrawingScreenProvider extends ChangeNotifier {
  Color _selectedColor = Colors.black; // Private variable to hold the color

  // Getter for selectedColor
  Color get selectedColor => _selectedColor;

  // Setter for selectedColor
  set selectedColor(Color color) {
    _selectedColor = color;
    notifyListeners(); // Notify listeners when the color changes
  }

  // Other properties and methods of the controller...
}
