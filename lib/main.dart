import 'package:flutter/material.dart';
import 'package:kinder_alarm/screens/Homescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './screens/login_page.dart';
import './routes.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
  }

  void _checkIfLoggedIn() async {
    // check if token is there
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getString('user');
    // print(access_token);
    print(user);
    if (user != null) {
      setState(() {
        _isLoggedIn = true;
      });
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        unselectedWidgetColor: Colors.white,
        primaryTextTheme: TextTheme(
          headline6: TextStyle(color: Colors.white),
        ),
        textTheme: TextTheme(
          bodyText2: TextStyle(
            color: Colors.white,
          ),
        ),
        appBarTheme: AppBarTheme(color: Colors.red[400]),
      ),
      routes: routes,
      home: _isLoggedIn ? HomeScreen() : LoginPage(),
    );
  }
}
