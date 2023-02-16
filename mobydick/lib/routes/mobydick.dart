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

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = const /*HomeScreen()*/ CreateBookingScreen();
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MobydickAppTheme.background,
      child: Scaffold(
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
          backgroundColor: MobydickAppTheme.nearlyBlue,
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
          //systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Stack(
                children: <Widget>[
                  tabBody,
                  bottomBar(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {},
          changeIndex: (int index) {},
        ),
      ],
    );
  }
}
