// lib/app/modules/medicoes/stores/medicoes_store.dart

import 'dart:convert';
import 'dart:typed_data';
import 'package:englabor_app/app/models/medicao.dart';
import 'package:englabor_app/app/modules/auth/stores/auth_store.dart';
import 'package:englabor_app/app/modules/equipamentos/services/equipamentos_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import '../../empresas/services/empresas_service.dart';
import '../../funcionarios/services/funcionarios_service.dart';
import '../services/medicoes_service.dart';
import '../../../utils/api_exception.dart';
import 'package:signature/signature.dart';

part 'medicoes_store.g.dart';

class MedicoesStore = _MedicoesStore with _$MedicoesStore;

abstract class _MedicoesStore with Store {
  final EmpresasService _empService;
  final FuncionariosService _funcService;
  final MedicoesService _medService;
  final EquipamentosService _equipService;

  _MedicoesStore(
    this._empService,
    this._funcService,
    this._medService,
    this._equipService,
  );

  // --- listas para dropdowns e filtros ---
  @observable
  ObservableList<Map<String, dynamic>> empresas = ObservableList.of([]);
  @observable
  ObservableList<Map<String, dynamic>> funcionarios = ObservableList.of([]);
  @observable
  List<Map<String, dynamic>> equipList = [];

  @observable
  int? selectedEmpresaId;

  @action
  Future<void> loadEmpresas() async {
    loading = true;
    error = null;
    try {
      final list = await _empService.fetchRaw();
      empresas = ObservableList.of(list);
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
    }
  }

  @action
  Future<void> selectEmpresa(int id) async {
    selectedEmpresaId = id;
    loading = true;
    error = null;
    try {
      final list = await _funcService.fetchByEmpresa(id);
      funcionarios = ObservableList.of(list);
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
    }
  }

  // --- estado geral ---
  @observable
  bool loading = false;
  @observable
  String? error;
  @observable
  List<FieldError>? fieldErrors;
  @observable
  Medicao? currentMedicao;

  // --- campos do formulário ---
  @observable
  int? equipamentoId;
  @observable
  DateTime? dataMedicao;
  @observable
  TimeOfDay? horaInicio;
  @observable
  TimeOfDay? horaFim;
  @observable
  TimeOfDay? horaCalibracaoInicio;
  @observable
  TimeOfDay? horaCalibracaoFim;

  @observable
  TextEditingController tempoMostragemCtrl = TextEditingController();
  @observable
  TextEditingController nenQ5Ctrl = TextEditingController();
  @observable
  TextEditingController lavgQ5Ctrl = TextEditingController();
  @observable
  TextEditingController nenQ3Ctrl = TextEditingController();
  @observable
  TextEditingController lavgQ3Ctrl = TextEditingController();
  @observable
  TextEditingController calibInicialCtrl = TextEditingController();
  @observable
  TextEditingController calibFinalCtrl = TextEditingController();
  @observable
  TextEditingController desvioCtrl = TextEditingController();
  @observable
  TextEditingController tempoPausaCtrl = TextEditingController();
  @observable
  TextEditingController jornadaCtrl = TextEditingController();
  @observable
  TextEditingController obsCtrl = TextEditingController();

  @observable
  TimeOfDay? inicioPausa;
  @observable
  TimeOfDay? finalPausa;

  // --- novo campo de foto ---
  @observable
  String? foto; // base64 ou URL

  @observable
  Uint8List? assinaturaBytes;

    
  final SignatureController assinaturaCtrl = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  @action
  Future<void> salvarAssinatura() async {
    if (assinaturaCtrl.isNotEmpty) {
      final img = await assinaturaCtrl.toPngBytes();
      if (img != null) assinaturaBytes = img;
    }
  }

  @action
  void setFoto(String b64) => foto = b64;

  // --- carregamento de equipamentos ---
  @action
  Future<void> loadEquipamentos() async {
    loading = true;
    error = null;
    try {
      final list = await _equipService.list();
      equipList = list;
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
    }
  }

