import 'package:flutter/material.dart';

class GrandesAreas {
  final String title;
  final String heading;
  final String subheading;
  final VoidCallback? onPress;

  GrandesAreas(
    this.title,
    this.heading,
    this.subheading,
    this.onPress
  );

  static List<GrandesAreas> list = [
    GrandesAreas("Aposentadoria", "Aposentadoria", "Tempo de trabalho", null),
    GrandesAreas("Aposentadoria", "Aposentadoria", "Invalidez", null)
  ];
  
}