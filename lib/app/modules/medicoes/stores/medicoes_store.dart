// lib/app/modules/medicoes/stores/medicoes_store.dart

import 'package:englabor_app/app/models/medicao.dart';
import 'package:englabor_app/app/modules/auth/stores/auth_store.dart';
import 'package:englabor_app/app/modules/equipamentos/services/equipamentos_service.dart';
import 'package:englabor_app/app/utils/api_exception.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import '../services/medicoes_service.dart';
import '../../empresas/services/empresas_service.dart';
import '../../funcionarios/services/funcionarios_service.dart';

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

  @observable
  ObservableList<Map<String, dynamic>> empresas = ObservableList.of([]);
  @observable
  ObservableList<Map<String, dynamic>> funcionarios = ObservableList.of([]);
  @observable
  bool loading = false;
  @observable
  String? error;
  @observable
  int? selectedEmpresaId;

  // formulário
  @observable
  Medicao? currentMedicao;
  @observable
  List<Map<String, dynamic>> equipList = [];

  @observable
  int? equipamentoId;
  @observable
  DateTime? dataMedicao;
  @observable
  TimeOfDay? horaInicio;
  @observable
  TimeOfDay? horaFim;
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
  TimeOfDay? inicioPausa;
  @observable
  TimeOfDay? finalPausa;
  @observable
  TextEditingController jornadaCtrl = TextEditingController();
  @observable
  TextEditingController obsCtrl = TextEditingController();

  @observable
  List<FieldError>? fieldErrors;

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

  @action
  Future<void> loadEquipamentos() async {
    loading = true;
    error = null;
    try {
      final list = await _equipService.list(); // ← use a instância injetada
      equipList = ObservableList.of(list);
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
    }
  }

  @action
  Future<void> initMedicao(int funcId) async {
    loading = true;
    error = null;
    try {
      final meds = await _medService.listByFuncionario(funcId);
      if (meds.isNotEmpty) {
        currentMedicao = Medicao.fromJson(meds.first);
        // preenche campos
        equipamentoId = currentMedicao!.equipamentoId;
        dataMedicao = currentMedicao!.dataMedicao;
        horaInicio = currentMedicao!.horaInicio != null
            ? _parseTime(currentMedicao!.horaInicio!)
            : null;
        horaFim = currentMedicao!.horaFim != null
            ? _parseTime(currentMedicao!.horaFim!)
            : null;
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
        inicioPausa = currentMedicao!.inicioPausa != null
            ? _parseTime(currentMedicao!.inicioPausa!)
            : null;
        finalPausa = currentMedicao!.finalPausa != null
            ? _parseTime(currentMedicao!.finalPausa!)
            : null;
        jornadaCtrl.text = currentMedicao!.jornadaTrabalho ?? '';
        obsCtrl.text = currentMedicao!.observacao ?? '';
      } else {
        currentMedicao = null;
      }
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
    }
  }

  TimeOfDay _parseTime(String s) {
    final parts = s.split(':').map(int.parse).toList();
    return TimeOfDay(hour: parts[0], minute: parts[1]);
  }

  String? _formatTimeOfDay(TimeOfDay? t) {
    if (t == null) return null;
    final h = t.hour.toString().padLeft(2, '0');
    final m = t.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  @action
  Future<void> submit(int funcId, String status) async {
    loading = true;
    error = null;
    final dto = Medicao(
      id: currentMedicao?.id,
      funcionarioId: funcId,
      equipamentoId: equipamentoId,
      avaliadorId: Modular.get<AuthStore>().user!.id,
      status: status,
      dataMedicao: dataMedicao,
      horaInicio: _formatTimeOfDay(horaInicio),
      horaFim: _formatTimeOfDay(horaFim),
      tempoMostragem:
          tempoMostragemCtrl.text.isNotEmpty ? tempoMostragemCtrl.text : null,
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
      desvio: desvioCtrl.text.isNotEmpty ? double.parse(desvioCtrl.text) : null,
      tempoPausa: tempoPausaCtrl.text.isNotEmpty ? tempoPausaCtrl.text : null,
      inicioPausa: _formatTimeOfDay(inicioPausa),
      finalPausa: _formatTimeOfDay(finalPausa),
      jornadaTrabalho: jornadaCtrl.text.isNotEmpty ? jornadaCtrl.text : null,
      observacao: obsCtrl.text.isNotEmpty ? obsCtrl.text : null,
    ).toJson();

    try {
      if (currentMedicao == null) {
        await _medService.create(dto);
      } else {
        await _medService.update(currentMedicao!.id!, dto);
      }
      await selectEmpresa(selectedEmpresaId!);
    } on ApiException catch (e) {
      error = e.message;
      fieldErrors = e.errors; // seta os erros de campo vindos da API
    } catch (e) {
      error = 'Erro inesperado. Tente novamente.';
    } finally {
      loading = false;
    }
  }

  @action
  void resetForm() {
    // Dispose e recria cada TextEditingController
    try {
      tempoMostragemCtrl.dispose();
    } catch (_) {}
    tempoMostragemCtrl = TextEditingController();

    try {
      nenQ5Ctrl.dispose();
    } catch (_) {}
    nenQ5Ctrl = TextEditingController();

    try {
      lavgQ5Ctrl.dispose();
    } catch (_) {}
    lavgQ5Ctrl = TextEditingController();

    try {
      nenQ3Ctrl.dispose();
    } catch (_) {}
    nenQ3Ctrl = TextEditingController();

    try {
      lavgQ3Ctrl.dispose();
    } catch (_) {}
    lavgQ3Ctrl = TextEditingController();

    try {
      calibInicialCtrl.dispose();
    } catch (_) {}
    calibInicialCtrl = TextEditingController();

    try {
      calibFinalCtrl.dispose();
    } catch (_) {}
    calibFinalCtrl = TextEditingController();

    try {
      desvioCtrl.dispose();
    } catch (_) {}
    desvioCtrl = TextEditingController();

    try {
      tempoPausaCtrl.dispose();
    } catch (_) {}
    tempoPausaCtrl = TextEditingController();

    try {
      jornadaCtrl.dispose();
    } catch (_) {}
    jornadaCtrl = TextEditingController();

    try {
      obsCtrl.dispose();
    } catch (_) {}
    obsCtrl = TextEditingController();

    // Zera todos os campos “simples”
    equipamentoId = null;
    dataMedicao = null;
    horaInicio = null;
    horaFim = null;
    inicioPausa = null;
    finalPausa = null;

    // Se houver uma medição corrente, limpa-a
    currentMedicao = null;
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
