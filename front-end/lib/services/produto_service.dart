import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/produto.dart';

class ProdutoService {
  static const String baseUrl = 'http://192.168.68.62:8088/itens';

  Future<List<Produto>> getAll() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List jsonData = jsonDecode(response.body);
      return jsonData.map((e) => Produto.fromJson(e)).toList();
    } else {
      throw Exception('Falha ao carregar produtos');
    }
  }
}
