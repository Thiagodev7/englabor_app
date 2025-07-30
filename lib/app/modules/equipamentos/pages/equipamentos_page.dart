// lib/app/modules/equipamentos/pages/equipamentos_page.dart

import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../theme/app_theme.dart';
import '../stores/equipamentos_store.dart';

class EquipamentosPage extends StatefulWidget {
  const EquipamentosPage({Key? key}) : super(key: key);

  @override
  _EquipamentosPageState createState() => _EquipamentosPageState();
}

class _EquipamentosPageState extends State<EquipamentosPage> {
  final store = Modular.get<EquipamentosStore>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    store.loadAll();
  }

  Future<void> _onImportPressed() async {
    final res = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );
    if (res == null) return;

    Uint8List? bytes = res.files.single.bytes;
    final name = res.files.single.name;

    if (bytes == null && res.files.single.path != null) {
      bytes = await File(res.files.single.path!).readAsBytes();
    }
    if (bytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível ler o arquivo.')),
      );
      return;
    }

    await store.importFile(bytes, name);

    final snack = 'Importados: ${store.importedCount} • '
        'Atualizados: ${store.updatedCount} • '
        'Erros: ${store.importErrors.length}';
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(snack)));
  }

  Future<void> _showForm([Map<String, dynamic>? eq]) async {
    store.setEditing(eq);
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(eq == null ? 'Novo Equipamento' : 'Editar Equipamento'),
        content: Observer(builder: (_) {
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    initialValue: store.tipo,
                    decoration: const InputDecoration(labelText: 'Tipo'),
                    onChanged: (v) => store.tipo = v,
                    validator: (v) => v!.isEmpty ? 'Obrigatório' : null,
                  ),
                  TextFormField(
                    initialValue: store.marca,
                    decoration: const InputDecoration(labelText: 'Marca'),
                    onChanged: (v) => store.marca = v,
                    validator: (v) => v!.isEmpty ? 'Obrigatório' : null,
                  ),
                  TextFormField(
                    initialValue: store.modelo,
                    decoration: const InputDecoration(labelText: 'Modelo'),
                    onChanged: (v) => store.modelo = v,
                    validator: (v) => v!.isEmpty ? 'Obrigatório' : null,
                  ),
                  TextFormField(
                    initialValue: store.numeroSerie,
                    decoration: const InputDecoration(labelText: 'Nº Série'),
                    onChanged: (v) => store.numeroSerie = v,
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: store.dataUltimaCalibracao ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (d != null) store.dataUltimaCalibracao = d;
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                          labelText: 'Data Última Calibração'),
                      child: Text(store.dataUltimaCalibracao != null
                          ? store.dataUltimaCalibracao!
                              .toLocal()
                              .toString()
                              .split(' ')[0]
                          : 'Selecione'),
                    ),
                  ),
                  TextFormField(
                    initialValue: store.numeroCertificado,
                    decoration:
                        const InputDecoration(labelText: 'Número Certificado'),
                    onChanged: (v) => store.numeroCertificado = v,
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: store.dataVencimento ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (d != null) store.dataVencimento = d;
                    },
                    child: InputDecorator(
                      decoration:
                          const InputDecoration(labelText: 'Data Vencimento'),
                      child: Text(store.dataVencimento != null
                          ? store.dataVencimento!
                              .toLocal()
                              .toString()
                              .split(' ')[0]
                          : 'Selecione'),
                    ),
                  ),
                  if (store.formError != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      store.formError!,
                      style: TextStyle(color: Theme.of(context).colorScheme.error),
                    ),
                  ],
                ],
              ),
            ),
          );
        }),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primary),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                await store.save();
                if (store.formError == null) Navigator.of(context).pop();
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
        title: const Text('Equipamentos'),
        backgroundColor: AppTheme.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.upload_file),
            tooltip: 'Importar Excel',
            onPressed: _onImportPressed,
          ),
        ],
      ),
      body: Observer(builder: (_) {
        if (store.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (store.error != null) {
          return Center(child: Text(store.error!));
        }
        if (store.items.isEmpty) {
          return Center(child: Text('Nenhum equipamento.'));
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: store.items.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (_, i) {
            final eq = store.items[i];
            return Card(
              child: ListTile(
                title: Text(eq['tipo'] as String),
                subtitle: Text('${eq['marca']} • ${eq['modelo']}'),
                onTap: () => _showForm(eq),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => store.deleteItem(eq['id'] as int),
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primary,
        onPressed: () => _showForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}