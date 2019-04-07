import 'package:flutter/material.dart';
import 'package:startup_namer_flutter/model/app_tab.dart';
import 'package:meta/meta.dart';

class TabSelector extends StatelessWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  TabSelector({Key key, @required this.activeTab, @required this.onTabSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: AppTab.values.indexOf(activeTab),
        onTap: (index) => onTabSelected(AppTab.values[index]),
        items: AppTab.values.map((tab) {
          return BottomNavigationBarItem(
              icon: Icon(tab == AppTab.names ? Icons.list : Icons.favorite),
              title: Text(tab == AppTab.names ? "Names" : "Favorite names"));
        }).toList());
  }
}
