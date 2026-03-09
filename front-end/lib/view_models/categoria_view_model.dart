import 'package:flutter/material.dart';
import '../models/categoria.dart';
import '../services/categoria_service.dart';

class CategoriaViewModel extends ChangeNotifier {
  List<Categoria> categorias = [];
  bool isLoading = true; // start como true
  final CategoriaService service = CategoriaService();

  Future<void> carregarCategorias() async {
    try {
      isLoading = true;
      notifyListeners();

      categorias = await service.buscarCategorias();
    } catch (e) {
      categorias = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
