import '../models/categoria.dart';
import '../services/categoria_service.dart';

class CategoriaViewModel {
  final CategoriaService _service = CategoriaService();
  List<Categoria> categorias = [];

  Future<void> carregar() async {
    categorias = await _service.getAll();
  }
}
