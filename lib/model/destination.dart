import 'package:flutter/material.dart';

class Destination {
  final int id;
  final String name;
  final String iconPath;
  final Widget? child;

   Destination(
      {required this.id, required this.name, required this.iconPath, this.child});
}