import 'package:flutter/material.dart';
import '../models/item.dart';
import '../services/item_service.dart';
import '../my_widgets/categoria_dropdown.dart';
import '../view_models/categoria_view_model.dart';
import '../models/categoria.dart';

class CriarItemScreen extends StatefulWidget {
  final Item? item;
  final int listaId;

  const CriarItemScreen({super.key, this.item, required this.listaId});

  @override
  State<CriarItemScreen> createState() => _CriarItemScreenState();
}

class _CriarItemScreenState extends State<CriarItemScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _quantidadeController = TextEditingController();
  final _precoController = TextEditingController();

  final ItemService _service = ItemService();
  late CategoriaViewModel _categoriaViewModel;

  Categoria? _categoriaSelecionada;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _categoriaViewModel = CategoriaViewModel();
    _carregarCategorias();

    if (widget.item != null) {
      _nomeController.text = widget.item!.nome;
      _descricaoController.text = widget.item!.descricao ?? '';
      _quantidadeController.text = widget.item!.quantidade.toString();
      _precoController.text = widget.item!.preco.toStringAsFixed(2);
      _categoriaSelecionada = widget.item!.categoria;
    }
  }

  Future<void> _carregarCategorias() async {
    await _categoriaViewModel.carregarCategorias();
    if (mounted) setState(() {});
  }

  Future<void> _salvarItem() async {
    if (!_formKey.currentState!.validate()) return;

    if (_categoriaSelecionada == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecione uma categoria')),
      );
      return;
    }

    setState(() => _isLoading = true);

    final item = Item(
      id: widget.item?.id,
      nome: _nomeController.text,
      descricao:
          _descricaoController.text.isEmpty ? null : _descricaoController.text,
      quantidade: int.parse(_quantidadeController.text),
      preco: double.parse(_precoController.text),
      categoria: _categoriaSelecionada!,
    );

    try {
      Item? resultado;

      if (widget.item == null) {
        resultado = await _service.criar(widget.listaId, item);
      } else {
        resultado = await _service.atualizar(widget.listaId, item);
      }

      if (!mounted) return;

      Navigator.pop(context, resultado ?? item);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar item: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _descricaoController.dispose();
    _quantidadeController.dispose();
    _precoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item == null ? 'Novo Item' : 'Editar Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome do item'),
                validator: (v) => v == null || v.isEmpty ? 'Obrigatório' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descricaoController,
                decoration: const InputDecoration(
                  labelText: 'Descrição (opcional)',
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _quantidadeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Quantidade'),
                validator: (v) => v == null || v.isEmpty ? 'Obrigatório' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _precoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Preço'),
                validator: (v) => v == null || v.isEmpty ? 'Obrigatório' : null,
              ),
              const SizedBox(height: 16),
              _categoriaViewModel.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CategoriaDropdown(
                      viewModel: _categoriaViewModel,
                      selecionada: _categoriaSelecionada,
                      onChanged: (value) {
                        setState(() {
                          _categoriaSelecionada = value;
                        });
                      },
                    ),
              const SizedBox(height: 24),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _salvarItem,
                      child: Text(
                        widget.item == null ? 'Adicionar' : 'Atualizar',
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
