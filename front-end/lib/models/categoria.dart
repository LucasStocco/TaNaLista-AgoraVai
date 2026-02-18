// A model de Categoria é pura, guarda apenas os dados. Nada de icones ou estados
class Categoria {
  final int id;
  final String nome;
  final String? descricao; // opcional

  Categoria({required this.id, required this.nome, this.descricao});

  // Se você estiver pegando dados de um JSON:
  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      id: json['id'],
      nome: json['nome'],
      descricao: json['descricao'],
    );
  }

  toJson() {}
}
