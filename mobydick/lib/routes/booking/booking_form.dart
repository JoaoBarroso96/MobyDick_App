import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../mobydick_app_theme.dart';
import 'package:country_picker/country_picker.dart';

import '../../models/booking_client_model.dart';

class ContactFormItemWidget extends StatefulWidget {
  ContactFormItemWidget(
      {Key? key,
      required this.contactTitle,
      required this.contactModel,
      required this.onRemove,
      required this.index})
      : super(key: key);

  int index;
  BookingClientModel contactModel;
  String contactTitle;
  final Function onRemove;
  final state = _ContactFormItemWidgetState();

  @override
  State<StatefulWidget> createState() {
    return state;
  }

  TextEditingController _nameController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _hotelController = TextEditingController();

  bool isValidated() => state.validate();
}

class _ContactFormItemWidgetState extends State<ContactFormItemWidget> {
  final formKey = GlobalKey<FormState>();
  bool isMainContact = false;
  double distance = 9;

  // Initial Selected Value
  String dropdownvalue = 'Onde ouviu falar da Mobydick?';

  // List of items in our dropdown menu
  var items = [
    'Onde ouviu falar da Mobydick?',
    'Internet',
    'Flyer',
    'Recomendação de amigo',
    'Outro',
  ];

  @override
  void initState() {
    isMainContact = widget.index != 0;
    if (widget.contactModel.id != 0 && !isMainContact) {
      dropdownvalue = widget.contactModel.source!;
    }
    widget._nameController.text = widget.contactModel.name.toString();
    widget._contactController.text = widget.contactModel.number.toString();
    widget._emailController.text = widget.contactModel.email.toString();
    widget._hotelController.text = widget.contactModel.hotel.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.contactTitle,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: MobydickAppTheme.nearlyBlue),
                    ),
                    Visibility(
                      visible: isMainContact,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            color: MobydickAppTheme.tripHighOccupancy,
                            icon: const Icon(Icons.remove_circle_outline),
                            tooltip: 'Remove',
                            onPressed: () => widget.onRemove(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  controller: widget._nameController,
                  // initialValue: widget.contactModel.name,
                  onChanged: (value) => widget.contactModel.name = value,
                  onSaved: (value) => widget.contactModel.name = value!,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    border: OutlineInputBorder(),
                    hintText: "Coloque nome",
                    labelText: "Nome",
                  ),
                ),
                Visibility(
                  visible: !isMainContact,
                  child: SizedBox(
                    height: distance,
                  ),
                ),
                Visibility(
                  visible: !isMainContact,
                  child: TextFormField(
                    controller: widget._contactController,
                    onChanged: (value) => widget.contactModel.number = value,
                    onSaved: (value) => widget.contactModel.name = value!,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      border: OutlineInputBorder(),
                      hintText: "Coloque contato",
                      labelText: "Contato",
                    ),
                  ),
                ),
                SizedBox(
                  height: distance,
                ),
                TextFormField(
                  controller: widget._emailController,
                  onChanged: (value) => widget.contactModel.email = value,
                  onSaved: (value) => widget.contactModel.email = value!,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    border: OutlineInputBorder(),
                    hintText: "Colocar Email",
                    labelText: "Email",
                  ),
                ),
                Visibility(
                    visible: !isMainContact,
                    child: SizedBox(
                      height: distance,
                    )),
                Visibility(
                  visible: !isMainContact,
                  child: TextFormField(
                    controller: widget._hotelController,
                    onChanged: (value) => widget.contactModel.hotel = value,
                    onSaved: (value) => widget.contactModel.hotel = value!,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      border: OutlineInputBorder(),
                      hintText: "Hotel / Alojamento",
                      labelText: "Hotel / Alojamento",
                    ),
                  ),
                ),
                SizedBox(
                  height: distance,
                ),
                InkWell(
                  onTap: () {
                    showCountryPicker(
                      context: context,
                      favorite: <String>['PT'],
                      onSelect: (Country country) {
                        setState(() {
                          widget.contactModel.nationality =
                              country.displayNameNoCountryCode;
                        });
                        //widget.contactModel.nationality = country.displayName;

                        print('Select country: ${country.displayName}');
                      },
                      // Optional. Sets the theme for the country list picker.
                      countryListTheme: CountryListThemeData(
                        // Optional. Sets the border radius for the bottomsheet.
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0),
                        ),
                        // Optional. Styles the search field.
                        inputDecoration: InputDecoration(
                          labelText: 'Search',
                          hintText: 'Start typing to search',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: const Color(0xFF8C98A8).withOpacity(0.2),
                            ),
                          ),
                        ),
                        // Optional. Styles the text in the search field
                        searchTextStyle: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                        ),
                      ),
                    );
                  },
                  child: InputDecorator(
                      decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.all(15),
                          border: OutlineInputBorder()),
                      child: Text(
                        widget.contactModel.nationality ?? "Nacionalidade",
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 16),
                      )),
                ),
                Visibility(
                  visible: !isMainContact,
                  child: SizedBox(
                    height: distance,
                  ),
                ),
                Visibility(
                  visible: !isMainContact,
                  child: InputDecorator(
                    decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(8),
                        border: OutlineInputBorder(),
                        labelText: "Opcional"),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        isExpanded: true,
                        // Initial Value
                        value: dropdownvalue,
                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),
                        // Array list of items
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                            widget.contactModel.source = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validate() {
    //Validate Form Fields
    /*bool? validate = formKey.currentState?.validate();
    if (validate) formKey.currentState!.save();
    return validate;*/
    return true;
  }
}
