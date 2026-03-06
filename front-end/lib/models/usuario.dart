/*
Para o meu amigo programador que estiver lendo isso:
O model de Usuario é responsável por:
- Representar o JSON do backend
- Converter JSON -> Dart e Dart -> JSON
- Trabalhar com entidades parcialmente preenchidas, deixando o backend gerar id e data automaticamente
*/

class Usuario {
  final int? id;
  final String nome;
  final String email;
  final String senha; 
  final DateTime dataCriacao;

  Usuario({
    this.id,
    required this.nome,
    required this.email,
    required this.senha,
    DateTime? dataCriacao,
  }) : dataCriacao = dataCriacao ?? DateTime.now();

  // JSON -> Dart
  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nome: json['nome'],
      email: json['email'],
      senha: json['senha'], 
      dataCriacao: json['dataCriacao'] != null
          ? DateTime.parse(json['dataCriacao'])
          : DateTime.now(),
    );
  }

  // Dart -> JSON
  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'email': email,
      'senha': senha,
      'dataCriacao': dataCriacao.toIso8601String(),
    };
  }
}

/*
Explicação:
- O Flutter trabalha com objetos parcialmente preenchidos.
- O backend garante a integridade dos dados e gera id e data automaticamente.
- 'telefone' é opcional, então não quebra se estiver ausente.
*/