import '../models/lista.dart';
import '../services/lista_service.dart';

class ListaViewModel {
  final ListaService _service = ListaService();

  bool isLoading = false;
  List<Lista> listas = [];

  /// Carrega todas as listas do backend
  Future<void> loadListas() async {
    isLoading = true;
    try {
      listas = await _service.getAll();
    } finally {
      isLoading = false;
    }
  }

  /// Cria uma nova lista e adiciona à lista local
  Future<void> addLista(String nome, {String? descricao}) async {
    isLoading = true;
    try {
      final novaLista = Lista(nome: nome, dataCriacao: DateTime.now());
      final criada = await _service.create(novaLista);
      listas.add(criada);
    } finally {
      isLoading = false;
    }
  }

  /// Atualiza uma lista existente
  Future<void> atualizarLista(Lista listaAtualizada) async {
    isLoading = true;
    try {
      final atualizada = await _service.update(listaAtualizada);
      final index = listas.indexWhere((l) => l.id == atualizada.id);
      if (index != -1) {
        listas[index] = atualizada;
      }
    } finally {
      isLoading = false;
    }
  }

  /// Deleta uma lista pelo id
  Future<void> deletarLista(int id) async {
    isLoading = true;
    try {
      await _service.delete(id);
      listas.removeWhere((l) => l.id == id);
    } finally {
      isLoading = false;
    }
  }
}
