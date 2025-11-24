import 'package:exa_gammer_movil/controllers/examen_controller.dart';
import 'package:exa_gammer_movil/controllers/user_controller.dart';
import 'package:exa_gammer_movil/game/ahorcado/ui/ahorcado_page.dart';
import 'package:exa_gammer_movil/game/heroes/controller/pregunta_controller.dart';
import 'package:exa_gammer_movil/game/heroes/ui/personajes.dart';
import 'package:exa_gammer_movil/models/examen_model.dart';
import 'package:exa_gammer_movil/ui/home/vista/clase/clase_view.dart';
import 'package:exa_gammer_movil/ui/home/vista/examen/widget/conte_Estud.dart';
import 'package:exa_gammer_movil/ui/home/vista/examen/widget/conte_Profe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetalleExamenPage extends StatefulWidget {
  const DetalleExamenPage({super.key});

  @override
  State<DetalleExamenPage> createState() => _DetalleExamenPageState();
}

class _DetalleExamenPageState extends State<DetalleExamenPage> {
  late final ExamenController pc;
  late final UserController user;
  late final PreguntaController preguntaController;

  late dynamic examen;
  List<Ahorcado> listaahorcado = [];
  List<Heroes> listher = [];

  Resultados resultados = Resultados(
    id: 0,
    id_Estudiane: 0,
    id_Examen: 0,
    resultados: [],
  );

  bool hayresultados = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    pc = Get.find();
    user = Get.find();
    preguntaController = Get.find();
    examen = pc.getexamen;

