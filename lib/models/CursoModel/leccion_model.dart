class LeccionModel {
  final int id;
  final String title;
  final String content;
  bool completed;

  LeccionModel({
    required this.id,
    required this.title,
    required this.content,
    this.completed = false,
  });

  factory LeccionModel.fromJson(Map<String, dynamic> json) {
    return LeccionModel(
      id: int.parse(json['id'].toString()),
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      completed: json['completed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'content': content,
    'completed': completed,
  };
}
