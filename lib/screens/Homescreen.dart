import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kinder_alarm/screens/phone_book.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);
  static const routeName = "homescreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: Image.asset('images/logoK.png'),
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
                    Text("Add Contacts to be informed")
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Text("03122887232"),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: FlatButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(Icons.contact_page),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Add From Phone Book"),
                      ],
                    ),
                    color: Colors.white,
                    textColor: Colors.black,
                    onPressed: () {
                      Navigator.of(context).pushNamed(PhoneBook.routeName);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      // side: BorderSide(color: Colors.red)
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: FlatButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.send),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Send Alert")
                      ],
                    ),
                    color: Colors.white,
                    textColor: Colors.black,
                    onPressed: () {},
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
    );
  }
}
