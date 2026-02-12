import 'package:flutter/material.dart';
import '../models/item.dart';
import '../services/item_service.dart';

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
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    if (widget.item != null) {
      _nomeController.text = widget.item!.nome;
      _descricaoController.text = widget.item!.descricao ?? '';
      _quantidadeController.text = widget.item!.quantidade.toString();
      _precoController.text = widget.item!.preco.toStringAsFixed(2);
    }
  }

  Future<void> _salvarItem() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final item = Item(
      id: widget.item?.id,
      nome: _nomeController.text,
      descricao: _descricaoController.text.isEmpty
          ? null
          : _descricaoController.text,
      quantidade: int.parse(_quantidadeController.text),
      preco: double.parse(_precoController.text),
    );

    try {
      final resultado = widget.item == null
          ? await _service.criar(widget.listaId, item)
          : await _service.atualizar(widget.listaId, item);

      Navigator.pop(context, resultado);
    } finally {
      setState(() => _isLoading = false);
    }
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
              TextFormField(
                controller: _descricaoController,
                decoration: const InputDecoration(
                  labelText: 'Descrição (opcional)',
                ),
              ),
              TextFormField(
                controller: _quantidadeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Quantidade'),
                validator: (v) => v == null || v.isEmpty ? 'Obrigatório' : null,
              ),
              TextFormField(
                controller: _precoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Preço'),
                validator: (v) => v == null || v.isEmpty ? 'Obrigatório' : null,
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
