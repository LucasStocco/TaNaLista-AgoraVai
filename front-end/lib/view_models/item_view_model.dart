import '../models/item.dart';
import '../services/item_service.dart';

class ItemViewModel {
  final ItemService _service = ItemService();

  List<Item> itens = [];
  bool isLoading = false;

  // LISTAR ITENS
  Future<void> carregar(int listaId) async {
    try {
      isLoading = true;
      itens = await _service.listar(listaId);
    } finally {
      isLoading = false;
    }
  }

  // CRIAR ITEM
  Future<void> criar(int listaId, Item item) async {
    final Item? novoItem = await _service.criar(listaId, item);

    // se API não retornar body, usamos o próprio item criado
    if (novoItem != null) {
      itens.add(novoItem);
    } else {
      itens.add(item);
    }
  }

  // ATUALIZAR ITEM
  Future<void> atualizar(int listaId, Item item) async {
    final Item? itemAtualizado = await _service.atualizar(listaId, item);

    final index = itens.indexWhere((i) => i.id == item.id);

    if (index != -1) {
      itens[index] = itemAtualizado ?? item;
    }
  }

  // DELETAR ITEM
  Future<void> deletar(int listaId, int itemId) async {
    await _service.deletar(listaId, itemId);
    itens.removeWhere((i) => i.id == itemId);
  }
}
