import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:hexcolor/hexcolor.dart';

void main() => runApp(FlutterContactsExample());

class FlutterContactsExample extends StatefulWidget {
  @override
  _FlutterContactsExampleState createState() => _FlutterContactsExampleState();
}

class _FlutterContactsExampleState extends State<FlutterContactsExample> {
  List<Contact> _contacts;
  bool _permissionDenied = false;

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future _fetchContacts() async {
    if (!await FlutterContacts.requestPermission()) {
      setState(() => _permissionDenied = true);
    } else {
      final contacts = await FlutterContacts.getContacts();
      setState(() => _contacts = contacts);
    }
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
      home: Scaffold(

          // appBar: AppBar(title: Text('flutter_contacts_example')),
          body: _body()));

  Widget _body() {
    if (_permissionDenied) return Center(child: Text('Permission denied'));
    if (_contacts == null) return Center(child: CircularProgressIndicator());
    return ListView.builder(
        itemCount: _contacts.length,
        itemBuilder: (context, i) => ListTile(
            title: Text(_contacts[i].displayName),
            leading: (_contacts[i].thumbnail != null && _contacts[i].thumbnail.length > 0) ?
            CircleAvatar(
              backgroundImage: MemoryImage(_contacts[i].thumbnail),
            ) :
            Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        colors: [
                        HexColor("#43bdec"),
                        HexColor("#f2762e"),
                        ],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight
                    )
                ),
                child: CircleAvatar(
                    child: Text(
                        _contacts[i].displayName[0],
                        style: TextStyle(
                            color: Colors.white
                        )
                    ),
                    backgroundColor: Colors.transparent
                )
            ),
            // subtitle: Text(
            //     // _contacts[i].phones.elementAt(1).number,
            //
            //     _contacts[i].phones.length > 0 ? _contacts[i].phones.elementAt(0).number : ''
            // ),
            onTap: () async {
              final fullContact =
              await FlutterContacts.getContact(_contacts[i].id);
              await Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => ContactPage(fullContact)));
            }));
  }
}

class ContactPage extends StatelessWidget {
  final Contact contact;
  ContactPage(this.contact);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
          elevation: 0,
          titleSpacing: 0,
          backgroundColor: Colors.orange,
          title: Text(contact.displayName)
        // backgroundColor: Colors.blue,
      ),

      body: Center(
        child: Column(children: [
          Text('First name: ${contact.name.first}'),
          Text('Last name: ${contact.name.last}'),
          Text(
              'Phone number: ${contact.phones.isNotEmpty ? contact.phones.first.number : '(none)'}'),
          Text(
              'Email address: ${contact.emails.isNotEmpty ? contact.emails.first.address : '(none)'}'),
        ]),
      ));
}