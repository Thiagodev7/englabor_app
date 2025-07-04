import 'package:flutter_modular/flutter_modular.dart';
import 'stores/funcionarios_store.dart';
import 'services/funcionarios_service.dart';
import 'pages/funcionarios_page.dart';

class FuncionariosModule extends Module {
  @override
  List<Bind> get binds => [
    Bind.singleton((i) => FuncionariosService()),
    Bind.singleton((i) => FuncionariosStore(i<FuncionariosService>())),
  ];

  @override
  List<ModularRoute> get routes => [
    // monta em /funcionarios/:empresaId
    ChildRoute(
      '/:empresaId',
      child: (_, args) {
        final id = int.parse(args.params['empresaId']);
        return FuncionariosPage(empresaId: id);
      },
    ),
  ];
}
