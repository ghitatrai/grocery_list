import 'package:flutter/material.dart';
import 'package:grocery_list/features/presentation/models/item_model.dart';

class GroceryListModel {
  final String title;
  final IconData iconData;
  final Color iconColor;
  final double progress; // 0.0 - 1.0
  final int itemCount;
  final String? timeAdded;
  final List<ItemModel> items;

  const GroceryListModel({
    required this.title,
    required this.iconData,
    required this.iconColor,
    required this.progress,
    required this.itemCount,
    this.timeAdded,
    this.items = const <ItemModel>[],
  });
}
