import '../models/produto.dart';
import '../services/produto_service.dart';

class ProdutoViewModel {
  final ProdutoService _service = ProdutoService();
  List<Produto> produtos = [];

  Future<void> carregar() async {
    produtos = await _service.getAll();
  }
}
