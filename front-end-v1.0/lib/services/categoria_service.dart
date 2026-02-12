import '../models/categoria.dart';

class CategoriaService {
  Future<List<Categoria>> getAll() async {
    return [
      Categoria(id: 1, nome: 'Alimentos'),
      Categoria(id: 2, nome: 'Higiene'),
    ];
  }
}
