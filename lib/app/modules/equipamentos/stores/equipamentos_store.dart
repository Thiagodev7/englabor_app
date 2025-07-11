import 'package:mobx/mobx.dart';
import '../services/equipamentos_service.dart';
part 'equipamentos_store.g.dart';

class EquipamentosStore = _EquipamentosStore with _$EquipamentosStore;

abstract class _EquipamentosStore with Store {
  final EquipamentosService _service;
  _EquipamentosStore(this._service);

  @observable
  bool loading = false;
  @observable
  String? error;
  @observable
  ObservableList<Map<String, dynamic>> items = ObservableList.of([]);

  // form fields
  @observable String tipo = '';
  @observable String marca = '';
  @observable String modelo = '';
  @observable String numeroSerie = '';
  @observable DateTime? dataUltimaCalibracao;
  @observable String numeroCertificado = '';
  @observable DateTime? dataVencimento;

  @observable int? editingId;
  @observable String? formError;

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
      // novo
      tipo = '';
      marca = '';
      modelo = '';
      numeroSerie = '';
      dataUltimaCalibracao = null;
      numeroCertificado = '';
      dataVencimento = null;
      editingId = null;
    } else {
      // editar
      tipo = eq['tipo'] as String? ?? '';
      marca = eq['marca'] as String? ?? '';
      modelo = eq['modelo'] as String? ?? '';
      numeroSerie = eq['numero_serie'] as String? ?? '';
      dataUltimaCalibracao = DateTime.parse(eq['data_ultima_calibracao'] as String);
      numeroCertificado = eq['numero_certificado'] as String? ?? '';
      dataVencimento = DateTime.parse(eq['data_vencimento'] as String);
      editingId = eq['id'] as int?;
    }
    formError = null;
  }

  @action
  Future<void> save() async {
    loading = true;
    formError = null;
    try {
      // validações básicas
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
}