// lib/app/modules/medicoes/pages/empresa_selection_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../theme/app_theme.dart';
import '../stores/medicoes_store.dart';

class EmpresaSelectionPage extends StatefulWidget {
  const EmpresaSelectionPage({Key? key}) : super(key: key);
  @override
  _EmpresaSelectionPageState createState() => _EmpresaSelectionPageState();
}

class _EmpresaSelectionPageState extends State<EmpresaSelectionPage> {
  final store = Modular.get<MedicoesStore>();

  @override
  void initState() {
    super.initState();
    store.loadEmpresas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecione a Empresa'),
        backgroundColor: AppTheme.primary,
      ),
      body: Observer(
        builder: (_) {
          if (store.loading) return const Center(child: CircularProgressIndicator());
          if (store.error != null)
            return Center(child: Text(store.error!, style: TextStyle(color: Theme.of(context).colorScheme.error)));
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: store.empresas.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (_, i) {
              final emp = store.empresas[i];
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 2,
                child: ListTile(
                  title: Text(emp['nome']),
                  subtitle: Text(emp['cnpj']),
                  onTap: () async {
                    await store.selectEmpresa(emp['id'] as int);
                    Modular.to.pushNamed('./funcionarios');
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}