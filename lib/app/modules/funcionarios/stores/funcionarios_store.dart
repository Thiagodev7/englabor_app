import 'dart:typed_data';

import 'package:mobx/mobx.dart';
import '../services/funcionarios_service.dart';
import '../../../models/funcionario.dart';

part 'funcionarios_store.g.dart';

class FuncionariosStore = _FuncionariosStoreBase with _$FuncionariosStore;

abstract class _FuncionariosStoreBase with Store {
  final FuncionariosService _service;
  _FuncionariosStoreBase(this._service);

  @observable
  ObservableList<Funcionario> funcionarios = ObservableList();

  @observable
  bool loading = false;

  @observable
  String? errorMessage;

  @observable
  String searchQuery = '';

  // campos de formulário
  @observable String newNome      = '';
  @observable String newMatricula = '';
  @observable String newSetor     = '';
  @observable String newGhe       = '';
  @observable String newCargo     = '';

  // Adicione no store:
@observable
int importedCount = 0;

@observable
int updatedCount = 0;

@observable
ObservableList<Map<String, dynamic>> importErrors = ObservableList();

@action
Future<void> importFile(int widgetEmpresaId,Uint8List bytes, String filename) async {
  loading = true;
  errorMessage = null;
  try {
    final summary = await _service.importByEmpresa(widgetEmpresaId, bytes, filename);
    importedCount = summary['inserted'] as int;
    updatedCount  = summary['updated']  as int;
    importErrors = ObservableList.of(
  List<Map<String, dynamic>>.from(summary['errors'] as List)
);
    await loadByEmpresa(widgetEmpresaId);
  } catch (e) {
    errorMessage = e.toString().replaceFirst('Exception: ', '');
  } finally {
    loading = false;
  }
}

  @action
  Future<void> loadByEmpresa(int empresaId) async {
    loading = true;
    errorMessage = null;
    try {
      final raw = await _service.fetchByEmpresa(empresaId);
      funcionarios = ObservableList.of(raw.map((j) => Funcionario.fromJson(j)));
    } catch (e) {
      errorMessage = e.toString().replaceFirst('Exception: ', '');
    } finally {
      loading = false;
    }
  }

  @action
  void setSearch(String q) => searchQuery = q;

  @computed
  List<Funcionario> get filtered {
    if (searchQuery.isEmpty) return funcionarios;
    final q = searchQuery.toLowerCase();
    return funcionarios.where((f) => f.nome.toLowerCase().contains(q)).toList();
  }

  @action
  Future<void> addFuncionario(int empresaId) async {
    if (newNome.isEmpty) { errorMessage = 'Nome obrigatório'; return; }
    loading = true;
    try {
      final created = await _service.createRaw(empresaId, newNome, newMatricula, newSetor, newGhe, newCargo);
      funcionarios.add(Funcionario.fromJson(created));
      newNome = newMatricula = newSetor = newGhe = newCargo = '';
    } catch (e) {
      errorMessage = e.toString().replaceFirst('Exception: ', '');
    } finally {
      loading = false;
    }
  }

  @action
  Future<void> deleteFuncionario(int id) async {
    loading = true;
    try {
      await _service.deleteRaw(id);
      funcionarios.removeWhere((f) => f.id == id);
    } catch (e) {
      errorMessage = e.toString().replaceFirst('Exception: ', '');
    } finally {
      loading = false;
    }
  }

  @action
  Future<void> updateFuncionario(int id, int empresaId) async {
    loading = true;
    try {
      final updated = await _service.updateRaw(id, empresaId, newNome, newMatricula, newSetor, newGhe, newCargo);
      final index = funcionarios.indexWhere((f) => f.id == id);
      funcionarios[index] = Funcionario.fromJson(updated);
      newNome = newMatricula = newSetor = newGhe = newCargo = '';
    } catch (e) {
      errorMessage = e.toString().replaceFirst('Exception: ', '');
    } finally {
      loading = false;
    }
  }
}
