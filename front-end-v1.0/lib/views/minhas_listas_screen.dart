import 'package:flutter/material.dart';
import '../view_models/lista_view_model.dart';
import '../models/lista.dart';
import 'criar_nova_lista_screen.dart';
import 'lista_screen.dart';

class MinhasListasScreen extends StatefulWidget {
  const MinhasListasScreen({super.key});

  @override
  State<MinhasListasScreen> createState() => _MinhasListasScreenState();
}

class _MinhasListasScreenState extends State<MinhasListasScreen> {
  final ListaViewModel _viewModel = ListaViewModel();

  @override
  void initState() {
    super.initState();
    _carregarListas();
  }

  Future<void> _carregarListas() async {
    await _viewModel.loadListas();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minhas Listas')),
      body: _viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _viewModel.listas.length,
              itemBuilder: (context, index) {
                final Lista lista = _viewModel.listas[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    title: Text(lista.nome),
                    // ignore: unnecessary_null_comparison
                    subtitle: lista.dataCriacao != null
                        ? Text(
                            'Criada em ${lista.dataCriacao!.day}/${lista.dataCriacao!.month}/${lista.dataCriacao!.year}',
                          )
                        : null,
                    trailing: const Icon(Icons.arrow_forward_ios),

                    // Navegação para tela de itens
                    onTap: () {
                      if (lista.id != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ItensScreen(
                              listaId: lista.id!,
                              listaNome: lista.nome,
                            ),
                          ),
                        );
                      }
                    },

                    // Long press para atualizar ou deletar
                    onLongPress: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (_) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: const Icon(Icons.edit),
                              title: const Text('Atualizar'),
                              onTap: () async {
                                Navigator.pop(context);
                                final Lista? listaAtualizada =
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            CriarNovaListaScreen(lista: lista),
                                      ),
                                    );
                                if (listaAtualizada != null) {
                                  await _viewModel.atualizarLista(
                                    listaAtualizada,
                                  );
                                  setState(() {});
                                }
                              },
                            ),
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
                                      'Deseja realmente deletar esta lista?',
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
                                if (confirm == true && lista.id != null) {
                                  await _viewModel.deletarLista(lista.id!);
                                  setState(() {});
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Lista? novaLista = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CriarNovaListaScreen()),
          );

          if (novaLista != null) {
            await _viewModel.addLista(
              novaLista.nome,
              descricao: novaLista.descricao,
            );
            setState(() {});
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
