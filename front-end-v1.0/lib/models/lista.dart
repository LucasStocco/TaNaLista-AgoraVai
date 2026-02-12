/*
Para o meu amigo programador que estiver lendo isso:
O model de Lista é responsável por:
- Representar o JSON do backend
- Converter JSON -> Dart e Dart -> JSON
- Trabalhar com entidades parcialmente preenchidas, deixando o backend gerar id e data automaticamente
*/

class Lista {
  final int? id;
  final String nome;
  final String? descricao; // campo opcional
  final DateTime dataCriacao;

  Lista({this.id, required this.nome, this.descricao, DateTime? dataCriacao})
    : dataCriacao =
          dataCriacao ?? DateTime.now(); // se não passar, usa a data atual

  // JSON -> Dart
  factory Lista.fromJson(Map<String, dynamic> json) {
    return Lista(
      id: json['id'],
      nome: json['nome'],
      descricao: json['descricao'], // opcional
      dataCriacao: json['dataCriacao'] != null
          ? DateTime.parse(json['dataCriacao'])
          : DateTime.now(),
    );
  }

  // Dart -> JSON
  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      if (descricao != null) 'descricao': descricao, // só envia se tiver
      'dataCriacao': dataCriacao
          .toIso8601String(), // envia data atual se quiser
    };
  }
}

/*
Explicação:
- O Flutter trabalha com objetos parcialmente preenchidos.
- O backend garante a integridade dos dados e gera id e data automaticamente.
- 'descricao' é opcional, não quebra nada se estiver vazia.
*/
