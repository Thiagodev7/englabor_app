// lib/app/modules/auth/stores/auth_store.dart
import 'dart:convert';
import 'package:mobx/mobx.dart';
import '../../../models/user.dart';
import '../services/auth_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  final AuthService _service;
  _AuthStoreBase(this._service) { _initConnectivity(); }

  // dados do usuário
  @observable
  User? user;

  @observable
  String? token;

  // campos da tela
  @observable
  String identifier = '';

  @observable
  String password = '';

  @observable
  bool loading = false;

  @observable
  String? errorMessage;

  // fila offline
  ObservableList<Map<String, String>> queue = ObservableList();
  final Connectivity _connectivity = Connectivity();

  void _initConnectivity() {
    _connectivity.onConnectivityChanged.listen((status) {
      if (status != ConnectivityResult.none) _flushQueue();
    });
  }

  Future<void> _flushQueue() async {
    for (var creds in List.of(queue)) {
      try {
        await login(creds['identifier']!, creds['password']!);
        queue.remove(creds);
      } catch (_) {}
    }
  }

  @action
  Future<bool> login(String idf, String pwd) async {
    loading = true;
    errorMessage = null;
    try {
      final res = await _service.login(idf, pwd);
      token = res['token'] as String;
      user  = User.fromJson(res['user'] as Map<String, dynamic>);
      loading = false;
      return true;
    } catch (e) {
      loading = false;
      // remove o prefixo 'Exception: ' se existir
      errorMessage = e.toString().replaceFirst('Exception: ', '');

      // se offline, adiciona na fila
      if (await _connectivity.checkConnectivity() == ConnectivityResult.none) {
        queue.add({'identifier': idf, 'password': pwd});
      }
      return false;
    }
  }
}