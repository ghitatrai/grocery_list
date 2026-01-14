import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  final String title;
  final int itemCount;
  final Icon icon;
  final String? timeAdded;
  final Widget progress;
  final VoidCallback? onTap;

  const ListCard({
    super.key,
    required this.title,
    required this.icon,
    required this.progress,
    required this.itemCount,
    this.timeAdded,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final IconData iconData = icon.icon ?? Icons.category;
    final Color iconColor = icon.color ?? Theme.of(context).colorScheme.primary;
    final Color avatarBg = iconColor.withOpacity(0.12);

    return Semantics(
      label: '$title, $itemCount items${timeAdded != null ? ', $timeAdded' : ''}',
      child: Material(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start, // Align to top
              children: [
                CircleAvatar(
                  backgroundColor: avatarBg,
                  child: Icon(iconData, color: iconColor),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          if (timeAdded != null && timeAdded!.isNotEmpty)
                            Text(
                              timeAdded!,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[500]),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      // Displaying the item count
                      Text(
                        '$itemCount items',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 12),
                      progress,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}