import '../models/item.dart';
import '../services/item_service.dart';

class ItemViewModel {
  final ItemService _service = ItemService();

  List<Item> itens = [];
  bool isLoading = false;

  // 📌 LISTAR ITENS
  Future<void> carregar(int listaId) async {
    isLoading = true;
    itens = await _service.listar(listaId);
    isLoading = false;
  }

  // ➕ CRIAR ITEM
  Future<void> criar(int listaId, Item item) async {
    final novoItem = await _service.criar(listaId, item);
    itens.add(novoItem);
  }

  // ✏️ ATUALIZAR ITEM
  Future<void> atualizar(int listaId, Item item) async {
    final itemAtualizado = await _service.atualizar(listaId, item);

    final index = itens.indexWhere((i) => i.id == itemAtualizado.id);
    if (index != -1) {
      itens[index] = itemAtualizado;
    }
  }

  // 🗑️ DELETAR ITEM
  Future<void> deletar(int listaId, int itemId) async {
    await _service.deletar(listaId, itemId);
    itens.removeWhere((i) => i.id == itemId);
  }
}
