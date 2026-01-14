import 'package:flutter/material.dart';
import 'package:grocery_list/core/theme/color_manager.dart';
import 'package:grocery_list/features/presentation/widgets/item_card.dart';
import 'package:grocery_list/features/presentation/widgets/list_card.dart';
import 'package:grocery_list/features/presentation/models/grocery_list_model.dart';
import 'package:grocery_list/features/presentation/models/item_model.dart';
import 'package:grocery_list/features/presentation/widgets/smart_suggestion.dart';

class ListDetail extends StatefulWidget {
  final GroceryListModel list;
  const ListDetail({super.key, required this.list});

  @override
  State<ListDetail> createState() => _ListDetailState();
}

class _ListDetailState extends State<ListDetail> {
  // 1. Define the items list here
  late List<ItemModel> _items;
  // Controller for adding custom items
  late TextEditingController _newItemController;

  @override
  void initState() {
    super.initState();
    // Initialize the local state from the passed model (make a mutable copy)
    _items = List<ItemModel>.from(widget.list.items);
    _newItemController = TextEditingController();
  }

  // Add or increment an item when a suggestion is tapped
  void _addItemFromSuggestion(String title) {
    setState(() {
      final idx = _items.indexWhere((e) => e.title.toLowerCase() == title.toLowerCase());
      if (idx >= 0) {
        _items[idx].quantity += 1;
      } else {
        _items.add(ItemModel(title: title, quantity: 1));
      }
    });
  }

  // Add a custom item from the input field
  void _addCustomItem() {
    final text = _newItemController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      final idx = _items.indexWhere((e) => e.title.toLowerCase() == text.toLowerCase());
      if (idx >= 0) {
        _items[idx].quantity += 1;
      } else {
        _items.add(ItemModel(title: text, quantity: 1));
      }
      _newItemController.clear();
    });
  }

  @override
  void dispose() {
    _newItemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.list.title, style: const TextStyle(color: ColorManager.textPrimary)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 30, color: ColorManager.primary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: summary card for the selected list
           
            Text(
              'Smart Suggestions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: ColorManager.textPrimary),
            ),
            const SizedBox(height: 12),

            // Horizontal suggestions
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ["Water", "Banana", "Oil", "Apple", "Bread", "Eggs"].map((name) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: SmartSuggestion(title: name, onPressed: () => _addItemFromSuggestion(name)),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 16),

            // Inline add input
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _newItemController,
                      decoration: InputDecoration(
                        hintText: 'Add an item',
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: ColorManager.border)),
                        filled: true,
                        fillColor: Theme.of(context).cardColor,
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () => _newItemController.clear(),
                        ),
                      ),
                      onSubmitted: (_) => _addCustomItem(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _addCustomItem,
                    style: ElevatedButton.styleFrom(backgroundColor: ColorManager.primary),
                    child: const Icon(Icons.add, color: Colors.white),
                  )
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Real items list (shows empty-state when there are no items)
            Expanded(
              child: _items.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.shopping_basket_outlined, size: 64, color: Colors.grey[400]),
                          const SizedBox(height: 12),
                          Text('No items yet. Tap a suggestion or add one below.', style: TextStyle(color: Colors.grey[600])),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        final item = _items[index];
                        return ItemCard(
                          title: item.title,
                          quantity: item.quantity,
                          isChecked: item.isChecked,
                          // Use the callback we defined to update state
                          onToggle: (val) {
                            setState(() {
                              item.isChecked = val ?? false;
                            });
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper to calculate progress for the header card
  double _calculateProgress() {
    if (_items.isEmpty) return 0.0;
    int checked = _items.where((i) => i.isChecked).length;
    return checked / _items.length;
  }
}