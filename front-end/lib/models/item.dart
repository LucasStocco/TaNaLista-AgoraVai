class Item {
  final int? id;
  final String nome;
  final String? descricao;
  final int quantidade;
  final double preco;

  Item({
    this.id,
    required this.nome,
    this.descricao,
    required this.quantidade,
    required this.preco,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      nome: json['nome'],
      descricao: json['descricao'],
      quantidade: json['quantidade'],
      preco: (json['preco'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'quantidade': quantidade,
      'preco': preco,
    };
  }
}
