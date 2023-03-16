import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobydick/routes/home.dart';
import 'package:mobydick/routes/view_booking.dart';
import '../bottom_navigation_view/bottom_bar_view.dart';
import '../mobydick_app_theme.dart';
import '../models/tabIcon_data.dart';
import 'create_booking.dart';

class MobydickHomeScreen extends StatefulWidget {
  @override
  _MobydickHomeScreenState createState() => _MobydickHomeScreenState();
}

class _MobydickHomeScreenState extends State<MobydickHomeScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: MobydickAppTheme.background,
  );

  int _selectedIndex = 0;
  List<Widget> _pages = [
    ViewBookingScreen(tripId: 21),
    CreateBookingScreen(),
    HomeScreen(),
  ];

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = const HomeScreen() /*CreateBookingScreen()*/;
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Home",
            style: TextStyle(
              fontFamily: MobydickAppTheme.fontName,
              fontWeight: FontWeight.w500,
              fontSize: 25,
              letterSpacing: 0.5,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              tooltip: 'Search Icon',
              onPressed: () {},
            ), //IconButton
          ], //<Widget>[]
          backgroundColor: MobydickAppTheme.nearlyDarkBlue,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(15),
                bottomLeft: Radius.circular(15)),
          ),
          elevation: 5.0,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            tooltip: 'Menu Icon',
            onPressed: () {},
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.orange,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.call), label: 'Call'),
            BottomNavigationBarItem(
                icon: Icon(Icons.message), label: 'Message'),
          ],
        ),
        backgroundColor: Colors.transparent,
        body: _pages[_selectedIndex]);
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {},
          changeIndex: (int index) {},
        ),
      ],
    );
  }
}
