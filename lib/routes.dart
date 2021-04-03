import 'package:flutter/material.dart';
import 'package:kinder_alarm/screens/OTP_screen.dart';
import './screens/Homescreen.dart';
import './screens/phone_book.dart';

final Map<String, WidgetBuilder> routes = {
  OTPScreen.routeName: (context) => OTPScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  PhoneBook.routeName: (context) => PhoneBook(),
};
