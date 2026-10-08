import 'package:get/get.dart';

import '../models/character.dart';
import '../services/character.dart';

class ListCurrenciesController extends GetxController{

  CharacterService characterService = CharacterService();

  var isLoading = false.obs;

  var listCurrenciesObs = <CharacterModel>[].obs;

  static ListCurrenciesController get listCurrencie => Get.find();

  Future<dynamic> listCurrencies() async{
    isLoading.value = true;
    var list = await characterService.fetchListCurrencies();
    listCurrenciesObs.value = list.listCurrencies;
    isLoading.value = false;
    return listCurrenciesObs;
  }

}