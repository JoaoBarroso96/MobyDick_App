import 'package:flutter/material.dart';
import 'package:mobydick/models/ticket_model.dart';
import 'package:mobydick/services/ticket_service.dart';
import '../../app_bar/AppBar.dart';
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                        controller: _searchController,
                        onChanged: (value) => searchterm = value,
                        onSaved: (value) => searchterm = value!,
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
                  MediaQuery.of(context).size.height * 0.07),
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
                      await onSearch();
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
            Visibility(
                visible: tickets.isNotEmpty,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.03,
                      0,
                      MediaQuery.of(context).size.width * 0.03,
                      0),
                  child: Column(
                    children: [
                      const Text(
                        'Bilhetes',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: MobydickAppTheme.fontName,
                          fontWeight: FontWeight.w800,
                          fontSize: 21,
                          letterSpacing: 0.2,
                          color: MobydickAppTheme.darkText,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Nome",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: MobydickAppTheme.fontName,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              letterSpacing: -0.2,
                              color: MobydickAppTheme.darkText,
                            ),
                          ),
                          Text(
                            "Referência",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: MobydickAppTheme.fontName,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              letterSpacing: -0.2,
                              color: MobydickAppTheme.darkText,
                            ),
                          ),
                          Text(
                            "Ver",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: MobydickAppTheme.fontName,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              letterSpacing: -0.2,
                              color: MobydickAppTheme.darkText,
                            ),
                          ),
                        ],
                      ),
                      for (var item in tickets) TicketInfo(ticket: item),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                    ],
                  ),
                )),
            Visibility(
                visible: tickets.isEmpty,
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
    print(searchterm);
    List<Ticket> temp = await ticketService.searchTickets(searchterm);
    setState(() {
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
        margin: EdgeInsets.only(bottom: 3, top: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color.fromARGB(255, 165, 219, 255),
              width: 1.0,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                ticket.bookingClientModel.name.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: MobydickAppTheme.fontName,
                  fontWeight: FontWeight.w100,
                  fontSize: 13,
                  letterSpacing: -0.2,
                  color: MobydickAppTheme.darkText,
                ),
              ),
              Text(
                ticket.ref.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: MobydickAppTheme.fontName,
                  fontWeight: FontWeight.w100,
                  fontSize: 13,
                  letterSpacing: -0.2,
                  color: MobydickAppTheme.darkText,
                ),
              ),
              IconButton(
                onPressed: () async {},
                icon: Icon(
                  Icons.visibility,
                  size: 19.0,
                ),
              ),
            ],
          ),
        ));
  }
}
