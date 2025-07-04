// lib/app/modules/empresas/empresas_module.dart
import 'package:flutter_modular/flutter_modular.dart';
import 'stores/empresas_store.dart';
import 'services/empresas_service.dart';
import 'pages/empresas_page.dart';

class EmpresasModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => EmpresasService()),
        Bind.singleton((i) => EmpresasStore(i<EmpresasService>())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const EmpresasPage()),
      ];
}