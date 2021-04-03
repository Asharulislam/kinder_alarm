import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PhoneBook extends StatefulWidget {
  static const routeName = "phonebook";

  @override
  _PhoneBookState createState() => _PhoneBookState();
}

class _PhoneBookState extends State<PhoneBook> {
  List<Contact> contacts = [];
  List<Contact> contactsFiltered = [];
  var checkmark = List<bool>();
  List<Contact> spContact = [];
  Map<String, Color> contactsColorMap = new Map();
  TextEditingController searchController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    getPermissions();
  }

  getPermissions() async {
    if (await Permission.contacts.request().isGranted) {
      getAllContacts();
      searchController.addListener(() {
        filterContacts();
      });
    }
  }

  String flattenPhoneNumber(String phoneStr) {
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }

  getAllContacts() async {
    List colors = [Colors.green, Colors.indigo, Colors.yellow, Colors.orange];
    int colorIndex = 0;
    List<Contact> _contacts = (await ContactsService.getContacts()).toList();

    _contacts.forEach((contact) {
      Color baseColor = colors[colorIndex];
      contactsColorMap[contact.displayName] = baseColor;
      colorIndex++;
      if (colorIndex == colors.length) {
        colorIndex = 0;
      }
    });
    setState(() {
      contacts = _contacts;
    });
    for (int i = 0; i < contacts.length; i++) {
      checkmark.add(false);
    }
  }

  filterContacts() {
    List<Contact> _contacts = [];
    _contacts.addAll(contacts);
    if (searchController.text.isNotEmpty) {
      _contacts.retainWhere((contact) {
        String searchTerm = searchController.text.toLowerCase();
        String searchTermFlatten = flattenPhoneNumber(searchTerm);
        String contactName = contact.displayName.toLowerCase();
        bool nameMatches = contactName.contains(searchTerm);
        if (nameMatches == true) {
          return true;
        }

        if (searchTermFlatten.isEmpty) {
          return false;
        }

        var phone = contact.phones.firstWhere((phn) {
          String phnFlattened = flattenPhoneNumber(phn.value);
          return phnFlattened.contains(searchTermFlatten);
        }, orElse: () => null);

        return phone != null;
      });
    }
    setState(() {
      contactsFiltered = _contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isSearching = searchController.text.isNotEmpty;
    bool listItemsExist = (contactsFiltered.length > 0 || contacts.length > 0);
    return SafeArea(
      child: Scaffold(
        floatingActionButton: spContact.length > 0
            ? FloatingActionButton(
                backgroundColor: Colors.red[400],
                onPressed: () {},
                child: Icon(Icons.check),
              )
            : Container(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
       
        body: Container(
          // padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/background.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                      labelText: 'Search',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      ),
                      prefixIcon: Icon(Icons.search, color: Colors.white)),
                ),
              ),
              listItemsExist == true
                  ? Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: isSearching == true
                            ? contactsFiltered.length
                            : contacts.length,
                        itemBuilder: (context, index) {
                          Contact contact = isSearching == true
                              ? contactsFiltered[index]
                              : contacts[index];

                          var baseColor =
                              contactsColorMap[contact.displayName] as dynamic;

                          Color color1 = baseColor[800];
                          Color color2 = baseColor[400];
                          return ListTile(
                            title: Text(contact.displayName),
                            subtitle: Text(contact.phones.length > 0
                                ? contact.phones.elementAt(0).value
                                : ''),
                            leading: (contact.avatar != null &&
                                    contact.avatar.length > 0)
                                ? CircleAvatar(
                                    backgroundImage:
                                        MemoryImage(contact.avatar),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                            colors: [
                                              color1,
                                              color2,
                                            ],
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.topRight)),
                                    child: CircleAvatar(
                                        child: Text(contact.initials(),
                                            style:
                                                TextStyle(color: Colors.white)),
                                        backgroundColor: Colors.transparent),
                                  ),
                            trailing: Checkbox(
                                value: checkmark[index],
                                activeColor: Colors.green,
                                onChanged: (bool newValue) {
                                  checkmark[index] == false
                                      ? setState(() {
                                          checkmark[index] = !checkmark[index];
                                          spContact.add(contacts[index]);
                                          print(spContact);
                                        })
                                      : setState(() {
                                          spContact.remove(contacts[index]);
                                          checkmark[index] = !checkmark[index];
                                          print(spContact);
                                        });
                                }),
                          );
                        },
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.all(20),
                      child: Text(
                          isSearching
                              ? 'No search results to show'
                              : 'Loading Contacts please wait',
                          style: Theme.of(context).textTheme.headline6),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
