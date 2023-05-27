import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mobydick/routes/stats/indicator.dart';

import '../../mobydick_app_theme.dart';

class PieChartSource extends StatefulWidget {
  Map<String, int> sources;
  PieChartSource({Key? key, required this.sources}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartSource> {
  int touchedIndex = -1;

  @override
  void initState() {
    setState(() {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.1,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1.5,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(widget.sources.keys.length, (i) {
                return Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.02,
                        bottom: MediaQuery.of(context).size.height * 0.02),
                    child: Indicator(
                      color: MobydickAppTheme.statsColers[i],
                      text: widget.sources.keys.toList()[i],
                      isSquare: true,
                    ));
              })),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(widget.sources.keys.length, (i) {
      int max = 0;
      for (var k in widget.sources.keys) {
        max += widget.sources[k]!;
      }
      String key = widget.sources.keys.toList()[i];
      double value = widget.sources[key]! * 100 / max;
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      if (key == "Recomendação de amigo") {
        key = "Rec. Amigo";
      }

      int percent = value.round();

      return PieChartSectionData(
        color: MobydickAppTheme.statsColers[i],
        value: value,
        title: "$percent.%",
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: MobydickAppTheme.white1,
          shadows: shadows,
        ),
      );
    });
  }
}
