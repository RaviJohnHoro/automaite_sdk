import 'package:flutter/material.dart';

int getMillisecondsSinceEpoch() => DateTime.now().millisecondsSinceEpoch;

Color getColor(String color) => Color(
      int.parse("0xff${color.substring(1)}"),
    );
