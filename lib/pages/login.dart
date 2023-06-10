import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class LoginScreen extends StatefulWidget {
  static const String route = "/login";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final storage = const FlutterSecureStorage();
  late bool passwordLoginVisibility;
  bool _saveCredentials = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  void initState() {
    super.initState();
    passwordLoginVisibility = false;
    loadCredential();
  }

  @override
  Widget build(BuildContext context) {
    return loginWidget();
  }

  Future signIn(bool savecdr, String? emailcrd, String? passwordcrd) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim())
          .then((value) {
        if (_saveCredentials) {
          storage.write(key: 'email', value: emailcrd);
          storage.write(key: 'password', value: passwordcrd);
          storage.write(key: 'credential', value: savecdr == true ? 'y' : 'n');
        } else {
          storage.deleteAll();
        }
        //////PENDIENTE POR SI EL ADMIN DESEA AGREGAR REPORTES
        // if (FirebaseAuth.instance.currentUser!.displayName == null) {
        //   navigatorKey.currentState!.pushNamedAndRemoveUntil(
        //       '/profile', (Route<dynamic> route) => false,
        //       arguments: ClsdataProfile(newuser: true));
        // } else {
        //   navigatorKey.currentState!.pushNamedAndRemoveUntil(
        //       '/resume', (Route<dynamic> route) => false);
        // }

        Navigator.pushNamedAndRemoveUntil(
            context, '/results', (Route<dynamic> route) => false);
      }).catchError((err) {
        QuickAlert.show(
          context: context,
          barrierDismissible: false,
          type: QuickAlertType.warning,
          text: err.message,
          confirmBtnText: 'Ok',
        );
      });
    } on FirebaseAuthException catch (e) {
      QuickAlert.show(
        context: context,
        barrierDismissible: false,
        type: QuickAlertType.warning,
        text: e.toString(),
        confirmBtnText: 'Ok',
      );
    }
  }

  void loadCredential() async {
    bool tmpcrd = await storage.read(key: 'credential') == 'y' ? true : false;
    if (tmpcrd) {
      _emailController.text = (await storage.read(key: 'email'))!;
      _passwordController.text = (await storage.read(key: 'password'))!;
      setState(() {
        _saveCredentials = tmpcrd;
      });
    }
  }

  Widget loginWidget() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),
              const Text(
                'Sign in.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                ),
              ),
              const SizedBox(height: 100),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 400,
                ),
                child: TextFormField(
                  controller: _emailController,
                  obscureText: false,
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                    labelText: 'Email Address',
                    hintText: 'Enter your email...',
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.lightBlue,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 400,
                ),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: !passwordLoginVisibility,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password...',
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.lightBlue,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // filled: true,
                    contentPadding:
                        const EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                    suffixIcon: InkWell(
                      onTap: () => setState(
                        () =>
                            passwordLoginVisibility = !passwordLoginVisibility,
                      ),
                      focusNode: FocusNode(skipTraversal: true),
                      child: Icon(
                        passwordLoginVisibility
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 400,
                ),
                child: CheckboxListTile(
                  title: const Text('Save login credentials'),
                  value: _saveCredentials,
                  onChanged: (bool? value) {
                    setState(() {
                      _saveCredentials = value!;
                    });
                  },
                  hoverColor: Colors.transparent,
                ),
              ),
              const SizedBox(height: 50),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.lock_open,
                    size: 32,
                  ),
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(395, 55),
                  ),
                  onPressed: () async {
                    await signIn(_saveCredentials, _emailController.text,
                        _passwordController.text);
                    _formKey.currentState!.save();
                  },
                  label: const Text("Sign in"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
