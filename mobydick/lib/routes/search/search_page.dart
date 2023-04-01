import 'package:flutter/material.dart';
import '../../app_bar/AppBar.dart';
import '../../mobydick_app_theme.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  final state = _SearchPage();

  @override
  State<StatefulWidget> createState() {
    return state;
  }

  bool isValidated() => state.validate();
}

class _SearchPage extends State<SearchPage> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Scaffold(
        appBar: ApplicationToolbar(title: "Pesquisa"),
        backgroundColor: isLightMode == true
            ? MobydickAppTheme.white
            : MobydickAppTheme.nearlyBlack,
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: formKey,
                child: Container(
                  padding:
                      const EdgeInsets.only(left: 12, right: 12, bottom: 12),
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
                            "Pesquisar",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: MobydickAppTheme.nearlyBlue),
                          ),
                        ],
                      ),
                      TextFormField(
                        //controller: widget._nameController,
                        /*onChanged: (value) => widget.contactModel.name = value,
                  onSaved: (value) => widget.contactModel.name = value!,*/
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 12),
                          border: OutlineInputBorder(),
                          hintText: "Pesquisar por nome, email ou contacto",
                          labelText: "nome, email ou contacto",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
                      Icons.search,
                      size: 25,
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 10,
                      backgroundColor:
                          MobydickAppTheme.nearlyBlue, // background
                      foregroundColor: Colors.white, // foreground
                    ),
                    onPressed: () async {
                      //pd.show(msg: "Adicionando reserva");
                      /*await onSave(tripId, pd).then((value) => /*pd.close()*/
                          Navigator.pushNamed(context, 'tripDetails',
                              arguments: {"id": 21}))*/
                      ;
                    },
                    label: const Text(
                      'Pesquisar',
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
        ));
  }

  bool validate() {
    //Validate Form Fields
    /*bool? validate = formKey.currentState?.validate();
    if (validate) formKey.currentState!.save();
    return validate;*/
    return true;
  }
}
