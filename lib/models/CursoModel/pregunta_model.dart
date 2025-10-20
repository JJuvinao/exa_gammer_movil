class PreguntaModel {
  final int id;
  final String text;
  final List<String> options;
  final int answerIndex;
  final String response;
  final bool Completed;

  PreguntaModel({
    required this.id,
    required this.text,
    required this.options,
    required this.answerIndex,
    required this.response,
    this.Completed = false,
  });

  factory PreguntaModel.fromJson(Map<String, dynamic> json) {
    return PreguntaModel(
      id: int.parse(json['id'].toString()),
      text: json['text'] ?? '',
      options: List<String>.from(json['options'] ?? []),
      answerIndex: json['answerIndex'] ?? 0,
      response: json['response'] ?? '',
      Completed: json['Completed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'text': text,
    'options': options,
    'answerIndex': answerIndex,
    'response': response,
    'Completed': Completed,
  };
}
