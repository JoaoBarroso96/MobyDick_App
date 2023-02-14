import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../mobydick_app_theme.dart';

class CreateBookingScreen extends StatefulWidget {
  const CreateBookingScreen({Key? key}) : super(key: key);

  @override
  _CreateBookingScreen createState() => _CreateBookingScreen();
}

class _CreateBookingScreen extends State<CreateBookingScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  bool multiple = true;
  final _formKey = GlobalKey<FormState>();

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

  final _emailController = useTextEditingController();

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Scaffold(
        backgroundColor: isLightMode == true
            ? MobydickAppTheme.white
            : MobydickAppTheme.nearlyBlack,
        body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value);

                  if (!emailValid) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
            ],
          ),
        ));
  }
}
