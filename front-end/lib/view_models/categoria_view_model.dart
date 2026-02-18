// view_model: ViewModel não precisa mais do map de ícones. Ele só controla a lista de categorias e o estado de carregamento (isLoading).
import 'package:flutter/material.dart';
import '../models/categoria.dart';
import '../services/categoria_service.dart';

class CategoriaViewModel extends ChangeNotifier {
  final CategoriaService _service = CategoriaService();

  // lista de categorias
  List<Categoria> categorias = [];
  bool isLoading = true;

  Future<void> carregar() async {
    isLoading = true;
    notifyListeners();

    categorias = await _service.getAll();

    isLoading = false;
    notifyListeners();
  }
}
