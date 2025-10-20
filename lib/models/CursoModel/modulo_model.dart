import 'package:exa_gammer_movil/models/CursoModel/leccion_model.dart';

class ModuloModel {
  final int id;
  final String title;
  final String description;
  final List<LeccionModel> lessons;
  final bool Completed;

  ModuloModel({
    required this.id,
    required this.title,
    required this.description,
    required this.lessons,
    this.Completed = false,
  });

  factory ModuloModel.fromJson(Map<String, dynamic> json) {
    return ModuloModel(
      id: int.parse(json['id'].toString()),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      lessons:
          (json['lessons'] as List<dynamic>?)
              ?.map((e) => LeccionModel.fromJson(e))
              .toList() ??
          [],
      Completed: json['Completed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'lessons': lessons.map((e) => e.toJson()).toList(),
    'Completed': Completed,
  };
}
