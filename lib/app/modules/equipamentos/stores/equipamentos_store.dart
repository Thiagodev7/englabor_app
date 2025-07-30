// lib/app/modules/equipamentos/stores/equipamentos_store.dart

import 'dart:typed_data';
import 'package:mobx/mobx.dart';
import '../services/equipamentos_service.dart';

part 'equipamentos_store.g.dart';

class EquipamentosStore = _EquipamentosStore with _$EquipamentosStore;

abstract class _EquipamentosStore with Store {
  final EquipamentosService _service;
  _EquipamentosStore(this._service);

  @observable
  ObservableList<Map<String, dynamic>> items = ObservableList.of([]);

  @observable
  bool loading = false;

  @observable
  String? error;

  // campos do formulário
  @observable
  String tipo = '';

  @observable
  String marca = '';

  @observable
  String modelo = '';

  @observable
  String numeroSerie = '';

  @observable
  DateTime? dataUltimaCalibracao;

  @observable
  String numeroCertificado = '';

  @observable
  DateTime? dataVencimento;

  @observable
  int? editingId;

  @observable
  String? formError;

  // resumo de importação
  @observable
  int importedCount = 0;

  @observable
  int updatedCount = 0;

  @observable
  ObservableList<Map<String, dynamic>> importErrors = ObservableList.of([]);

  @action
  Future<void> loadAll() async {
    loading = true;
    error = null;
    try {
      final list = await _service.list();
      items = ObservableList.of(list);
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
    }
  }

  @action
  void setEditing(Map<String, dynamic>? eq) {
    if (eq == null) {
      tipo = '';
      marca = '';
      modelo = '';
      numeroSerie = '';
      dataUltimaCalibracao = null;
      numeroCertificado = '';
      dataVencimento = null;
      editingId = null;
    } else {
      tipo = eq['tipo'] as String? ?? '';
      marca = eq['marca'] as String? ?? '';
      modelo = eq['modelo'] as String? ?? '';
      numeroSerie = eq['numero_serie'] as String? ?? '';
      dataUltimaCalibracao = DateTime.tryParse(eq['data_ultima_calibracao'] as String) ?? DateTime.now();
      numeroCertificado = eq['numero_certificado'] as String? ?? '';
      dataVencimento = DateTime.tryParse(eq['data_vencimento'] as String) ?? DateTime.now();
      editingId = eq['id'] as int?;
    }
    formError = null;
  }

  @action
  Future<void> save() async {
    loading = true;
    formError = null;
    try {
      if (tipo.isEmpty || marca.isEmpty || modelo.isEmpty) {
        throw Exception('Tipo, marca e modelo são obrigatórios.');
      }
      final dto = {
        'tipo': tipo,
        'marca': marca,
        'modelo': modelo,
        'numero_serie': numeroSerie,
        'data_ultima_calibracao': dataUltimaCalibracao?.toIso8601String(),
        'numero_certificado': numeroCertificado,
        'data_vencimento': dataVencimento?.toIso8601String(),
      };
      if (editingId != null) {
        await _service.update(editingId!, dto);
      } else {
        await _service.create(dto);
      }
      await loadAll();
    } catch (e) {
      formError = e.toString().replaceFirst('Exception: ', '');
    } finally {
      loading = false;
    }
  }

  @action
  Future<void> deleteItem(int id) async {
    await _service.delete(id);
    await loadAll();
  }

  @action
  Future<void> importFile(Uint8List bytes, String filename) async {
    loading = true;
    error = null;
    try {
      final summary = await _service.importFromExcel(bytes, filename);
      importedCount = summary['inserted'] as int;
      updatedCount = summary['updated'] as int;
      importErrors = ObservableList.of(
        List<Map<String, dynamic>>.from(summary['errors'] as List),
      );
      await loadAll();
    } catch (e) {
      error = e.toString().replaceFirst('Exception: ', '');
    } finally {
      loading = false;
    }
  }
}