    _inicializarDatos();
  }

  Future<void> _inicializarDatos() async {
    if (examen.id_juego == 2) {
      await cargarListaHeroes();
    } else {
      await cargarListaAhorcado();
    }
    await cargarContenido();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> cargarListaAhorcado() async {
    var list = await pc.listaAhorcados(examen.codigo, user.gettoken);
    setState(() {
      listaahorcado = list;
    });
  }

  Future<void> cargarListaHeroes() async {
    var list = await pc.listaHeroes(examen.codigo, user.gettoken);
    setState(() {
      listher = list;
    });
  }

  Future<void> cargarContenido() async {
    try {
      final r = await pc.ResultadoEstudiante(
        user.getuser.id,
        examen.id,
        user.gettoken,
      );
      setState(() {
        resultados = Resultados(
          id: r.id,
          id_Estudiane: r.id_Estudiane,
          id_Examen: r.id_Examen,
          resultados: r.resultados,
          nota: r.nota,
          recomendacion: r.recomendacion,
        );
      });
      if (resultados.id == 0) {
        hayresultados = true;
      } else {
        hayresultados = false;
      }
    } catch (e) {
      setState(() {
        hayresultados = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.to(() => ClaseView(vista: "Clase"));
        return false;
      },
      child: Scaffold(
        backgroundColor: Color(0xFF0a0a14),
        appBar: AppBar(
          backgroundColor: Color(0xFF1a1a2e),
          elevation: 0,
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(color: Color(0xFF00F0FF)),
          centerTitle: true,
          title: ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [Color(0xFF00F0FF), Color(0xFF00FF41)],
            ).createShader(bounds),
            child: Text(
              "Detalle del Examen",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20,
                shadows: [
                  Shadow(
                    color: Color(0xFF00F0FF).withOpacity(0.5),
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1a1a2e), Color(0xFF16213e)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFF00F0FF).withOpacity(0.3),
                  width: 1.5,
                ),
              ),
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0a0a14), Color(0xFF16213e), Color(0xFF0a0a14)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: isLoading
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color(0xFF00F0FF),
                        ),
                      ),
                      SizedBox(height: 16),
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [Color(0xFF00F0FF), Color(0xFF00FF41)],
                        ).createShader(bounds),
                        child: Text(
                          "Cargando examen...",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Card principal de información del examen
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF1a1a2e), Color(0xFF16213e)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Color(0xFF00F0FF).withOpacity(0.3),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF00F0FF).withOpacity(0.2),
                              blurRadius: 20,
                              spreadRadius: 1,
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 30,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // Logo
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF00F0FF),
                                    Color(0xFF00FF41),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF00F0FF).withOpacity(0.5),
                                    blurRadius: 20,
                                  ),
                                ],
                              ),
                              child: Image.asset(
                                'assets/imagen/logo_exa.png',
                                height: 70,
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Nombre del examen
                            ShaderMask(
                              shaderCallback: (bounds) => LinearGradient(
                                colors: [Color(0xFF00F0FF), Color(0xFF00FF41)],
                              ).createShader(bounds),
                              child: Text(
                                examen.nombre,
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "TitanOne",
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      color: Color(0xFF00F0FF),
                                      blurRadius: 15,
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Divider decorativo
                            Container(
                              height: 2,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    Color(0xFF00F0FF).withOpacity(0.5),
                                    Color(0xFF00FF41).withOpacity(0.5),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Información del tipo de juego
                            _buildInfoRow(
                              Icons.gamepad_rounded,
                              "Tipo de Juego",
                              examen.id_juego == 1
                                  ? "Ahorcado"
                                  : examen.id_juego == 2
                                  ? "Héroes"
                                  : "Desconocido",
                              Color(0xFF00F0FF),
                            ),

                            const SizedBox(height: 16),

                            // Estado del examen
                            _buildEstadoExamen(),

                            const SizedBox(height: 24),

                            // Botón de iniciar examen
                            _buildIniciarButton(),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Contenido específico según el rol
                      user.getuser.rol == "Profesor"
                          ? ConteProfe(
                              examen: examen,
                              listher: listher,
                              listaAhorcado: listaahorcado,
                            )
                          : ConteEstu(
                              user: user.getuser,
                              token: user.gettoken,
                              examen: examen,
                              listher: listher,
                              listaAhorcado: listaahorcado,
                              resultados: resultados,
                            ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: color.withOpacity(0.5), width: 1.5),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEstadoExamen() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: hayresultados
              ? [
                  Color(0xFF00FF41).withOpacity(0.1),
                  Color(0xFF00F0FF).withOpacity(0.1),
                ]
              : [Colors.orange.withOpacity(0.1), Colors.red.withOpacity(0.1)],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: hayresultados
              ? Color(0xFF00FF41).withOpacity(0.5)
              : Colors.orange.withOpacity(0.5),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: hayresultados
                    ? [Color(0xFF00FF41), Color(0xFF00F0FF)]
                    : [Colors.orange, Colors.red],
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: hayresultados
                      ? Color(0xFF00FF41).withOpacity(0.5)
                      : Colors.orange.withOpacity(0.5),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Icon(
              hayresultados
                  ? Icons.check_circle_rounded
                  : Icons.assignment_turned_in_rounded,
              color: Colors.black,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Estado",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  hayresultados ? "Disponible" : "Ya completado",
                  style: TextStyle(
                    fontSize: 16,
                    color: hayresultados ? Color(0xFF00FF41) : Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIniciarButton() {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        gradient: hayresultados
            ? LinearGradient(colors: [Color(0xFF00F0FF), Color(0xFF00FF41)])
            : LinearGradient(colors: [Colors.grey[700]!, Colors.grey[800]!]),
        borderRadius: BorderRadius.circular(12),
        boxShadow: hayresultados
            ? [
                BoxShadow(
                  color: Color(0xFF00F0FF).withOpacity(0.4),
                  blurRadius: 15,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          disabledBackgroundColor: Colors.transparent,
        ),
        onPressed: hayresultados
            ? () {
                if (examen.id_juego != 2) {
                  Get.to(
                    () => AhorcadoPage(
                      ahorcados: listaahorcado,
                      id_user: user.getuser.id,
                      token: user.gettoken,
                      id_examen: examen.id,
                    ),
                  );
                  return;
                } else {
                  preguntaController.cargarPreguntas(
                    listher,
                    user.getuser.id,
                    user.gettoken,
                    examen.id,
                  );
                  Get.to(() => PersonajesPage());
                }
              }
            : null,
        icon: Icon(
          hayresultados ? Icons.play_arrow_rounded : Icons.block_rounded,
          color: hayresultados ? Colors.black : Colors.grey[500],
          size: 24,
        ),
        label: Text(
          hayresultados ? 'Iniciar Examen' : 'Examen Completado',
          style: TextStyle(
            color: hayresultados ? Colors.black : Colors.grey[500],
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
