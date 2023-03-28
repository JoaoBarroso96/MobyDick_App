import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final ValueNotifier<int> currentIndex;
  final Function(int) onTap;

  CustomBottomNavigationBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return /*BottomNavigationBar(
      currentIndex: currentIndex.value,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    )*/
        SalomonBottomBar(
      currentIndex: currentIndex.value,
      onTap: onTap,
      //onTap: (i) => setState(() => _currentIndex = i),
      items: [
        /// Calendario
        SalomonBottomBarItem(
          icon: Icon(Icons.calendar_month_outlined),
          title: Text("Agenda"),
          selectedColor: Colors.pink,
        ),

        /// Home
        SalomonBottomBarItem(
          icon: Icon(Icons.home),
          title: Text("Home"),
          selectedColor: Colors.purple,
        ),

        /// Search
        SalomonBottomBarItem(
          icon: Icon(Icons.search),
          title: Text("Search"),
          selectedColor: Colors.orange,
        ),

        /// Profile
        SalomonBottomBarItem(
          icon: Icon(Icons.person),
          title: Text("Profile"),
          selectedColor: Colors.teal,
        ),
      ],
    );
  }
}
