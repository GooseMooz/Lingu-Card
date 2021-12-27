import 'package:flutter/material.dart';
import 'word_model.dart';
import 'api.dart';
import 'constants.dart';

class SecondRoute extends StatelessWidget {
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
    fontSize: 27,
    color: TextColor,
    fontWeight: FontWeight.w900,
  );
  final TextStyle styleSmallText = TextStyle(
    fontFamily: 'Avenir',
    fontSize: 20,
    color: ButtonsColor,
    fontWeight: FontWeight.w900,
  );

  @override
  Widget build(BuildContext context) {

    String english_inp = "";
    String russian_inp = "";
    String additional_inp = "";

    return Scaffold(
      appBar: AppBar(
        title: Text("Words List", style: styleText,)
      ),
      body: FutureBuilder(
        future: api.getWords(),
        builder: (context, AsyncSnapshot<List<Word>> snapshot) {
          if (snapshot.hasData) {
            List<Word>? words = snapshot.data;
            return ListView(
              children:
                words!.map((Word word) => ListTile(
                  title: Row(
                    children: <Widget>[
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 3,
                        child: Center(child: Text(word.eng)),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 4,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: Colors.black54,
                                width: 1
                              ),
                              right: BorderSide(
                                  color: Colors.black54,
                                  width: 1
                              ),
                            ),
                          ),
                            child: Center(
                                child: Text(word.rus))),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 3,
                        child: Center(child: Text(word.add)),
                      )
                    ],
                  ),
                  onTap: () {
                    String eng_word = word.eng;
                    String rus_word = word.rus;
                    String add_word = word.add;
                    showDialog(context: context, builder: (context) => SimpleDialog(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                          child: TextFormField(
                            initialValue: word.eng,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'English Word',
                              hintText: word.eng,
                            ),
                            onChanged: (text_eng) {
                              eng_word = text_eng;
                            },
                            enableSuggestions: false,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                          child: TextFormField(
                            initialValue: word.rus,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Russian Word',
                              hintText: word.rus,
                            ),
                            onChanged: (text_rus) {
                              rus_word = text_rus;
                            },
                            enableSuggestions: false,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                          child: TextFormField(
                            initialValue: word.add,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Additional Word',
                              hintText: word.add,
                            ),
                            onChanged: (text_add) {
                              add_word = text_add;
                            },
                            enableSuggestions: false,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(64, 16, 64, 8),
                          child: ElevatedButton(
                              onPressed: () {
                                api.editWord(word.id, eng_word, rus_word, add_word);
                                Navigator.of(context).pop();
                              },
                              child: Text("Edit Word")
                          ),
                        )
                      ],
                    ));
                  },
                  onLongPress: () {
                    const snackBar = SnackBar(content: Text("Deleted Word"));
                    api.deleteWord(word.id);
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
              )).toList(),
            );
          }
          if(snapshot.hasError) {
            throw "smth went wrong";
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (context) => SimpleDialog(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'English Word',
                    hintText: '',
                  ),
                  onChanged: (text_eng) {
                    english_inp = text_eng;
                  },
                  enableSuggestions: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Russian Word',
                    hintText: '',
                  ),
                  onChanged: (text_rus) {
                    russian_inp = text_rus;
                  },
                  enableSuggestions: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Additional Word',
                    hintText: '',
                  ),
                  onChanged: (text_add) {
                    additional_inp = text_add;
                  },
                  enableSuggestions: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(64, 16, 64, 8),
                child: ElevatedButton(
                    onPressed: () {
                      api.addWord(english_inp, russian_inp, additional_inp);
                      Navigator.of(context).pop();
                    },
                    child: Text("Add Word")
                ),
              )
            ],
          ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}