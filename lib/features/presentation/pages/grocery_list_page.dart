import 'package:flutter/material.dart';
import 'package:grocery_list/core/theme/color_manager.dart';
import 'package:grocery_list/features/presentation/pages/list_detail.dart';
import 'package:grocery_list/features/presentation/models/grocery_list_model.dart';
import 'package:grocery_list/features/presentation/widgets/list_card.dart';
import 'package:grocery_list/features/presentation/widgets/mysearch.dart';

class GroceryListPage extends StatelessWidget {
  const GroceryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: ColorManager.background,
   appBar: AppBar(
        title: Row(
          children: [
            const Text('My List', style: TextStyle(color: ColorManager.textPrimary)),
          ],
        ),
        backgroundColor: ColorManager.background,
        leading: IconButton(
          icon: const Icon(Icons.local_grocery_store, color: ColorManager.primary, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
          
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: ColorManager.textSecondary, size: 30),
            onPressed: () {
              // Action for adding a new item
            },
          ),
        ],
      ),
      body: Column(
        children: [
          MySearchBar(
            hintText: "Search items...",
            leading: const Icon(Icons.search, color: ColorManager.primary, size: 30),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                // sample data models (kept local for this page)
                Builder(builder: (context) {
                  final fruits = GroceryListModel(
                    title: 'Fruits & Vegetables',
                    iconData: Icons.local_grocery_store,
                    iconColor: ColorManager.fruitsVagetables,
                    progress: 0.7,
                    itemCount: 12,
                    timeAdded: '2 hrs ago',
                  );

                  final dairy = GroceryListModel(
                    title: 'Dairy',
                    iconData: Icons.local_grocery_store,
                    iconColor: ColorManager.dairy,
                    progress: 0.3,
                    itemCount: 8,
                    timeAdded: '5 hrs ago',
                  );

                  return Column(
                    children: [
                      ListCard(
                        title: fruits.title,
                        icon: Icon(fruits.iconData, color: fruits.iconColor),
                        progress: LinearProgressIndicator(
                          value: fruits.progress,
                          color: fruits.iconColor,
                          backgroundColor: ColorManager.lightGrey,
                        ),
                        itemCount: fruits.itemCount,
                        timeAdded: fruits.timeAdded,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ListDetail(list: fruits),
                            ),
                          );
                        },
                      ),

                      ListCard(
                        title: dairy.title,
                        icon: Icon(dairy.iconData, color: dairy.iconColor),
                        progress: LinearProgressIndicator(
                          value: dairy.progress,
                          color: dairy.iconColor,
                          backgroundColor: ColorManager.lightGrey,
                        ),
                        itemCount: dairy.itemCount,
                        timeAdded: dairy.timeAdded,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ListDetail(list: dairy),
                            ),
                          );
                        },
                      ),
                      
                    ],
                  );
                }),

              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorManager.primary,
        onPressed: () {
          // Action for adding a new item
        },
        child: Icon(Icons.add, color: ColorManager.white),
      ),
    
    );
  }
}