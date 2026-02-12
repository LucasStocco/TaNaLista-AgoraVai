import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/item.dart';

class ItemService {
  static const String baseUrl = 'http://192.168.15.71:8088';

  // LISTAR ITENS
  Future<List<Item>> listar(int listaId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/listas/$listaId/itens'),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Item.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao listar itens: ${response.statusCode}');
    }
  }

  // CRIAR ITEM
  Future<Item> criar(int listaId, Item item) async {
    final response = await http.post(
      Uri.parse('$baseUrl/listas/$listaId/itens'),
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

  // ATUALIZAR ITEM
  Future<Item> atualizar(int listaId, Item item) async {
    final response = await http.put(
      Uri.parse('$baseUrl/listas/$listaId/itens/${item.id}'),
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
    final response = await http.delete(
      Uri.parse('$baseUrl/listas/$listaId/itens/$itemId'),
    );

    if (response.statusCode != 204) {
      throw Exception('Erro ao deletar item: ${response.statusCode}');
    }
  }
}
