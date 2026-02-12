import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/produto.dart';

class ProdutoService {
  final String baseUrl = 'http://10.0.2.2:8088/listas';

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
