import 'package:get/get.dart';
import 'package:exa_gammer_movil/models/clase_model.dart';

class Clasesservices extends GetxService {
  var claseList = <clase>[].obs;

  Future<Clasesservices> init() async {
    return this;
  }
}
