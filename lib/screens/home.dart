import 'package:flutter/material.dart';
import '../services/character.dart';
import '../models/character.dart';
import 'character_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CharacterService service = CharacterService();

  List<CharacterModel> personagens = [];
  List<CharacterModel> personagensFiltrados = [];

  String filtroStatus = 'Todos';

  @override
  void initState() {
    super.initState();
    carregarPersonagens();
  }

  void carregarPersonagens() async {
    final resultado = await service.fetchListCurrencies();

    setState(() {
      personagens = resultado.listCurrencies;
      personagensFiltrados = personagens;
    });
  }

  void filtrar(String texto) {
    setState(() {
      personagensFiltrados = personagens.where((personagem) {
        final nome = personagem.name.toLowerCase();
        final busca = texto.toLowerCase();

        final encontrouNome = nome.contains(busca);

        final encontrouStatus =
            filtroStatus == 'Todos' ||
                personagem.status.toLowerCase() == filtroStatus.toLowerCase();

        return encontrouNome && encontrouStatus;
      }).toList();
    });
  }

  void mudarStatus(String? status) {
    setState(() {
      filtroStatus = status!;

      personagensFiltrados = personagens.where((personagem) {
        final encontrouStatus =
            filtroStatus == 'Todos' ||
                personagem.status.toLowerCase() == filtroStatus.toLowerCase();

        return encontrouStatus;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick and Morty'),
      ),

      body: Column(
        children: [

          // BUSCA
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              onChanged: filtrar,
              decoration: InputDecoration(
                hintText: 'Buscar personagem...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          // FILTRO
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DropdownButtonFormField<String>(
              value: filtroStatus,
              decoration: const InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Todos',
                  child: Text('Todos'),
                ),
                DropdownMenuItem(
                  value: 'Alive',
                  child: Text('Vivo'),
                ),
                DropdownMenuItem(
                  value: 'Dead',
                  child: Text('Morto'),
                ),
                DropdownMenuItem(
                  value: 'unknown',
                  child: Text('Desconhecido'),
                ),
              ],
              onChanged: mudarStatus,
            ),
          ),

          const SizedBox(height: 10),

          // LISTA
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: personagensFiltrados.length,
              itemBuilder: (context, index) {
                final personagem = personagensFiltrados[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),

                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CharacterDetailsPage(
                                personagem: personagem,
                              ),
                        ),
                      );
                    },

                    child: Padding(
                      padding: const EdgeInsets.all(10),

                      child: Row(
                        children: [

                          // IMAGEM
                          ClipRRect(
                            borderRadius:
                            BorderRadius.circular(10),

                            child: Image.network(
                              personagem.image,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),

                          const SizedBox(width: 15),

                          // INFORMAÇÕES
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,

                              children: [

                                Text(
                                  personagem.name,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                Text(
                                  'Espécie: ${personagem.species}',
                                ),

                                const SizedBox(height: 5),

                                Text(
                                  'Status: ${personagem.status}',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}