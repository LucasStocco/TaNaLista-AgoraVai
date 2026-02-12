import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/lista.dart';

class ListaService {
  static const String baseUrl = 'http://192.168.15.71:8088/listas';

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
      throw Exception('Erro ao criar lista');
    }
  }

  // READ - busca todas as listas
  Future<List<Lista>> getAll() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => Lista.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar listas');
    }
  }

  // UPDATE - atualiza uma lista existente
  Future<Lista> update(Lista lista) async {
    final url = Uri.parse('$baseUrl/${lista.id}');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(lista.toJson()),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Lista.fromJson(data);
    } else {
      throw Exception('Erro ao atualizar lista');
    }
  }

  // DELETE - remove uma lista
  Future<void> delete(int id) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.delete(url);

    if (response.statusCode != 204 && response.statusCode != 200) {
      throw Exception('Erro ao deletar lista');
    }
  }
}
