import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kinder_alarm/screens/OTP_screen.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();
  String phoneNo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Kinder Alarm"),
      // ),
      body: Form(
        key: formkey,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/background.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          child: ListView(
            children: [
              Column(
                children: [
                  Center(
                    child: Container(
                      width: 300,
                      child: Image.asset('images/logoK.png'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (value) {
                        setState(() {
                          phoneNo = value;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "ContactNo required";
                        }
                        if (value.length < 11) {
                          return "ContactNo must be 11 digits";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                          ),
                          hintStyle: Theme.of(context).textTheme.bodyText2,
                          hintText: "Enter your phone number",
                          fillColor: Colors.white70,
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.white,
                          )),
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.radio_button_checked_rounded,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("We will send OTP to this number")
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: FlatButton(
                      child: Text("Login"),
                      color: Colors.white,
                      textColor: Colors.black,
                      onPressed: () {
                        if (formkey.currentState.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OTPScreen(
                                phone: phoneNo,
                              ),
                            ),
                          );
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        // side: BorderSide(color: Colors.red)
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
