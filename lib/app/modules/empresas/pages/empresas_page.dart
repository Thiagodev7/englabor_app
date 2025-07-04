// lib/app/modules/empresas/pages/empresas_page.dart

import 'package:englabor_app/app/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../theme/app_theme.dart';
import '../stores/empresas_store.dart';

class EmpresasPage extends StatefulWidget {
  const EmpresasPage({Key? key}) : super(key: key);

  @override
  State<EmpresasPage> createState() => _EmpresasPageState();
}

class _EmpresasPageState extends State<EmpresasPage> {
  final store = Modular.get<EmpresasStore>();

  @override
  void initState() {
    super.initState();
    store.loadAll();
  }

  void _showAddDialog() {
    final _formKey = GlobalKey<FormState>();

    // Máscara para CNPJ: 00.000.000/0000-00
    final cnpjMask = MaskTextInputFormatter(
      mask: '##.###.###/####-##',
      filter: {"#": RegExp(r'\d')},
    );

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Nova Empresa'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Nome
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nome'),
                onChanged: (v) => store.newNome = v,
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Nome obrigatório' : null,
              ),
              const SizedBox(height: 8),
              // CNPJ
              TextFormField(
                decoration: const InputDecoration(labelText: 'CNPJ'),
                keyboardType: TextInputType.number,
                inputFormatters: [cnpjMask],
                onChanged: (v) => store.newCnpj = v,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'CNPJ obrigatório';
                  if (!isValidCNPJ(v)) return 'CNPJ inválido';
                  return null;
                },
              ),
              if (store.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    store.errorMessage!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                      fontSize: 14,
                    ),
                  ),
                ),
            ],
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
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary,
            ),
            onPressed: () async {
              // só salva se o form passar
              if (_formKey.currentState!.validate()) {
                await store.addCompany();
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
        title: const Text('Empresas'),
        backgroundColor: AppTheme.primary,
      ),
      body: Observer(
        builder: (_) {
          if (store.loading) {
            // loading global
            return const Center(child: CircularProgressIndicator());
          }
          if (store.errorMessage != null && store.companies.isEmpty) {
            // erro ao carregar listagem
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  store.errorMessage!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          if (store.companies.isEmpty) {
            // lista vazia
            return Center(
              child: Text(
                'Nenhuma empresa encontrada.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          }
          // lista de empresas
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: store.companies.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (_, i) {
              final c = store.companies[i];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 3,
                child: ListTile(
                  onTap: () => Modular.to.pushNamed('/funcionarios/${c.id}'),
                  title: Text(c.nome),
                  subtitle: Text(c.cnpj),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text('Confirmar exclusão'),
                          content: Text(
                            'Você tem certeza que deseja excluir a empresa "${c.nome}"?\n\n'
                            'Isso também removerá todos os funcionários vinculados a ela.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text('Cancelar'),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primary,
                              ),
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text('Excluir'),
                            ),
                          ],
                        ),
                      );

                      if (confirm == true) {
                        await store.deleteCompany(c.id);
                        // Opcional: exibir um SnackBar de confirmação
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Empresa "${c.nome}" excluída.')),
                        );
                      }
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primary,
        onPressed: _showAddDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
