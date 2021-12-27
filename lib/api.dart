import 'dart:convert';
import 'package:http/http.dart';
import 'constants.dart';
import 'word_model.dart';

class API {
  final Uri uri = Uri.parse(Strings.words_url);

  Future<List<Word>> getWords() async {
    Response res = await get(uri);
    if(res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Word> words = body.map((dynamic item) => Word.fromJson(item)).toList();
      return words;
    }
    else {
      throw "NO WORDS FOR YOU";
    }
  }

  Future<List<Word>> getRandomWords(String num) async {
    Response res = await post(Uri.parse(Strings.words_url + "random"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'number': num
      }),
    );

    if(res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Word> words = body.map((dynamic item) => Word.fromJson(item)).toList();
      return words;
    }
    else {
      throw "NO WORDS FOR YOU";
    }
  }

  Future<bool> addWord(String eng, String rus, String add) async {
    Response res = await post(uri,
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'eng': eng,
          'rus': rus,
          'add': add
        }),
    );

    if(res.statusCode == 201) {
      return true;
    }
    else {
      throw "Bad words";
    }
  }

  Future<bool> editWord(String id, String eng, String rus, String add) async {
    Response res = await put(Uri.parse(Strings.words_url + id),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
        'eng': eng,
        'rus': rus,
        'add': add
        })
    );

    if(res.statusCode == 200) {
      return true;
    }
    else {
      throw "Bad words";
    }
  }

  Future<bool> deleteWord(String id) async {
    Response res = await delete(Uri.parse(Strings.words_url + id));

    if(res.statusCode == 200) {
      return true;
    }
    else {
      throw "CAN'T";
    }
  }
}