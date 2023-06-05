import 'dart:async';

import 'package:admonhilton/pages/login.dart';
import 'package:admonhilton/pages/results.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
    options: const FirebaseOptions(
      apiKey: "AIzaSyBHdmWNfzUaZqnX0rx5ZAhIxK-UiuwZc1s",
      projectId: "maintenance-1a1f3",
      messagingSenderId: "1095461056610",
      appId: "1:1095461056610:web:6a8edfa6eec86bea3b613b",
      storageBucket: "maintenance-1a1f3.appspot.com",
    ),
  );
  return runApp(const ProviderScope(child: MyApp()));
}

final navigatorKey = GlobalKey<NavigatorState>();
Timer? _timer;

@override
void didChangeDependencies(BuildContext context, WidgetRef ref) {
  // Aquí puedes realizar cualquier inicialización necesaria
  // por ejemplo, llamar a una función para cargar datos
  _startTimer();
}

void _startTimer() {
  if (_timer != null) {
    _timer?.cancel();
  }

//Sets the timer to 300 seconds, after which the callback logs the user out
  _timer = Timer(const Duration(seconds: 10), () {
    _timer?.cancel();
    _timer = null;

    FirebaseAuth.instance.signOut();
    MaterialPageRoute(
      builder: (context) => const LoginScreen(),
    );

    // navigatorKey.pushAndRemoveUntil(
    //     MaterialPageRoute(
    //       builder: (context) => const LoginScreen(),
    //     ),
    //     (Route<dynamic> route) => false);
  });
}

class MyApp extends ConsumerWidget {
  // const MyApp({super.key});
  const MyApp({Key? key}) : super(key: key);

  void _handleInteraction([_]) {
    _startTimer();
  }

  // final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final appRouter = ref.watch(appRouterProvider);
    return Listener(
        behavior: HitTestBehavior.translucent,
        onPointerMove: _handleInteraction,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          theme: ThemeData(fontFamily: 'Poppins'),
          initialRoute: LoginScreen.route,
          // home: LoginScreen(auth: _auth),
          routes: {
            LoginScreen.route: (_) => const LoginScreen(),
            ResultsScreen.route: (_) => ResultsScreen()
            // ResultsScreen.route: (_) => const ResultsScreen(
            //       existkey: false,
            //     ),
          },
          // routerConfig: appRouter,
        ));
  }
}
