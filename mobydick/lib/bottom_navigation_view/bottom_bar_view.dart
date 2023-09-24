import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:mobydick/globals.dart' as globals;

class CustomBottomNavigationBar extends StatelessWidget {
  final ValueNotifier<int> currentIndex;
  final Function(int) onTap;
  final List<SalomonBottomBarItem> mobileList = [
    /// Home
    SalomonBottomBarItem(
      icon: Icon(Icons.home),
      title: Text("Home"),
      selectedColor: Colors.purple,
    ),

    /// Calendario
    SalomonBottomBarItem(
      icon: Icon(Icons.calendar_month_outlined),
      title: Text("Agenda"),
      selectedColor: Colors.pink,
    ),

    /// Search
    SalomonBottomBarItem(
      icon: Icon(Icons.search),
      title: Text("Search"),
      selectedColor: Colors.orange,
    ),

    /// Profile
    SalomonBottomBarItem(
      icon: Icon(Icons.bar_chart),
      title: Text("Gráficos"),
      selectedColor: Colors.lightBlue,
    ),

    /// Profile
    SalomonBottomBarItem(
      icon: Icon(Icons.qr_code),
      title: Text("Leitor"),
      selectedColor: Colors.teal,
    ),
  ];

  final List<SalomonBottomBarItem> webList = [
    /// Home
    SalomonBottomBarItem(
      icon: Icon(Icons.home),
      title: Text("Home"),
      selectedColor: Colors.purple,
    ),

    /// Calendario
    SalomonBottomBarItem(
      icon: Icon(Icons.calendar_month_outlined),
      title: Text("Agenda"),
      selectedColor: Colors.pink,
    ),

    /// Search
    SalomonBottomBarItem(
      icon: Icon(Icons.search),
      title: Text("Search"),
      selectedColor: Colors.orange,
    ),

    /// Profile
    SalomonBottomBarItem(
      icon: Icon(Icons.bar_chart),
      title: Text("Gráficos"),
      selectedColor: Colors.lightBlue,
    ),
  ];
  CustomBottomNavigationBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > globals.mobileWith) {
          return SalomonBottomBar(
            currentIndex: currentIndex.value,
            onTap: onTap,
            //onTap: (i) => setState(() => _currentIndex = i),
            items: webList,
          );
        } else {
          return SalomonBottomBar(
            currentIndex: currentIndex.value,
            onTap: onTap,
            //onTap: (i) => setState(() => _currentIndex = i),
            items: mobileList,
          );
        }
      },
    );
  }
}
