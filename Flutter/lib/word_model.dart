class Word {
  final String id;
  final String eng;
  final String rus;
  final String add;

  Word({
    required this.id,
    required this.eng,
    required this.rus,
    required this.add,
  });

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      id: json['id'] as String,
      eng: json['eng'] as String,
      rus: json['rus'] as String,
      add: json['add'] as String,
    );
  }
}