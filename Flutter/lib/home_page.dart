import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'card_route.dart';
import 'second_route.dart';
double amt = 50;
double scroller_amt = 50;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        primary: ButtonsColor,
        shadowColor: ButtonShadow,
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
        ),
    );

    final TextStyle styleText = TextStyle(
      shadows: <Shadow>[
        Shadow(
          offset: Offset(0, 5),
          blurRadius: 6.0,
          color: TextShadow,
        )
      ],
      fontFamily: 'Avenir',
      fontSize: 52,
      color: TextColor,
      fontWeight: FontWeight.w900,
    );

    return Scaffold(
      backgroundColor: BackgroundColor,
      body: Container(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                      Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Lingu/Card',
                              style: TextStyle(
                                fontFamily: 'Avenir',
                                fontSize: 52,
                                color: TextColor,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                      )
                  ],
                )
              ), //Top "Lingu/Card" Card
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 125),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        style: style,
                        onPressed: () {
                          amt = 10;
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CardRoute())
                          );
                        },
                        child: Text('10', style: styleText)
                      ),
                      SizedBox(width: 15),
                      ElevatedButton(
                          style: style,
                          onPressed: () {
                            amt = 25;
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CardRoute())
                          );},
                          child: SizedBox(
                            height: 71,
                            width: 65,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('25', style: styleText),
                              ],
                            )
                          )
                      ),
                      SizedBox(width: 15),
                      ElevatedButton(
                          style: style,
                          onPressed: () {
                            amt = 50;
                          },
                          child: Text('50', style: styleText)
                      ),
                    ],
                  ),
                  SizedBox(height: 15)
                ],
              ),
              Column(
                  children: <Widget>[
                  ElevatedButton(
                      style: style,
                      onPressed: () {

                      },
                      child:
                        SizedBox(
                          width: 140,
                          child: Column(
                            children: <Widget>[
                              Text(scroller_amt.round().toString(), style: styleText)
                            ],
                          ),
                        ), //Text(amt.round().toString(), style: styleText)
                  ),
                ]
              ),
              CupertinoSlider(
                  value: scroller_amt,
                  min: 1,
                  max: 100,
                  onChanged: (double value) {
                    setState(() {
                      scroller_amt = value;
                    });
                  }),
              SizedBox(height: 225),
              Row(
                children: <Widget>[
                  SizedBox(width: 285),
                  SpeedDial(
                    backgroundColor: ButtonsColor,
                    overlayOpacity: 0.0,
                    animatedIcon: AnimatedIcons.menu_close,
                    spacing: 5,
                    children: [
                      SpeedDialChild(
                        child: Icon(
                          Icons.edit,
                          color: ButtonsColor
                        ),
                        label: 'Edit Words',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SecondRoute())
                          );
                        }
                      )
                    ],
                  )
                ],
              ),
            ]
          )
        ),
      ),
    );
  }
}