import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobydick/routes/mobydick.dart';
import 'package:mobydick/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:validators/validators.dart';
import 'package:mobydick/globals.dart' as globals;
import '../../mobydick_app_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _textEditingController = TextEditingController();
  final Uri _url = Uri.parse(
      'https://crm.mobydicktours.azornexus.com/static/Ficha_MobyDick-Tours.png');
  UserService userService = UserService();
  @override
  void dispose() {
    _textEditingController.clear();
    super.dispose();
  }

  @override
  void initState() {
    _checkKeyExists();

    setState(() {});

    super.initState();
  }

  Future<void> _checkKeyExists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool keyExists = prefs.containsKey('token');
    if (keyExists) {
      globals.email = prefs.getString("email")!;
      globals.name = prefs.getString("name")!;
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MobydickHomeScreen()),
          (Route<dynamic> route) => false);
    }
  }

  bool isEmailCorrect = false;
  bool isPasswordIncorrect = false;
  final _formKey = GlobalKey<FormState>();
  bool apiCall = false;
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Text(""),
      body: Container(
        decoration: const BoxDecoration(
            // color: Colors.red.withOpacity(0.1),
            image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
                opacity: 1)),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // logo here
                  Image.asset(
                    'assets/images/mobydick.png',
                    height: 189,
                    width: 300,
                  ),
                  Text(
                    'Log In Now',
                    style: GoogleFonts.indieFlower(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ),
                  Text(
                    'Please login to continue using our app',
                    style: GoogleFonts.indieFlower(
                      textStyle: TextStyle(
                          color: Colors.black.withOpacity(0.8),
                          fontWeight: FontWeight.w300,
                          // height: 1.5,
                          fontSize: 15),
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: isEmailCorrect! ? 280 : 200,
                    // _formKey!.currentState!.validate() ? 200 : 600,
                    // height: isEmailCorrect ? 260 : 182,
                    width: MediaQuery.of(context).size.width / 1.1,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 20, top: 20),
                          child: TextFormField(
                            controller: _textEditingController,
                            onSaved: (value) => email = value!,
                            onChanged: (val) {
                              setState(() {
                                isEmailCorrect = isEmail(val);
                                email = val;
                              });
                            },
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              prefixIcon: Icon(
                                Icons.person,
                                color: MobydickAppTheme.pallet2,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              labelText: "Email",
                              hintText: 'your-email@domain.com',
                              labelStyle:
                                  TextStyle(color: MobydickAppTheme.pallet2),
                              // suffixIcon: IconButton(
                              //     onPressed: () {},
                              //     icon: Icon(Icons.close,
                              //         color: Colors.purple))
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              obscuringCharacter: '*',
                              obscureText: true,
                              onChanged: (value) => password = value,
                              onSaved: (value) => password = value!,
                              decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: MobydickAppTheme.pallet2,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "Password",
                                hintText: '*********',
                                labelStyle:
                                    TextStyle(color: MobydickAppTheme.pallet2),
                              ),
                              validator: (value) {
                                if (value!.isEmpty && value!.length < 5) {
                                  return 'Enter a valid password';
                                  {
                                    return null;
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Visibility(
                          visible: isPasswordIncorrect,
                          child: Text(
                            'Incorrect password',
                            style: GoogleFonts.abhayaLibre(
                              textStyle: TextStyle(
                                  color: Colors.red.withOpacity(0.8),
                                  fontWeight: FontWeight.w900,
                                  // height: 1.5,
                                  fontSize: 17),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        isEmailCorrect
                            ? ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    backgroundColor: isEmailCorrect == false
                                        ? Colors.red
                                        : MobydickAppTheme.pallet2,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 131, vertical: 20)
                                    // padding: EdgeInsets.only(
                                    //     left: 120, right: 120, top: 20, bottom: 20),
                                    ),
                                onPressed: () async {
                                  setState(() {
                                    apiCall = true; // Set state like this
                                    isPasswordIncorrect = false;
                                  });

                                  bool success = await onLogin(email, password);
                                  if (success) {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MobydickHomeScreen()),
                                        (Route<dynamic> route) => false);
                                  } else {
                                    setState(() {
                                      isPasswordIncorrect =
                                          true; // Set state like this
                                    });
                                  }
                                },
                                child: Text(
                                  'Log In',
                                  style: TextStyle(fontSize: 17),
                                ))
                            : Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  Future<bool> onLogin(String username, String password) async {
    bool response = await userService.login(username, password);
    return response;
  }
}
