import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mobydick/models/booking_create_model.dart';
import '../mobydick_app_theme.dart';
import 'booking/booking_form.dart';

class CreateBookingScreen extends StatefulWidget {
  const CreateBookingScreen({Key? key}) : super(key: key);

  @override
  _CreateBookingScreen createState() => _CreateBookingScreen();
}

class _CreateBookingScreen extends State<CreateBookingScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<ContactFormItemWidget> clientForms = List.empty(growable: true);

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
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
      backgroundColor: isLightMode == true
          ? MobydickAppTheme.white
          : MobydickAppTheme.nearlyBlack,
      body: clientForms.isNotEmpty
          ? ListView.builder(
              itemCount: clientForms.length,
              itemBuilder: (_, index) {
                return clientForms[index];
              })
          : Center(child: Text("Tap on + to Add Contact")),
    );
  }

  onSave() {
    bool allValid = true;

    clientForms
        .forEach((element) => allValid = (allValid && element.isValidated()));

    if (allValid) {
      List names = clientForms.map((e) => e.contactModel.name).toList();
      debugPrint("$names");
    } else {
      debugPrint("Form is Not Valid");
    }
  }

  //Delete specific form
  onRemove(BookingCreatetModel contact) {
    setState(() {
      int index = clientForms
          .indexWhere((element) => element.contactModel.id == contact.id);

      clientForms.removeAt(index);
    });
  }

  onAdd() {
    setState(() {
      BookingCreatetModel _contactModel =
          BookingCreatetModel(id: clientForms.length);
      clientForms.add(ContactFormItemWidget(
        index: clientForms.length,
        contactModel: _contactModel,
        onRemove: () => onRemove(_contactModel),
      ));
    });
  }
}
