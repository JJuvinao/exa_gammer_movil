import 'modulo_model.dart';
import 'pregunta_model.dart';

class Curso {
  final int Id_curso;
  final String title;
  final String description;
  final List<ModuloModel> modules;
  final List<PreguntaModel> questions;
  final bool Completed;
  final int Num_sections;
  final int Percentage;
  final int Id_user;

  Curso({
    required this.Id_curso,
    required this.title,
    required this.description,
    required this.modules,
    required this.questions,
    required this.Completed,
    required this.Num_sections,
    required this.Percentage,
    required this.Id_user,
  });

  factory Curso.fromJson(Map<String, dynamic> json) {
    return Curso(
      Id_curso: json['Id_curso'] ?? 0,
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
      Completed: json['Completed'] ?? false,
      Num_sections: json['Num_sections'] ?? 0,
      Percentage: json['Percentage'] ?? 0,
      Id_user: json['Id_user'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id_curso': Id_curso,
      'title': title,
      'description': description,
      'modules': modules.map((e) => e.toJson()).toList(),
      'questions': questions.map((e) => e.toJson()).toList(),
      'Completed': Completed,
      'Num_sections': Num_sections,
      'Percentage': Percentage,
      'Id_user': Id_user,
    };
  }

  Map<String, dynamic> toUpdateJson() {
    return {
      'title': title,
      'description': description,
      'modules': modules.map((e) => e.toJson()).toList(),
      'questions': questions.map((e) => e.toJson()).toList(),
    };
  }
}
