import 'package:auto_size_text/auto_size_text.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'word_model.dart';
import 'api.dart';
import 'constants.dart';

class CardRoute extends StatefulWidget {
  @override
  _CardRouteState createState() => _CardRouteState();
}

class _CardRouteState extends State<CardRoute> {
  final API api = API();
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
  final TextStyle styleText2 = TextStyle(
    shadows: <Shadow>[
      Shadow(
        offset: Offset(0, 5),
        blurRadius: 6.0,
        color: TextShadow,
      )
    ],
    fontFamily: 'Avenir',
    fontSize: 30,
    color: TextColor,
    fontWeight: FontWeight.w500,
  );
  final ButtonStyle style = ElevatedButton.styleFrom(
    shadowColor: ButtonShadow,
    shape: new RoundedRectangleBorder(
      borderRadius: new BorderRadius.circular(10.0),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: FutureBuilder(
        future: api.getRandomWords('10'),
        builder: (BuildContext context, AsyncSnapshot<List<Word>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<Word>? words = snapshot.data;
            return Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Container(
                    child: FractionallySizedBox(
                      heightFactor: 0.25,
                      child: PageView.builder(
                        itemCount: words!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return FlipCard(
                            front: Card(
                              elevation: 5,
                              shadowColor: Colors.black,
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20.0),
                              ),
                              margin: EdgeInsets.fromLTRB(35, 10, 35, 10),
                              color: ButtonsColor,
                              child: Center(child: Column(
                                children: [
                                  SizedBox(height: 60),
                                  AutoSizeText(words[index].eng, style: styleText, maxLines: 1),
                                ],
                              ))
                            ),
                            back: Card(
                                elevation: 5,
                                shadowColor: Colors.black,
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                ),
                                margin: EdgeInsets.fromLTRB(35, 10, 35, 10),
                                color: ButtonsColor,
                                child: Center(child: Column(
                                  children: [
                                    SizedBox(height: 55),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: AutoSizeText(words[index].rus, style: styleText, maxLines: 1),
                                    ),
                                    AutoSizeText(words[index].add, style: styleText2, maxLines: 1)
                                  ],
                                ))
                            ),
                          );
                        },
                      )
                    ),
                  ),
                )
              ],
            );
          }
          if (snapshot.hasError) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          else {
            throw 'Lol';
          }
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back)
      ),
    );
  }
}