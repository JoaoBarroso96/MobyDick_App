import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobydick/models/stats_model.dart';
import 'package:mobydick/routes/stats/stats_source.dart';
import '../../app_bar/AppBar.dart';
import '../../drawer_menu/DrawerMenu.dart';
import '../../mobydick_app_theme.dart';
import '../../services/stats_service.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  StatsService statsService = StatsService();
  TextEditingController _dateStartController = TextEditingController();
  TextEditingController _dateEndController = TextEditingController();
  late Future<Stats> futureStats;
  DateTime selectedDate = DateTime.now();

  bool multiple = true;
  var trips = [];

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    setState(() {
      futureStats = statsService.getStats("${selectedDate.year}-01-01", "${selectedDate.year}-12-31");
      _dateStartController.text = "${selectedDate.year}-01-01";
      _dateEndController.text = "${selectedDate.year}-12-31";
    });

    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(selectedDate.year, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dateStartController.text =
            DateFormat('yyyy-MM-dd').format(selectedDate);
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(selectedDate.year, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dateEndController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
    }
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Scaffold(
        drawer: DrawerMenu(),
        appBar: ApplicationToolbar(title: "Stats"),
        backgroundColor: isLightMode == true
            ? MobydickAppTheme.white
            : MobydickAppTheme.nearlyBlack,
        body: FutureBuilder<Stats>(
          future: futureStats,
          builder: (BuildContext context, AsyncSnapshot<Stats> snapshot) {
            if (!snapshot.hasData) {
              return Text("Aguarda");
            } else {
              return ListView(
                scrollDirection: Axis.vertical,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.03,
                        right: MediaQuery.of(context).size.width * 0.03,
                        bottom: MediaQuery.of(context).size.height * 0.03),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                              controller:
                                  _dateStartController, //editing controller of this TextField
                              decoration: const InputDecoration(
                                  icon: Icon(Icons
                                      .calendar_today), //icon of text field
                                  labelText: "Data Ínicio" //label text of field
                                  ),
                              readOnly: true, // when true user cannot edit text
                              onTap: () async {
                                //when click we have to show the datepicker
                                _selectDate(context);
                              }),
                        ),
                        Expanded(
                          child: TextField(
                              controller:
                                  _dateEndController, //editing controller of this TextField
                              decoration: const InputDecoration(
                                  icon: Icon(Icons
                                      .calendar_today), //icon of text field
                                  labelText: "Data Fim" //label text of field
                                  ),
                              readOnly: true, // when true user cannot edit text
                              onTap: () async {
                                //when click we have to show the datepicker
                                _selectEndDate(context);
                              }),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ElevatedButton.icon(
                        icon: const Icon(
                          Icons.search,
                          size: 25,
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 10,
                          backgroundColor:
                              MobydickAppTheme.pallet2, // background
                          foregroundColor: Colors.white, // foreground
                        ),
                        onPressed: () async {
                          //pd.show(msg: "Adicionando reserva");
                          await onCreateChart();
                        },
                        label: Text(
                          'Filtrar',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                              textStyle: MobydickAppTheme.caption),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.03,
                            bottom: MediaQuery.of(context).size.height * 0.01),
                        child: Text(
                          "Fonte",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.quicksand(
                              textStyle: MobydickAppTheme.title),
                        ),
                      )
                    ],
                  ),
                  PieChartSource(sources: snapshot.data!.sources),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.03,
                            bottom: MediaQuery.of(context).size.height * 0.01),
                        child: Text(
                          "Nacionalidades",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.quicksand(
                              textStyle: MobydickAppTheme.title),
                        ),
                      )
                    ],
                  ),
                  PieChartSource(
                      sources: Map.fromEntries(
                          snapshot.data!.countries.entries.toList()
                            ..sort((e1, e2) => e2.value.compareTo(e1.value)))),
                ],
              );
            }
          },
        ));
  }

  Future<int> onCreateChart() async {
    setState(() {
      futureStats = statsService.getStats(
          _dateStartController.text, _dateEndController.text);
    });
    return 1;
  }
}
