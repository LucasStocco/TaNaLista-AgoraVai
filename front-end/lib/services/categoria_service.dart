import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/categoria.dart';
import '../config/api_config.dart';

class CategoriaService {
  // 📌 Buscar todas categorias
  Future<List<Categoria>> buscarCategorias() async {
    final url = Uri.parse('${ApiConfig.baseUrl}/categorias');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      // Garantir que cada item seja um Map<String, dynamic>
      return data
          .map((jsonItem) =>
              Categoria.fromJson(jsonItem as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception(
          'Erro ao buscar categorias: ${response.statusCode} - ${response.body}');
    }
  }
}
