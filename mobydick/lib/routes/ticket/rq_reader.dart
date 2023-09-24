import 'package:flutter/material.dart';
import 'package:mobydick/app_bar/AppBar.dart';
import 'package:mobydick/mobydick_app_theme.dart';
import 'package:mobydick/services/ticket_service.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../drawer_menu/DrawerMenu.dart';
import '../../models/ticket_model.dart';

class QRReaderScreen extends StatefulWidget {
  const QRReaderScreen({Key? key}) : super(key: key);

  @override
  State<QRReaderScreen> createState() => _QRReaderScreenState();
}

class _QRReaderScreenState extends State<QRReaderScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  TicketService ticketService = TicketService();
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    setState(() {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Scaffold(
      drawer: DrawerMenu(),
      appBar: ApplicationToolbar(title: "QRCode"),
      backgroundColor: isLightMode == true
          ? MobydickAppTheme.white
          : MobydickAppTheme.nearlyBlack,
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Text('Código: ${result!.code}')
                  : Text('Scan a ticket'),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        String code = result!.code ?? "";
        if (code.isNotEmpty) {
          ticketService.getTicket(code).then((value) => _openPage(value));
        }
      });
    });
  }

  void _openPage(Ticket ticket) {
    Navigator.pushNamed(context, 'ticketDetails',
        arguments: {"ticket": ticket});
  }
}
