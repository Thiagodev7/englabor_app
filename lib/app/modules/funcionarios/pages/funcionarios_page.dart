// lib/app/modules/funcionarios/pages/funcionarios_page.dart

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
  late final FuncionariosStore store = Modular.get<FuncionariosStore>();
  bool isEditing = false;
  int? editingId;

  @override
  void initState() {
    super.initState();
    store.loadByEmpresa(widget.empresaId);
  }

  void _showForm({Funcionario? f}) {
    final _formKey = GlobalKey<FormState>();

    // Preenche campos se for edição
    if (f != null) {
      store.newNome = f.nome;
      store.newMatricula = f.matricula;
      store.newSetor = f.setor;
      store.newGhe = f.ghe;
      store.newCargo = f.cargo;
      isEditing = true;
      editingId = f.id;
    } else {
      // limpa campos
      store.newNome = '';
      store.newMatricula = '';
      store.newSetor = '';
      store.newGhe = '';
      store.newCargo = '';
      isEditing = false;
      editingId = null;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(isEditing ? 'Editar Funcionário' : 'Novo Funcionário'),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Nome
                TextFormField(
                  initialValue: store.newNome,
                  decoration: const InputDecoration(labelText: 'Nome'),
                  onChanged: (v) => store.newNome = v,
                  validator: (v) => (v == null || v.isEmpty) ? 'Nome obrigatório' : null,
                ),
                const SizedBox(height: 8),
                // Matrícula
                TextFormField(
                  initialValue: store.newMatricula,
                  decoration: const InputDecoration(labelText: 'Matrícula'),
                  onChanged: (v) => store.newMatricula = v,
                ),
                const SizedBox(height: 8),
                // Setor
                TextFormField(
                  initialValue: store.newSetor,
                  decoration: const InputDecoration(labelText: 'Setor'),
                  onChanged: (v) => store.newSetor = v,
                ),
                const SizedBox(height: 8),
                // GHE
                TextFormField(
                  initialValue: store.newGhe,
                  decoration: const InputDecoration(labelText: 'GHE'),
                  onChanged: (v) => store.newGhe = v,
                ),
                const SizedBox(height: 8),
                // Cargo
                TextFormField(
                  initialValue: store.newCargo,
                  decoration: const InputDecoration(labelText: 'Cargo'),
                  onChanged: (v) => store.newCargo = v,
                ),
                if (store.errorMessage != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    store.errorMessage!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                      fontSize: 14,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              store.errorMessage = null;
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primary),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                if (isEditing && editingId != null) {
                  await store.updateFuncionario(editingId!, widget.empresaId);
                } else {
                  await store.addFuncionario(widget.empresaId);
                }
                if (store.errorMessage == null) {
                  Navigator.of(context).pop();
                }
              }
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Funcionários'),
        backgroundColor: AppTheme.primary,
      ),
      body: Column(
        children: [
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
                if (store.errorMessage != null) {
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
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      elevation: 3,
                      child: ListTile(
                        title: Text(f.nome),
                        subtitle: Text('${f.cargo} • ${f.matricula}'),
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
