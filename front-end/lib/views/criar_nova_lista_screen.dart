import 'package:flutter/material.dart';
import '../models/lista.dart';
import '../services/lista_service.dart';

class CriarNovaListaScreen extends StatefulWidget {
  final Lista? lista; // parâmetro opcional para edição

  const CriarNovaListaScreen({super.key, this.lista});

  @override
  State<CriarNovaListaScreen> createState() => _CriarNovaListaScreenState();
}

class _CriarNovaListaScreenState extends State<CriarNovaListaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();

  final ListaService _service = ListaService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Se for edição, preenche os campos
    if (widget.lista != null) {
      _nomeController.text = widget.lista!.nome;
      _descricaoController.text = widget.lista!.descricao ?? '';
    }
  }

  void _salvarLista() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final lista = Lista(
        id: widget.lista?.id, // mantém o id se for edição
        nome: _nomeController.text,
        descricao: _descricaoController.text.isNotEmpty
            ? _descricaoController.text
            : null,
        dataCriacao: widget.lista?.dataCriacao ?? DateTime.now(),
      );

      Lista listaRetornada;

      if (widget.lista == null) {
        // criando nova lista
        listaRetornada = await _service.create(lista);
      } else {
        // atualizando lista existente
        listaRetornada = await _service.update(lista);
      }

      Navigator.pop(
        context,
        listaRetornada,
      ); // retorna a lista criada/atualizada
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao salvar lista: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lista == null ? 'Nova Lista' : 'Editar Lista'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome da Lista'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O nome é obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descricaoController,
                decoration: const InputDecoration(
                  labelText: 'Descrição (opcional)',
                ),
              ),
              const SizedBox(height: 32),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _salvarLista,
                      child: Text(widget.lista == null ? 'Criar' : 'Atualizar'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
