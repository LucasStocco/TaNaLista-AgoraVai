import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/item.dart';
import '../config/api_config.dart';

class ItemService {
  // Base URL do backend (IP CORRETO)
  static const String baseUrl = ApiConfig.baseUrl;
  // LISTAR ITENS de uma lista específica
  Future<List<Item>> listar(int listaId) async {
    final url = Uri.parse('$baseUrl/listas/$listaId/itens');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Item.fromJson(e)).toList();
    } else {
      throw Exception(
        'Erro ao listar itens: ${response.statusCode} - ${response.body}',
      );
    }
  }

  // CRIAR ITEM em uma lista específica
  Future<Item> criar(int listaId, Item item) async {
    final url = Uri.parse('$baseUrl/listas/$listaId/itens');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(item.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Item.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
        'Erro ao criar item: ${response.statusCode} - ${response.body}',
      );
    }
  }

  // ATUALIZAR ITEM existente
  Future<Item> atualizar(int listaId, Item item) async {
    final url = Uri.parse('$baseUrl/listas/$listaId/itens/${item.id}');

    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(item.toJson()),
    );

    if (response.statusCode == 200) {
      return Item.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
        'Erro ao atualizar item: ${response.statusCode} - ${response.body}',
      );
    }
  }

  // DELETAR ITEM
  Future<void> deletar(int listaId, int itemId) async {
    final url = Uri.parse('$baseUrl/listas/$listaId/itens/$itemId');

    final response = await http.delete(url);

    if (response.statusCode != 204) {
      throw Exception(
        'Erro ao deletar item: ${response.statusCode} - ${response.body}',
      );
    }
  }
}
