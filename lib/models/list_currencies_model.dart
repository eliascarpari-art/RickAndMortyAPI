import 'character.dart';

class ListCurrencies {

  final List<CharacterModel> listCurrencies;

  ListCurrencies(this.listCurrencies);

  ListCurrencies.fromJson(Map<String, dynamic> json):
        listCurrencies = List.from(json['results'])
            .map((item) => CharacterModel.fromJson(item))
            .toList();
}