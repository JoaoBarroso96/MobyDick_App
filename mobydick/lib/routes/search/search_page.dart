import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobydick/models/ticket_model.dart';
import 'package:mobydick/services/ticket_service.dart';
import '../../app_bar/AppBar.dart';
import '../../drawer_menu/DrawerMenu.dart';
import '../../mobydick_app_theme.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  final state = _SearchPage();

  @override
  State<StatefulWidget> createState() {
    return state;
  }
}

class _SearchPage extends State<SearchPage> {
  final formKey = GlobalKey<FormState>();
  TicketService ticketService = TicketService();
  TextEditingController _searchController = TextEditingController();
  String searchterm = "";
  bool search = false;
  List<Ticket> tickets = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Scaffold(
        drawer: DrawerMenu(),
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
                  padding: const EdgeInsets.only(
                      left: 12, right: 12, bottom: 12, top: 12),
                  decoration: BoxDecoration(
                    color: MobydickAppTheme.white,
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: _searchController,
                    onChanged: (value) => searchterm = value,
                    onSaved: (value) => searchterm = value!,
                    decoration: InputDecoration(
                      fillColor: MobydickAppTheme.pallet1,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      border: OutlineInputBorder(),
                      hintText:
                          "Pesquisar por nome, email, contacto ou referência",
                      labelText: "nome, email, contacto ou referência",
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  0,
                  MediaQuery.of(context).size.height * 0.03,
                  0,
                  MediaQuery.of(context).size.height * 0.07),
              child: Center(
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
                      backgroundColor: MobydickAppTheme.pallet2, // background
                      foregroundColor: Colors.white, // foreground
                    ),
                    onPressed: () async {
                      //pd.show(msg: "Adicionando reserva");
                      await onSearch();
                    },
                    label: Text(
                      'Pesquisar',
                      textAlign: TextAlign.center,
                      style:
                          GoogleFonts.lato(textStyle: MobydickAppTheme.caption),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: tickets.isNotEmpty,
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.03,
                            bottom: MediaQuery.of(context).size.height * 0.00),
                        child: Text(
                          "Bilhetes",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.quicksand(
                              textStyle: MobydickAppTheme.title),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.07,
                      decoration: BoxDecoration(
                        color: MobydickAppTheme.pallet4,
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.03,
                            0,
                            MediaQuery.of(context).size.width * 0.03,
                            0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Nome",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(
                                  textStyle: MobydickAppTheme.topTable),
                            ),
                            Text(
                              "Referência",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(
                                  textStyle: MobydickAppTheme.topTable),
                            ),
                            Text(
                              "Ver",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(
                                  textStyle: MobydickAppTheme.topTable),
                            ),
                          ],
                        ),
                      )),
                  for (var item in tickets) TicketInfo(ticket: item),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Center(
                    child: Text(
                      "${tickets.length} bilhetes encontrados",
                      textAlign: TextAlign.center,
                      style:
                          GoogleFonts.lato(textStyle: MobydickAppTheme.body2),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                ],
              ),
            ),
            Visibility(
                visible: tickets.isEmpty && search,
                child: Column(
                  children: [
                    const Text(
                      'Nenhum bilhete encontrado',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: MobydickAppTheme.fontName,
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                        letterSpacing: 0.2,
                        color: MobydickAppTheme.dark_grey,
                      ),
                    ),
                  ],
                ))
          ],
        ));
  }

  Future<int> onSearch() async {
    List<Ticket> temp = await ticketService.searchTickets(searchterm);
    setState(() {
      search = true;
      tickets = temp;
    });
    return 1;
  }
}

class TicketInfo extends StatelessWidget {
  TicketInfo({Key? key, required this.ticket}) : super(key: key);
  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 3, top: 3),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color.fromARGB(255, 165, 219, 255),
              width: 1.0,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.03,
              0, MediaQuery.of(context).size.width * 0.03, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                ticket.bookingClientModel.name.toString(),
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(textStyle: MobydickAppTheme.body1),
              ),
              Text(
                ticket.ref.toString(),
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(textStyle: MobydickAppTheme.body1),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'ticketDetails',
                      arguments: {"ticket": ticket});
                },
                icon: Icon(
                  Icons.visibility,
                  size: 27,
                  color: MobydickAppTheme.pallet2,
                ),
              ),
            ],
          ),
        ));
  }
}
