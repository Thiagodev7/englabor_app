// lib/app/modules/medicoes/pages/funcionario_selection_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../theme/app_theme.dart';
import '../stores/medicoes_store.dart';

class FuncionarioSelectionPage extends StatefulWidget {
  const FuncionarioSelectionPage({Key? key}) : super(key: key);
  @override
  _FuncionarioSelectionPageState createState() => _FuncionarioSelectionPageState();
}

class _FuncionarioSelectionPageState extends State<FuncionarioSelectionPage> {
  final store = Modular.get<MedicoesStore>();
  final _searchController = TextEditingController();
  String _search = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() => _search = _searchController.text.trim().toLowerCase());
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  IconData _iconForStatus(String status) {
    if (status == 'ABERTO') return Icons.timelapse;
    if (status == 'CONCLUIDO') return Icons.check_circle;
    return Icons.radio_button_unchecked;
  }

  Color _colorForStatus(String status) {
    if (status == 'ABERTO') return Colors.orange;
    if (status == 'CONCLUIDO') return Colors.green;
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecione o Funcionário'),
        backgroundColor: AppTheme.primary,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar por nome...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
          Expanded(
            child: Observer(builder: (_) {
              if (store.loading) return const Center(child: CircularProgressIndicator());
              if (store.error != null)
                return Center(child: Text(store.error!, style: TextStyle(color: Theme.of(context).colorScheme.error)));
              final list = store.funcionarios.where((f) {
                return (f['nome'] as String).toLowerCase().contains(_search);
              }).toList();
              if (list.isEmpty) {
                return Center(child: Text('Nenhum funcionário encontrado.', style: Theme.of(context).textTheme.bodyMedium));
              }
              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: list.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (_, i) {
                  final f = list[i];
                  final status = f['medicao_status'] as String? ?? 'NENHUMA';
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    elevation: 2,
                    child: ListTile(
                      leading: Icon(_iconForStatus(status), color: _colorForStatus(status)),
                      title: Text(f['nome']),
                      subtitle: Text('Matrícula: ${f['matricula'] ?? '-'}'),
                      onTap: () {
                        Modular.to.pushNamed(
                          '/medicoes/form',
                          arguments: {
                            'empresaId': store.selectedEmpresaId,
                            'funcionarioId': f['id'],
                          },
                        );
                      },
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}