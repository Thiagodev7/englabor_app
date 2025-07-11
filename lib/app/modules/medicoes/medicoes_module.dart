// lib/app/modules/medicoes/medicoes_module.dart

import 'package:englabor_app/app/modules/equipamentos/services/equipamentos_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'stores/medicoes_store.dart';
import 'pages/empresa_selection_page.dart';
import 'pages/funcionario_selection_page.dart';
import 'pages/medicao_form_page.dart';
import '../empresas/services/empresas_service.dart';
import '../funcionarios/services/funcionarios_service.dart';
import 'services/medicoes_service.dart';

class MedicoesModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => EmpresasService()),
        Bind.singleton((i) => FuncionariosService()),
        Bind.singleton((i) => EquipamentosService()),
        Bind.singleton((i) => MedicoesService()),
        Bind.singleton((i) => MedicoesStore(
            i<EmpresasService>(),
            i<FuncionariosService>(),
            i<MedicoesService>(),
            i<EquipamentosService>()
          )),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const EmpresaSelectionPage()),
        ChildRoute('/funcionarios', child: (_, __) => const FuncionarioSelectionPage()),
        ChildRoute('/form', child: (_, __) => const MedicaoFormPage()),
      ];
}