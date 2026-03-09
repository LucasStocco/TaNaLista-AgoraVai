import 'categoria.dart';

class Item {
  final int? id;
  final String nome;
  final String? descricao;
  final int quantidade;
  final double preco;
  final Categoria categoria;

  Item({
    this.id,
    required this.nome,
    this.descricao,
    required this.quantidade,
    required this.preco,
    required this.categoria,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      nome: json['nome'],
      descricao: json['descricao'],
      quantidade: json['quantidade'],
      preco: (json['preco'] as num).toDouble(),
      categoria: Categoria.fromJson(
        json['categoria'] ?? {'id': 0, 'nome': 'Sem Categoria'},
      ),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'nome': nome,
      'quantidade': quantidade,
      'preco': preco,
      'categoriaId': categoria.id,
    };

    // adiciona descricao somente se não for nula ou vazia
    if (descricao != null && descricao!.isNotEmpty) {
      data['descricao'] = descricao;
    }

    return data;
  }
}
