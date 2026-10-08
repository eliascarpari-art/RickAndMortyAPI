import 'package:flutter/material.dart';
import '../models/character.dart';

class CharacterDetailsPage extends StatelessWidget {
  final CharacterModel personagem;

  const CharacterDetailsPage({
    super.key,
    required this.personagem,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(personagem.name),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            // IMAGEM
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                personagem.image,
                width: 250,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),

            // NOME
            Text(
              personagem.name,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // DETALHES
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [

                    detalhe(
                      'ID',
                      personagem.id.toString(),
                    ),

                    detalhe(
                      'Status',
                      personagem.status,
                    ),

                    detalhe(
                      'Espécie',
                      personagem.species,
                    ),

                    detalhe(
                      'Gênero',
                      personagem.gender,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget detalhe(String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            titulo,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),

          Text(
            valor,
            style: const TextStyle(
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}