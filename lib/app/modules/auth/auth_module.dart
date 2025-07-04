import 'package:flutter_modular/flutter_modular.dart';
import 'pages/login_page.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => const LoginPage()),
    ChildRoute('/login', child: (_, __) => const LoginPage()),
  ];
}
