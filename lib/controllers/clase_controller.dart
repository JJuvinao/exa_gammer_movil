import 'package:get/get.dart';
import 'package:exa_gammer_movil/models/clase_model.dart';

class ClaseController extends GetxController {

  var claseList = <clase>[].obs;
  var searchQuery = ''.obs;

  void addClase(String nombre, String tema, String autor) {
    claseList.add(clase(nombre: nombre, tema: tema, autor: autor));
  }

  void updateClase(int index, String newNombre, String newTema, String newAutor) {
    claseList[index] = clase(nombre: newNombre, tema: newTema, autor: newAutor);
  }

  void deleteClase(int index) {
    claseList.removeAt(index);
  }

  // Método para actualizar la búsqueda
  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  List<clase> get filteredList {
    if (searchQuery.value.isEmpty) {
      return claseList;
    } else {
      return claseList
          .where(
            (clase) => clase.nombre.toLowerCase().contains(
              searchQuery.value.toLowerCase(),
            ),
          )
          .toList();
    }
  }
}
