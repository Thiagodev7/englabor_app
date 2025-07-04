// lib/app/app_module.dart

import 'package:englabor_app/app/modules/funcionarios/funcionarios_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

// módulos
import 'modules/auth/auth_module.dart';
import 'modules/home/home_module.dart';
import 'modules/empresas/empresas_module.dart';

// serviços e stores globais
import 'modules/auth/services/auth_service.dart';
import 'modules/auth/stores/auth_store.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton((i) => AuthService()),
    Bind.singleton((i) => AuthStore(i<AuthService>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/',      module: AuthModule()),
    ModuleRoute('/home',  module: HomeModule()),
    ModuleRoute('/empresas', module: EmpresasModule()),
    ModuleRoute('/funcionarios', module: FuncionariosModule()), // ← aqui
  ];
}