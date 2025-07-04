import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../theme/app_theme.dart';
import '../stores/auth_store.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthStore store = Modular.get();

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo
                  Image.asset(
                    'assets/images/logo.png',
                    width: MediaQuery.of(context).size.width * 0.5,
                  ),
                  const SizedBox(height: 32),

                  // Campos e botão
                  Observer(
                    builder: (_) => Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'CPF / E-mail / Telefone',
                            hintStyle: TextStyle(color: Colors.grey[500]),
                          ),
                          onChanged: (v) => store.identifier = v,
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Senha',
                            hintStyle: TextStyle(color: Colors.grey[500]),
                          ),
                          obscureText: true,
                          onChanged: (v) => store.password = v,
                        ),
                        const SizedBox(height: 32),
                        store.loading
                            ? const CircularProgressIndicator(
                                color: AppTheme.primary,
                              )
                            : SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    final ok = await store.login(
                                      store.identifier,
                                      store.password,
                                    );
                                    if (ok) {
                                      Modular.to.pushReplacementNamed('/home');
                                    }
                                  },
                                  child: const Text('Entrar'),
                                ),
                              ),
                        if (store.errorMessage != null) ...[
                          const SizedBox(height: 16),
                          Text(
                            store.errorMessage!,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}