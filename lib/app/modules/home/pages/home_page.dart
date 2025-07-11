import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../theme/app_theme.dart';
import '../../auth/stores/auth_store.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void _logout(BuildContext context) {
    final store = Modular.get<AuthStore>();
    // limpa dados em memória
    store.user = null;
    store.token = null;
    Modular.to.pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    final AuthStore store = Modular.get();
    final user = store.user!; // assumindo que já está logado

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: AppTheme.primary,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: AppTheme.primary),
              accountName: Text(user.nome, style: const TextStyle(fontSize: 18)),
              accountEmail: Text(user.email),
              currentAccountPicture: CircleAvatar(
                backgroundColor: AppTheme.accent,
                child: Text(
                  user.nome.substring(0,1).toUpperCase(),
                  style: const TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.business),
              title: const Text('Empresas'),
              onTap: () {
                Modular.to.pushNamed('/empresas');
              },
            ),
            ListTile(
              leading: const Icon(Icons.precision_manufacturing),
              title: const Text('Equipamentos'),
              onTap: () {
                Modular.to.pushNamed('/equipamentos');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () => _logout(context),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _FeatureCard(
              icon: Icons.business,
              label: 'Empresas',
              onTap: () => Modular.to.pushNamed('/empresas'),
            ),
            _FeatureCard(
              icon: Icons.precision_manufacturing,
              label: 'Equipamentos',
              onTap: () =>  Modular.to.pushNamed('/equipamentos'),
            ),
            _FeatureCard(
              icon: Icons.timeline,
              label: 'Medições',
              onTap: () => Modular.to.pushNamed('/medicoes'),
            ),
            
          ],
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _FeatureCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 48, color: AppTheme.primary),
              const SizedBox(height: 12),
              Text(
                label,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}