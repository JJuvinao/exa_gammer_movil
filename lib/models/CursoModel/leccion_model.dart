class LeccionModel {
  final int id;
  final String title;
  final String content;
  final bool Completed;

  LeccionModel({
    required this.id,
    required this.title,
    required this.content,
    this.Completed = false,
  });

  factory LeccionModel.fromJson(Map<String, dynamic> json) {
    return LeccionModel(
      id: int.parse(json['id'].toString()),
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      Completed: json['Completed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'content': content,
    'Completed': Completed,
  };
}
