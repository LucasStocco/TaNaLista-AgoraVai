import 'package:flutter/material.dart';
import '../models/item.dart';
import '../view_models/item_view_model.dart';
import '../views/cadastro_item_screen.dart';

class ItensScreen extends StatefulWidget {
  final int listaId;
  final String listaNome;

  const ItensScreen({
    super.key,
    required this.listaId,
    required this.listaNome,
  });

  @override
  State<ItensScreen> createState() => _ItensScreenState();
}

class _ItensScreenState extends State<ItensScreen> {
  final ItemViewModel _viewModel = ItemViewModel();

  @override
  void initState() {
    super.initState();
    _carregarItens();
  }

  Future<void> _carregarItens() async {
    await _viewModel.carregar(widget.listaId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Itens: ${widget.listaNome}')),
      body: _viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _viewModel.itens.length,
              itemBuilder: (context, index) {
                final Item item = _viewModel.itens[index];

                return ListTile(
                  title: Text(item.nome),
                  subtitle: Text(
                    'Qtd: ${item.quantidade} | Preço: ${item.preco.toStringAsFixed(2)}',
                  ),
                  trailing: const Icon(Icons.more_vert),
                  onLongPress: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // 🔁 ATUALIZAR ITEM
                          ListTile(
                            leading: const Icon(Icons.edit),
                            title: const Text('Atualizar'),
                            onTap: () async {
                              Navigator.pop(context);
                              final Item? itemAtualizado = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CriarItemScreen(
                                    item: item,
                                    listaId: widget.listaId,
                                  ),
                                ),
                              );

                              if (itemAtualizado != null) {
                                await _viewModel.atualizar(
                                  widget.listaId,
                                  itemAtualizado,
                                );
                                setState(() {});
                              }
                            },
                          ),

                          // 🗑️ DELETAR ITEM
                          ListTile(
                            leading: const Icon(Icons.delete),
                            title: const Text('Deletar'),
                            onTap: () async {
                              Navigator.pop(context);

                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text('Confirmação'),
                                  content: const Text(
                                    'Deseja realmente deletar este item?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, false),
                                      child: const Text('Não'),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, true),
                                      child: const Text('Sim'),
                                    ),
                                  ],
                                ),
                              );

                              if (confirm == true && item.id != null) {
                                await _viewModel.deletar(
                                  widget.listaId,
                                  item.id!,
                                );
                                setState(() {});
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),

      // ➕ ADICIONAR ITEM
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Item? novoItem = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CriarItemScreen(listaId: widget.listaId),
            ),
          );

          if (novoItem != null) {
            await _viewModel.criar(widget.listaId, novoItem);
            setState(() {});
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
