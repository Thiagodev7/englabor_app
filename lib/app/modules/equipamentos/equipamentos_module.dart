import 'package:englabor_app/app/modules/equipamentos/pages/equipamentos_page.dart';
import 'package:englabor_app/app/modules/equipamentos/services/equipamentos_service.dart';
import 'package:englabor_app/app/modules/equipamentos/stores/equipamentos_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EquipamentosModule extends Module {
  @override
  List<Bind> get binds => [
    Bind.singleton((i) => EquipamentosService()),
    Bind.singleton((i) => EquipamentosStore(i<EquipamentosService>())),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute(
      '/',
      child: (_, __) => const EquipamentosPage(),
    ),
  ];
}