import 'package:flutter/material.dart';
import 'package:mobydick/models/booking_create_model.dart';
import 'package:mobydick/services/booking_service.dart';
import '../mobydick_app_theme.dart';
import '../models/booking_client_model.dart';
import 'booking/booking_form.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class CreateBookingScreen extends StatefulWidget {
  const CreateBookingScreen({Key? key}) : super(key: key);

  @override
  _CreateBookingScreen createState() => _CreateBookingScreen();
}

class _CreateBookingScreen extends State<CreateBookingScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  BookingService bookingService = BookingService();
  List<ContactFormItemWidget> clientForms = List.empty(growable: true);

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    onAdd();
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
          ? ListView(
              children: [
                ListView.builder(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: clientForms.length,
                    itemBuilder: (_, index) {
                      return clientForms[index];
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        onAdd();
                      },
                      child: Icon(Icons.add),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(CircleBorder()),
                        padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                        backgroundColor: MaterialStateProperty.all(
                            MobydickAppTheme
                                .tripLowOccupancy), // <-- Button color
                        overlayColor:
                            MaterialStateProperty.resolveWith<Color?>((states) {
                          if (states.contains(MaterialState.pressed))
                            return MobydickAppTheme
                                .nearlyBlue; // <-- Splash color
                        }),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      0,
                      MediaQuery.of(context).size.height * 0.03,
                      0,
                      MediaQuery.of(context).size.height * 0.19),
                  child: Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ElevatedButton.icon(
                        icon: const Icon(
                          Icons.save_as,
                          size: 25,
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 10,
                          backgroundColor:
                              MobydickAppTheme.nearlyBlue, // background
                          foregroundColor: Colors.white, // foreground
                        ),
                        onPressed: () {
                          onSave();
                        },
                        label: const Text(
                          'ADICIONAR',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: MobydickAppTheme.fontName,
                            fontWeight: FontWeight.w100,
                            fontSize: 21,
                            letterSpacing: 0.2,
                            color: MobydickAppTheme.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Center(child: Text("Tap on + to Add Contact")),
    );
  }

  Future<void> onSave() async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show();

    bool allValid = true;

    clientForms
        .forEach((element) => allValid = (allValid && element.isValidated()));

    if (allValid) {
      List<BookingClientModel> clientsDetails =
          clientForms.map((e) => e.contactModel).toList();

      BookingCreateModel bookingCreatetModel =
          BookingCreateModel(idTrip: 21, boookingClient: clientsDetails);

      int response = await bookingService.addBooking(bookingCreatetModel);
      pd.close();

      if (response == 0) {
        //sucesss

      } else {}
      print(response);
    } else {
      debugPrint("Form is Not Valid");
    }
  }

  //Delete specific form
  onRemove(BookingClientModel contact) {
    setState(() {
      int index = clientForms
          .indexWhere((element) => element.contactModel.id == contact.id);

      clientForms.removeAt(index);
    });
  }

  onAdd() {
    setState(() {
      BookingClientModel _contactModel = BookingClientModel(
          id: clientForms.length, mainContact: clientForms.isEmpty);

      clientForms.add(ContactFormItemWidget(
        contactTitle: clientForms.isEmpty
            ? "Contato Principal"
            : "Passageiro " + (clientForms.length + 1).toString(),
        index: clientForms.length,
        contactModel: _contactModel,
        onRemove: () => onRemove(_contactModel),
      ));
    });
  }
}
