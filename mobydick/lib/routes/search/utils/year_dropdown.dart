import 'package:flutter/material.dart';
import 'package:mobydick/mobydick_app_theme.dart';

class YearDropdown extends StatefulWidget {
  final String selectedYear;
  final ValueChanged<String> onYearChanged;

  YearDropdown({required this.selectedYear, required this.onYearChanged});

  @override
  _YearDropdownState createState() => _YearDropdownState();
}

class _YearDropdownState extends State<YearDropdown> {
  @override
  Widget build(BuildContext context) {
    List<String> yearsList = List.generate(5, (index) => (DateTime.now().year - index).toString());
    yearsList.insert(0,"All");

    return DropdownButton<String>(
      isExpanded: true,
      value: widget.selectedYear,
      underline: Container(
        height: 1,
        color: MobydickAppTheme.pallet1, // Border color
      ),
      items: yearsList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text("   " + value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        widget.onYearChanged(newValue!);
      },
    );
  }
}