  // --- inicializa a edição/criação de medição para um funcionário ---
  @action
  Future<void> initMedicao(int funcId) async {
    loading = true;
    error = null;
    try {
      final meds = await _medService.listByFuncionario(funcId);
      if (meds.isNotEmpty) {
        currentMedicao = Medicao.fromJson(meds.first);
        // popula campos
        equipamentoId = currentMedicao!.equipamentoId;
        dataMedicao = currentMedicao!.dataMedicao;
        horaInicio = _parseTime(currentMedicao!.horaInicio);
        horaFim = _parseTime(currentMedicao!.horaFim);
        horaCalibracaoInicio = _parseTime(currentMedicao!.horaCalibracaoInicio);
        horaCalibracaoFim = _parseTime(currentMedicao!.horaCalibracaoFim);
        tempoMostragemCtrl.text = currentMedicao!.tempoMostragem ?? '';
        nenQ5Ctrl.text = currentMedicao!.nenQ5?.toString() ?? '';
        lavgQ5Ctrl.text = currentMedicao!.lavgQ5?.toString() ?? '';
        nenQ3Ctrl.text = currentMedicao!.nenQ3?.toString() ?? '';
        lavgQ3Ctrl.text = currentMedicao!.lavgQ3?.toString() ?? '';
        calibInicialCtrl.text =
            currentMedicao!.calibracaoInicial?.toString() ?? '';
        calibFinalCtrl.text = currentMedicao!.calibracaoFinal?.toString() ?? '';
        desvioCtrl.text = currentMedicao!.desvio?.toString() ?? '';
        tempoPausaCtrl.text = currentMedicao!.tempoPausa ?? '';
        inicioPausa = _parseTime(currentMedicao!.inicioPausa);
        finalPausa = _parseTime(currentMedicao!.finalPausa);
        jornadaCtrl.text = currentMedicao!.jornadaTrabalho ?? '';
        obsCtrl.text = currentMedicao!.observacao ?? '';
        foto = currentMedicao!.foto_base64;
      } else {
        currentMedicao = null;
      }
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
    }
  }

  TimeOfDay? _parseTime(String? s) {
    if (s == null) return null;
    final parts = s.split(':').map(int.parse).toList();
    return TimeOfDay(hour: parts[0], minute: parts[1]);
  }

  String? _formatTime(TimeOfDay? t) {
    if (t == null) return null;
    final h = t.hour.toString().padLeft(2, '0');
    final m = t.minute.toString().padLeft(2, '0');
    return '$h:$m:00';
  }

  // setters para horários
  @action
  void setHoraInicio(TimeOfDay t) => horaInicio = t;
  @action
  void setHoraFim(TimeOfDay t) => horaFim = t;
  @action
  void setInicioPausa(TimeOfDay t) => inicioPausa = t;
  @action
  void setFinalPausa(TimeOfDay t) => finalPausa = t;
  @action
  void setHoraCalibracaoInicio(TimeOfDay t) => horaCalibracaoInicio = t;
  @action
  void setHoraCalibracaoFim(TimeOfDay t) => horaCalibracaoFim = t;

  // cálculo de pausa e mostragem (idem ao anterior)
  void _updateTempoPausa() {/* ... */}
  void _updateTempoMostragem() {/* ... */}

