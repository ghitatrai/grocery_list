import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String title;
  final int quantity;
  final bool isChecked;
  // Add a callback to handle the change
  final ValueChanged<bool?> onToggle;

  const ItemCard({
    super.key,
    required this.title,
    required this.quantity,
    required this.isChecked,
    required this.onToggle, // Pass this in from your ListView
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      // Wrap in InkWell to make the whole card ripple when tapped
      child: InkWell(
        onTap: () => onToggle(!isChecked),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: onToggle,
                    activeColor: Colors.green, // Visual feedback for completion
                  ),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isChecked ? FontWeight.normal : FontWeight.w500,
                      color: isChecked ? Colors.grey : Colors.black87,
                      decoration: isChecked 
                          ? TextDecoration.lineThrough 
                          : TextDecoration.none,
                    ),
                  ),
                ],
              ),
              Text(
                'x$quantity',
                style: const TextStyle(
                  fontSize: 16, 
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}