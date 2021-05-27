import 'package:flutter_svg/flutter_svg.dart';
import 'colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'items/saved_item_list.dart';
import 'items/search_item_list.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  List<Widget> pageList = List<Widget>();
  static const String prefSelectedIndexKey = 'selectedIndex';

  @override
  void initState() {
    super.initState();
    pageList.add(const RecipeList());
    pageList.add(const MyRecipesList());
    getCurrentIndex();
  }

  void saveCurrentIndex() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(prefSelectedIndexKey, _selectedIndex);
  }

  void getCurrentIndex() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(prefSelectedIndexKey)) {
      setState(() {
        _selectedIndex = prefs.getInt(prefSelectedIndexKey);
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    saveCurrentIndex();
  }

  @override
  Widget build(BuildContext context) {
    String title;
    switch (_selectedIndex) {
      case 0:
        title = 'FoodX';
        break;
      case 1:
        title = 'Saved Items';
        break;
    }
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/images/icon_recipe.svg',
                    color: _selectedIndex == 0 ? green : Colors.grey,
                    semanticsLabel: 'Recipes'),
                label: 'Recipes'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/images/icon_bookmarks.svg',
                    color: _selectedIndex == 1 ? green : Colors.grey,
                    semanticsLabel: 'Saved Items'),
                label: 'Saved Items'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: green,
          onTap: _onItemTapped,
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            title,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: pageList,
        ),
      ),
    );
  }
}