  // --- submete criação/atualização ---
  @action
  Future<void> submit(int funcId, String status) async {
    loading = true;
    error = null;
    fieldErrors = null;

    final dto = Medicao(
      id: currentMedicao?.id,
      funcionarioId: funcId,
      equipamentoId: equipamentoId,
      avaliadorId: Modular.get<AuthStore>().user!.id,
      status: status,
      dataMedicao: dataMedicao,
      horaInicio: _formatTime(horaInicio),
      horaFim: _formatTime(horaFim),
      tempoMostragem: tempoMostragemCtrl.text,
      tempoPausa: tempoPausaCtrl.text,
      jornadaTrabalho: jornadaCtrl.text.isNotEmpty ? jornadaCtrl.text : null,
      nenQ5: nenQ5Ctrl.text.isNotEmpty ? double.parse(nenQ5Ctrl.text) : null,
      lavgQ5: lavgQ5Ctrl.text.isNotEmpty ? double.parse(lavgQ5Ctrl.text) : null,
      nenQ3: nenQ3Ctrl.text.isNotEmpty ? double.parse(nenQ3Ctrl.text) : null,
      lavgQ3: lavgQ3Ctrl.text.isNotEmpty ? double.parse(lavgQ3Ctrl.text) : null,
      calibracaoInicial: calibInicialCtrl.text.isNotEmpty
          ? double.parse(calibInicialCtrl.text)
          : null,
      calibracaoFinal: calibFinalCtrl.text.isNotEmpty
          ? double.parse(calibFinalCtrl.text)
          : null,
      horaCalibracaoInicio: _formatTime(horaCalibracaoInicio),
      horaCalibracaoFim: _formatTime(horaCalibracaoFim),
      desvio: desvioCtrl.text.isNotEmpty ? double.parse(desvioCtrl.text) : null,
      inicioPausa: _formatTime(inicioPausa),
      finalPausa: _formatTime(finalPausa),
      observacao: obsCtrl.text.isNotEmpty ? obsCtrl.text : null,
      foto_base64: foto,
      assinaturaBase64: assinaturaBytes != null
      ? base64Encode(assinaturaBytes!)
      : null,
    ).toJson();

    try {
      if (currentMedicao == null) {
        await _medService.create(dto);
      } else {
        await _medService.update(currentMedicao!.id!, dto);
      }
      // após sucesso, recarrega lista de funcionários da empresa atual
      if (selectedEmpresaId != null) {
        await selectEmpresa(selectedEmpresaId!);
      }
    } on ApiException catch (e) {
      error = e.message;
      fieldErrors = e.errors;
    } catch (_) {
      error = 'Erro inesperado. Tente novamente.';
    } finally {
      loading = false;
    }
  }

@action
void resetForm() {
  // 1) Dispose dos controllers que *podem* ser reatribuídos
  for (final ctrl in [
    tempoMostragemCtrl,
    nenQ5Ctrl,
    lavgQ5Ctrl,
    nenQ3Ctrl,
    lavgQ3Ctrl,
    calibInicialCtrl,
    calibFinalCtrl,
    desvioCtrl,
    tempoPausaCtrl,
    jornadaCtrl,
    obsCtrl,
  ]) {
    ctrl.dispose();
  }

  // 2) Recriação desses mesmos controllers
  tempoMostragemCtrl = TextEditingController();
  nenQ5Ctrl          = TextEditingController();
  lavgQ5Ctrl         = TextEditingController();
  nenQ3Ctrl          = TextEditingController();
  lavgQ3Ctrl         = TextEditingController();
  calibInicialCtrl   = TextEditingController();
  calibFinalCtrl     = TextEditingController();
  desvioCtrl         = TextEditingController();
  tempoPausaCtrl     = TextEditingController();
  jornadaCtrl        = TextEditingController();
  obsCtrl            = TextEditingController();

  //3) Limpeza especial do assinaturaCtrl, que é final
  assinaturaCtrl.clear();
  assinaturaBytes = null;

  // 4) Zerar variáveis de estado
  equipamentoId           = null;
  dataMedicao             = null;
  horaInicio              = null;
  horaFim                 = null;
  inicioPausa             = null;
  finalPausa              = null;
  horaCalibracaoInicio    = null;
  horaCalibracaoFim       = null;
  foto                    = null;
  currentMedicao          = null;
  fieldErrors             = null;
  error                   = null;
}

  void disposeForm() {
    tempoMostragemCtrl.dispose();
    nenQ5Ctrl.dispose();
    lavgQ5Ctrl.dispose();
    nenQ3Ctrl.dispose();
    lavgQ3Ctrl.dispose();
    calibInicialCtrl.dispose();
    calibFinalCtrl.dispose();
    desvioCtrl.dispose();
    tempoPausaCtrl.dispose();
    jornadaCtrl.dispose();
    obsCtrl.dispose();
  }
}
