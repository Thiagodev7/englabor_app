// lib/app/modules/empresas/stores/empresas_store.dart
import 'package:mobx/mobx.dart';
import '../services/empresas_service.dart';
import '../../../models/company.dart';

part 'empresas_store.g.dart';

class EmpresasStore = _EmpresasStoreBase with _$EmpresasStore;

abstract class _EmpresasStoreBase with Store {
  final EmpresasService _service;
  _EmpresasStoreBase(this._service);

  @observable
  ObservableList<Company> companies = ObservableList();

  @observable
  bool loading = false;

  @observable
  String? errorMessage;

  @observable
  String newNome = '';

  @observable
  String newCnpj = '';

  @action
  Future<void> loadAll() async {
    loading = true;
    errorMessage = null;
    try {
      final raw = await _service.fetchRaw();
      companies = ObservableList.of(raw.map((j) => Company.fromJson(j)));
    } catch (e) {
      errorMessage = e.toString().replaceFirst('Exception: ', '');
    } finally {
      loading = false;
    }
  }

  @action
  Future<void> addCompany() async {
    if (newNome.isEmpty || newCnpj.isEmpty) {
      errorMessage = 'Nome e CNPJ são obrigatórios.';
      return;
    }
    loading = true;
    try {
      final created = await _service.createRaw(newNome, newCnpj);
      companies.add(Company.fromJson(created));
      newNome = '';
      newCnpj = '';
    } catch (e) {
      errorMessage = e.toString().replaceFirst('Exception: ', '');
    } finally {
      loading = false;
    }
  }

  @action
  Future<void> deleteCompany(int id) async {
    loading = true;
    try {
      await _service.deleteRaw(id);
      companies.removeWhere((c) => c.id == id);
    } catch (e) {
      errorMessage = e.toString().replaceFirst('Exception: ', '');
    } finally {
      loading = false;
    }
  }
}