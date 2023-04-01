import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobydick/routes/home.dart';
import 'package:mobydick/routes/search/search_page.dart';
import 'package:mobydick/routes/view_booking.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../bottom_navigation_view/bottom_bar_view.dart';
import '../mobydick_app_theme.dart';
import '../models/tabIcon_data.dart';
import 'calendar.dart';
import 'create_booking.dart';

class MobydickHomeScreen extends StatefulWidget {
  @override
  _MobydickHomeScreenState createState() => _MobydickHomeScreenState();
}

class _MobydickHomeScreenState extends State<MobydickHomeScreen>
    with TickerProviderStateMixin {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  void _onItemTapped(int index) {
    if (index != _currentIndex.value) {
      _navigatorKey.currentState!.pushReplacementNamed('/${index + 1}');
      _currentIndex.value = index;
    }
  }

  AnimationController? animationController;

  List<Widget> pages = [
    CalendarScreen(),
    HomeScreen(),
    SearchPage(),
    CalendarScreen()
  ];

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);

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
        bottomNavigationBar: ValueListenableBuilder<int>(
          valueListenable: _currentIndex,
          builder: (context, value, child) {
            return CustomBottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: _onItemTapped,
            );
          },
        ),
        backgroundColor: Colors.transparent,
        body: Navigator(
          key: _navigatorKey,
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;

            switch (settings.name) {
              case '/1':
                builder = (BuildContext _) => CalendarScreen();
                break;
              case '/2':
                builder = (BuildContext _) => HomeScreen();
                break;
              case '/3':
                builder = (BuildContext _) => SearchPage();
                break;
              case 'createBooking':
                Map arguments = settings.arguments as Map;
                builder = (BuildContext _) => CreateBookingScreen(
                      tripId: arguments["tripId"],
                      bookingId: arguments["bookingId"],
                    );
                break;
              case 'tripDetails':
                Map arguments = settings.arguments as Map;
                builder = (BuildContext _) =>
                    ViewBookingScreen(tripId: arguments["id"]);
                break;
              default:
                builder = (BuildContext _) => HomeScreen();
              //throw Exception('Invalid route: ${settings.name}');
            }

            return MaterialPageRoute(builder: builder, settings: settings);
          },
        ));
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }
}
