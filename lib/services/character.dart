import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rickandmorth/models/list_currencies_model.dart';

class CharacterService {
  String url = "https://rickandmortyapi.com/api/character";

  Future<ListCurrencies> fetchListCurrencies() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> retorno = json.decode(response.body);

      return ListCurrencies.fromJson(retorno);
    } else {
      throw Exception('Falhou ao carregar');
    }
  }
}