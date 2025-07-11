// lib/app/modules/funcionarios/pages/funcionarios_page.dart

import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../theme/app_theme.dart';
import '../stores/funcionarios_store.dart';
import '../../../models/funcionario.dart';

class FuncionariosPage extends StatefulWidget {
  final int empresaId;
  const FuncionariosPage({Key? key, required this.empresaId}) : super(key: key);

  @override
  State<FuncionariosPage> createState() => _FuncionariosPageState();
}

class _FuncionariosPageState extends State<FuncionariosPage> {
  final _formKey = GlobalKey<FormState>();
  late final FuncionariosStore store = Modular.get<FuncionariosStore>();
  bool _isEditing = false;
  int? _editingId;

  @override
  void initState() {
    super.initState();
    store.loadByEmpresa(widget.empresaId);
  }

  void _showForm({Funcionario? f}) {
    // limpa campos e erros
    store.clearForm();
    _isEditing = false;
    _editingId = null;

    if (f != null) {
      store.newNome = f.nome;
      store.newMatricula = f.matricula ?? '';
      store.newSetor = f.setor ?? '';
      store.newGhe = f.ghe ?? '';
      store.newCargo = f.cargo ?? '';
      _isEditing = true;
      _editingId = f.id;
    }

    showDialog(
      context: context,
      builder: (_) => Observer(builder: (_) {
        return AlertDialog(
          title: Text(_isEditing ? 'Editar Funcionário' : 'Novo Funcionário'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Nome (agora opcional)
                  TextFormField(
                    initialValue: store.newNome,
                    decoration: const InputDecoration(labelText: 'Nome'),
                    onChanged: (v) => store.newNome = v,
                    validator: (_) => null,
                  ),
                  const SizedBox(height: 8),
                  // Matrícula
                  TextFormField(
                    initialValue: store.newMatricula,
                    decoration: const InputDecoration(labelText: 'Matrícula'),
                    onChanged: (v) => store.newMatricula = v,
                    validator: (_) => null,
                  ),
                  const SizedBox(height: 8),
                  // Setor
                  TextFormField(
                    initialValue: store.newSetor,
                    decoration: const InputDecoration(labelText: 'Setor'),
                    onChanged: (v) => store.newSetor = v,
                    validator: (_) => null,
                  ),
                  const SizedBox(height: 8),
                  // GHE
                  TextFormField(
                    initialValue: store.newGhe,
                    decoration: const InputDecoration(labelText: 'GHE'),
                    onChanged: (v) => store.newGhe = v,
                    validator: (_) => null,
                  ),
                  const SizedBox(height: 8),
                  // Cargo
                  TextFormField(
                    initialValue: store.newCargo,
                    decoration: const InputDecoration(labelText: 'Cargo'),
                    onChanged: (v) => store.newCargo = v,
                    validator: (_) => null,
                  ),
                  const SizedBox(height: 12),

                  // mostra erro geral
                  if (store.errorMessage != null) ...[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        store.errorMessage!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],

                  // mostra erros de campo
                  if (store.fieldErrors.isNotEmpty) ...[
                    for (var fe in store.fieldErrors)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          '${fe.field}: ${fe.message}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error.withOpacity(0.8),
                            fontSize: 12,
                          ),
                        ),
                      ),
                    const SizedBox(height: 8),
                  ],
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                store.clearForm();
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primary),
              onPressed: () async {
                // não validamos nada localmente
                await (_isEditing
                    ? store.updateFuncionario(_editingId!, widget.empresaId)
                    : store.addFuncionario(widget.empresaId)
                );
                // só fecha se não houver erro
                if (store.errorMessage == null && store.fieldErrors.isEmpty) {
                  store.clearForm();
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      }),
    );
  }

Future<void> _onImportPressed() async {
  final res = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['csv', 'xlsx'],
  );
  if (res == null) return;

  final picked = res.files.single;
  Uint8List? bytes = picked.bytes;

  // Se bytes vier nulo (até Web/Desktop), tenta ler do path
  if (bytes == null && picked.path != null) {
    final fileOnDisk = File(picked.path!);
    bytes = await fileOnDisk.readAsBytes();
  }

  if (bytes == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Não foi possível ler o arquivo.'))
    );
    return;
  }

  await store.importFile(widget.empresaId, bytes, picked.name);

  final snack = 'Importados: ${store.importedCount}, '
      'Atualizados: ${store.updatedCount}, '
      'Erros: ${store.importErrors.length}';
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(snack)));
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Funcionários'),
        backgroundColor: AppTheme.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.upload_file),
            tooltip: 'Importar Excel',
            onPressed: _onImportPressed,
          ),
        ],
      ),
      body: Column(
        children: [
          // pesquisa por nome
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Pesquisar por nome',
              ),
              onChanged: store.setSearch,
            ),
          ),
          Expanded(
            child: Observer(
              builder: (_) {
                if (store.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (store.errorMessage != null && store.funcionarios.isEmpty) {
                  return Center(
                    child: Text(
                      store.errorMessage!,
                      style: TextStyle(color: Theme.of(context).colorScheme.error),
                    ),
                  );
                }
                final list = store.filtered;
                if (list.isEmpty) {
                  return Center(
                    child: Text(
                      'Nenhum funcionário.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: list.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (_, i) {
                    final f = list[i];
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      elevation: 3,
                      child: ListTile(
                        title: Text(f.nome),
                        subtitle: Text('${f.cargo ?? ''} • ${f.matricula ?? ''}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: AppTheme.accent),
                              onPressed: () => _showForm(f: f),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => store.deleteFuncionario(f.id),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primary,
        onPressed: () => _showForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}