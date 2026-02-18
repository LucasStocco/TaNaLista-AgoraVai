import 'categoria.dart';

class Produto {
  final int? id;
  final String nome;
  final Categoria tipo;

  Produto({this.id, required this.nome, required this.tipo});

  // Cria um objeto Produto a partir de JSON
  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      id: json['id'] is int
          ? json['id'] as int
          : int.tryParse(json['id'].toString()),
      nome: json['nome'] as String,
      tipo: Categoria.fromJson(json['tipo'] as Map<String, dynamic>),
    );
  }

  // Converte o objeto Produto para JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'nome': nome, 'tipo': tipo.toJson()};
  }
}
