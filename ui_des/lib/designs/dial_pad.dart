import 'package:flutter/material.dart';
import 'package:flutter_dialpad_plus/flutter_dialpad_plus.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ui_des/designs/contacts.dart';
import 'package:ui_des/designs/contacts_list.dart';
import 'package:ui_des/designs/nav_bar.dart';

void main() => runApp(DialPapHome());

class DialPapHome extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<DialPapHome> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: Colors.blue[100],
          drawer: NavBar(),

          appBar: AppBar(
            elevation: 0,
            titleSpacing: 0,
            backgroundColor: HexColor("#00B6FE"),
            title: Text("Dial360"),
            // leading: IconButton(icon: Icon(Icons.menu), onPressed: (){
            // //h
            //   NavBar();
            // }),
            actions: [
              IconButton(icon: Icon(Icons.notifications), onPressed: (){
                //h
              }),
              IconButton(icon: Icon(Icons.verified_user), onPressed: (){
                //h
              }),
              IconButton(icon: Icon(Icons.search), onPressed: (){
                //h
              }),
            ], // actions
          bottom: TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 5,
            tabs: [
              Tab(
                icon: Icon(Icons.home),
                text: "Home",
              ),
              Tab(
                icon: Icon(Icons.person),
                text: "Contacts",
              ),
              Tab(
                icon: Icon(Icons.message),
                text: "Chats",
              ),
              Tab(
                icon: Icon(Icons.lock_clock),
                text: "Recents",
              )
            ],

          ),





          ),
          body: TabBarView(
            
            children: [

              DialPad(
                  keyPadTextColor: Colors.black87,
                  // dialButtonIconColor: Colors.indigo,
                  keyPadColor: Colors.blue[100],
                  outputMask: //Visual formatting of input
                  "0000 000 00 00", //Here you can mask the display of inserted number. unformatted text won't show up.

                  dialButtonColor: Colors.greenAccent[400],
                  dialButtonIconColor: Colors.yellowAccent[100],
                  buttonIcon: Icons.call,
                  enableDtmf: true,
                  backspaceButtonIconColor: Colors.white,
                  useNumber: (number) {
                    //use this `number` variable for any reference or implementation.
                    print(number);
                  }),
              buildPage("Contacts"),
              // buildPage("Home"),
              // buildPage("About"),
              ContactsPage(),
              FlutterContactsExample(),
            ],
          )
        ),
      ),


    );

  }

  Widget buildPage(String text) => Center(
    child: Text(
      text,
      style: TextStyle(fontSize: 34),
    ),
  );


}