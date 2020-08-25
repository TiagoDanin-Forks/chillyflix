import 'dart:ui';

import 'package:chillyflix/Widgets/AddotionalInfo.dart';
import 'package:chillyflix/Widgets/Poster.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:chillyflix/Services/TolokaService.dart';

class DetailPage extends StatefulWidget {
  final Movie item;
  DetailPage(this.item);
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      // needed for AndroidTV to be able to select
      // shortcuts: {LogicalKeySet(LogicalKeyboardKey.select): const Intent(ActivateAction.key)},
      shortcuts: {LogicalKeySet(LogicalKeyboardKey.select): const Intent()},
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: GoogleFonts.openSans().fontFamily,
        ),
        home: Scaffold(
            body: Container(
          color: Colors.black,
          child: Stack(
            children: <Widget>[
              buildBackdropImage(context),
              Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                        Colors.black.withAlpha(230),
                        Colors.transparent
                      ])),
                  child: buildItemDetails()),
            ],
          ),
        )),
      ),
    );
  }

  Widget buildBackdropImage(BuildContext context) {
    return Stack(
      children: <Widget>[
        FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image:
              (widget.item.hasPoster ? widget.item.poster : kTransparentImage),
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Positioned(
          top: 0,
          left: 0,
          bottom: 0,
          right: 0,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
            child: Container(color: Colors.black38),
          ),
        )
      ],
    );
  }

  Widget buildItemDetails() {
    return Column(children: [
      Padding(
          padding: const EdgeInsets.fromLTRB(30, 45, 0, 0),
          child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                widget.item.titleUk,
                style: GoogleFonts.oswald(
                    textStyle: TextStyle(color: Colors.white, fontSize: 28)),
              ))),
      Expanded(
        child: ListView(children: <Widget>[
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              Poster(widget.item),
              Container(
                child: Text(
                  widget.item.plotUk,
                  style: TextStyle(color: Colors.white),
                ),
                margin: EdgeInsets.fromLTRB(3, 15, 0, 15),
              ),
              AddotionalInfo(Icons.calendar_today, Colors.blue,
                  widget.item.year.toString()),
              AddotionalInfo(Icons.star, Color.fromARGB(255, 255, 180, 10),
                  widget.item.imdbRating.toStringAsPrecision(2)),
              AddotionalInfo(Icons.camera_roll, Colors.greenAccent,
                  widget.item.runtime.toString() + " хвилин"),
              AddotionalInfo(Icons.description, Colors.lime,
                  widget.item.genres.map((e) => e.name).join(", ")),
            ],
          ),
          FlatButton(
            onPressed: () {},
            child: Text('PLAY'),
            color: Color.fromARGB(255, 255, 60, 70),
            textColor: Colors.white,
          )
        ]),
      )
    ]);
  }
}
