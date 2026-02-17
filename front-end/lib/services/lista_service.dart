import 'dart:convert';
import 'package:crud_flutter/config/api_config.dart';
import 'package:http/http.dart' as http;
import '../models/lista.dart';

class ListaService {
  // Base URL do backend (USB ou rede local)
  static const String baseUrl = '${ApiConfig.baseUrl}/listas';

  // Rodar com emulador (caso queira)
  // static const String baseUrl = 'http://10.0.2.2:8088/listas';

  // CREATE - cria uma lista no backend e retorna a lista criada
  Future<Lista> create(Lista lista) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(lista.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = json.decode(response.body);
      return Lista.fromJson(data);
    } else {
      throw Exception(
        'Erro ao criar lista: ${response.statusCode} - ${response.body}',
      );
    }
  }

  // READ - busca todas as listas
  Future<List<Lista>> getAll() async {
    final response = await http.get(Uri.parse(baseUrl));

    print('STATUS CODE: ${response.statusCode}');
    print('BODY: ${response.body}');

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => Lista.fromJson(e)).toList();
    } else {
      throw Exception(
        'Erro ao buscar listas: ${response.statusCode} - ${response.body}',
      );
    }
  }

  // UPDATE - atualiza uma lista existente
  Future<Lista> update(Lista lista) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${lista.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(lista.toJson()),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Lista.fromJson(data);
    } else {
      throw Exception(
        'Erro ao atualizar lista: ${response.statusCode} - ${response.body}',
      );
    }
  }

  // DELETE - remove uma lista
  Future<void> delete(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 204 && response.statusCode != 200) {
      throw Exception(
        'Erro ao deletar lista: ${response.statusCode} - ${response.body}',
      );
    }
  }
}
