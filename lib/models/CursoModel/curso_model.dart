import 'modulo_model.dart';
import 'pregunta_model.dart';

class Curso {
  final int id_curso;
  final String title;
  final String description;
  final List<ModuloModel> modules;
  final List<PreguntaModel> questions;
  bool completed;
  final int num_sections;
  int completed_sections;
  int percentage;
  final int id_user;
  final String codigo;

  Curso({
    required this.id_curso,
    required this.title,
    required this.description,
    required this.modules,
    required this.questions,
    required this.completed,
    required this.num_sections,
    required this.completed_sections,
    required this.percentage,
    required this.id_user,
    required this.codigo,
  });

  factory Curso.fromJson(Map<String, dynamic> json) {
    return Curso(
      id_curso: json['id_curso'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      modules:
          (json['modules'] as List<dynamic>?)
              ?.map((e) => ModuloModel.fromJson(e))
              .toList() ??
          [],
      questions:
          (json['questions'] as List<dynamic>?)
              ?.map((e) => PreguntaModel.fromJson(e))
              .toList() ??
          [],
      completed: json['completed'] ?? false,
      num_sections: json['num_sections'] ?? 0,
      completed_sections: json['completed_sections'] ?? 0,
      percentage: json['percentage'] ?? 0,
      id_user: json['id_user'] ?? 0,
      codigo: json["codigo"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_curso': id_curso,
      'title': title,
      'description': description,
      'modules': modules.map((e) => e.toJson()).toList(),
      'questions': questions.map((e) => e.toJson()).toList(),
      'completed': completed,
      'num_sections': num_sections,
      'completed_sections': completed_sections,
      'percentage': percentage,
      'id_user': id_user,
      'codigo': codigo,
    };
  }

  Map<String, dynamic> toUpdateJson() {
    return {
      'id_curso': id_curso,
      'title': title,
      'description': description,
      'modules': modules.map((e) => e.toJson()).toList(),
      'questions': questions.map((e) => e.toJson()).toList(),
      "completed": completed,
      "completed_sections": completed_sections,
      "percentage": percentage,
      "id_user": id_user,
    };
  }
}
