import 'package:flutter/material.dart';
import 'package:grocery_list/features/presentation/pages/grocery_list_page.dart';
import 'package:grocery_list/features/presentation/pages/history_page.dart';
import 'package:grocery_list/features/presentation/pages/profile_page.dart';
import 'package:grocery_list/core/constants/navbar.dart'; // Ensure MyNavBar is exported/imported correctly here

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // 1. Move the index here so it persists
  int _currentPageIndex = 0;

  // 2. Define your pages in a list
  final List<Widget> _pages = const [
    GroceryListPage(),
    HistoryPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 3. The body updates based on the current index
      body: _pages[_currentPageIndex],
      
      bottomNavigationBar: MyNavBar(
        currentIndex: _currentPageIndex,
        onTap: (index) {
          // 4. setState tells Flutter to redraw the UI with the new index
          setState(() {
            _currentPageIndex = index;
          });
        },
      ),
    );
  }
}