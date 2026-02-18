import '../models/categoria.dart';

// Categoria Service é responsável por buscar os dados da API/BANCO sem se preucupar com UI.

class CategoriaService {
  Future<List<Categoria>> getAll() async {
    // Simulação de fetch
    await Future.delayed(const Duration(seconds: 1));

    return [
      Categoria(id: 1, nome: 'Bebidas'),
      Categoria(id: 2, nome: 'Carnes'),
      Categoria(id: 3, nome: 'Padaria'),
      Categoria(id: 4, nome: 'Hortifrut'),
      Categoria(id: 5, nome: 'Laticínios'),
      Categoria(id: 6, nome: 'Mercearia'),
      Categoria(id: 7, nome: 'Higiene'),
      Categoria(id: 8, nome: 'Limpeza'),
      Categoria(id: 9, nome: 'Pets'),
      Categoria(id: 10, nome: 'Sazonais'),
      Categoria(id: 11, nome: 'Bebes'),
      Categoria(id: 12, nome: 'Outros'),
    ];
  }
}
