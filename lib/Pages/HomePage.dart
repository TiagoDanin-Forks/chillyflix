import 'package:chillyflix/Pages/SettingsPage.dart';
import 'package:chillyflix/Tabs/MoviesTab.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 1,
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 35, 40, 50),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Row(
              children: <Widget>[
                Text(widget.title),
                SizedBox(width: 50),
              ],
            ),
            actions: <Widget>[
              IconButton(icon: Icon(Icons.search),onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));}),
              IconButton(icon: Icon(Icons.settings),onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));}),
            ],
          ),
          body: Center(
            child: TabBarView(
              children: <Widget>[
                MoviesTab(),
              ],
            ),
          ),
        ),
    );
  }
}
