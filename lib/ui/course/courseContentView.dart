import 'package:exa_gammer_movil/controllers/curso_controller.dart';
import 'package:exa_gammer_movil/ui/course/widget/modulesTab.dart';
import 'package:exa_gammer_movil/ui/course/widget/questionsTab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Coursecontentview extends StatefulWidget {
  const Coursecontentview({super.key});

  @override
  State<Coursecontentview> createState() => _CoursecontentviewState();
}

class _CoursecontentviewState extends State<Coursecontentview>
    with TickerProviderStateMixin {
  final CursoController controller = Get.find();
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.index = 0;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final curso = controller.selectedCurso!.value;
    return WillPopScope(
      onWillPop: () async {
        await controller.RefreshAndSave();
        return true;
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 10, 10, 20),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 19, 10, 20),
          iconTheme: IconThemeData(color: Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.all(Radius.circular(10)),
            side: BorderSide(color: const Color.fromARGB(255, 77, 0, 110)),
          ),
          title: Text(
            curso.title,
            style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF0a0a14),
                Color.fromARGB(255, 22, 33, 62),
                Color(0xFF0a0a14),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: DefaultTabController(
            length: 2,
            initialIndex: 0,
            child: Column(
              children: [
                Container(
                  color: const Color.fromARGB(255, 21, 21, 41),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        curso.title,
                        style: TextStyle(
                          color: Color.fromARGB(255, 173, 173, 173),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Colors.grey),
                          gradient: LinearGradient(
                            colors: [
                              const Color.fromARGB(255, 24, 24, 48),
                              const Color.fromARGB(255, 21, 21, 41),
                              const Color.fromARGB(255, 24, 24, 48),
                            ],
                          ),
                        ),
                        child: ExpansionTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.all(
                              Radius.circular(10),
                            ),
                          ),
                          title: Text(
                            "Ver descripción",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                          collapsedIconColor: Colors.blue[700],
                          iconColor: Colors.blue[900],
                          childrenPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          children: [
                            Text(
                              curso.description,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Obx(() {
                        return LinearProgressIndicator(
                          value:
                              controller.selectedCurso!.value.percentage / 100,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.green,
                          ),
                        );
                      }),
                      SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: curso.codigo));
                          Get.snackbar("Copiado", curso.codigo);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: Colors.grey),
                            gradient: LinearGradient(
                              colors: [
                                const Color.fromARGB(255, 24, 24, 48),
                                const Color.fromARGB(255, 21, 21, 41),
                                const Color.fromARGB(255, 24, 24, 48),
                              ],
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Codigo del curso: ${curso.codigo}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue[700],
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                TabBar(
                  controller: _tabController,
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.grey,

                  onTap: (index) {
                    if (index == 1 && !controller.AreModulesCompleted()) {
                      print("controller.AreModulesCompleted()");
                      Get.snackbar(
                        "Acceso restringido",
                        "Debes completar todas las lecciones primero",
                        backgroundColor: Colors.orange,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      _tabController.animateTo(0);
                      return;
                    }
                  },
                  tabs: const [
                    Tab(icon: Icon(Icons.menu_book), text: 'Módulos'),
                    Tab(icon: Icon(Icons.quiz), text: 'Preguntas'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [ModulesTab(), QuestionsTab()],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
