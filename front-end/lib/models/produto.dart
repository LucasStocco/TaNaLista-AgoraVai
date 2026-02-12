import 'categoria.dart';

class Produto {
  final int? id;
  final String nome;
  final Categoria tipo;

  Produto({this.id, required this.nome, required this.tipo});

  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      id: json['id'],
      nome: json['nome'],
      tipo: Categoria.fromJson(json['tipo']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'tipo': tipo.toJson(),
  };
}
