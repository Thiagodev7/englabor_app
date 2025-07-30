// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicoes_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MedicoesStore on _MedicoesStore, Store {
  late final _$empresasAtom =
      Atom(name: '_MedicoesStore.empresas', context: context);

  @override
  ObservableList<Map<String, dynamic>> get empresas {
    _$empresasAtom.reportRead();
    return super.empresas;
  }

  @override
  set empresas(ObservableList<Map<String, dynamic>> value) {
    _$empresasAtom.reportWrite(value, super.empresas, () {
      super.empresas = value;
    });
  }

  late final _$funcionariosAtom =
      Atom(name: '_MedicoesStore.funcionarios', context: context);

  @override
  ObservableList<Map<String, dynamic>> get funcionarios {
    _$funcionariosAtom.reportRead();
    return super.funcionarios;
  }

  @override
  set funcionarios(ObservableList<Map<String, dynamic>> value) {
    _$funcionariosAtom.reportWrite(value, super.funcionarios, () {
      super.funcionarios = value;
    });
  }

  late final _$equipListAtom =
      Atom(name: '_MedicoesStore.equipList', context: context);

  @override
  List<Map<String, dynamic>> get equipList {
    _$equipListAtom.reportRead();
    return super.equipList;
  }

  @override
  set equipList(List<Map<String, dynamic>> value) {
    _$equipListAtom.reportWrite(value, super.equipList, () {
      super.equipList = value;
    });
  }

  late final _$selectedEmpresaIdAtom =
      Atom(name: '_MedicoesStore.selectedEmpresaId', context: context);

  @override
  int? get selectedEmpresaId {
    _$selectedEmpresaIdAtom.reportRead();
    return super.selectedEmpresaId;
  }

  @override
  set selectedEmpresaId(int? value) {
    _$selectedEmpresaIdAtom.reportWrite(value, super.selectedEmpresaId, () {
      super.selectedEmpresaId = value;
    });
  }

  late final _$loadingAtom =
      Atom(name: '_MedicoesStore.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$errorAtom = Atom(name: '_MedicoesStore.error', context: context);

  @override
  String? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$fieldErrorsAtom =
      Atom(name: '_MedicoesStore.fieldErrors', context: context);

  @override
  List<FieldError>? get fieldErrors {
    _$fieldErrorsAtom.reportRead();
    return super.fieldErrors;
  }

  @override
  set fieldErrors(List<FieldError>? value) {
    _$fieldErrorsAtom.reportWrite(value, super.fieldErrors, () {
      super.fieldErrors = value;
    });
  }

  late final _$currentMedicaoAtom =
      Atom(name: '_MedicoesStore.currentMedicao', context: context);

  @override
  Medicao? get currentMedicao {
    _$currentMedicaoAtom.reportRead();
    return super.currentMedicao;
  }

  @override
  set currentMedicao(Medicao? value) {
    _$currentMedicaoAtom.reportWrite(value, super.currentMedicao, () {
      super.currentMedicao = value;
    });
  }

  late final _$equipamentoIdAtom =
      Atom(name: '_MedicoesStore.equipamentoId', context: context);

  @override
  int? get equipamentoId {
    _$equipamentoIdAtom.reportRead();
    return super.equipamentoId;
  }

  @override
  set equipamentoId(int? value) {
    _$equipamentoIdAtom.reportWrite(value, super.equipamentoId, () {
      super.equipamentoId = value;
    });
  }

  late final _$dataMedicaoAtom =
      Atom(name: '_MedicoesStore.dataMedicao', context: context);

  @override
  DateTime? get dataMedicao {
    _$dataMedicaoAtom.reportRead();
    return super.dataMedicao;
  }

  @override
  set dataMedicao(DateTime? value) {
    _$dataMedicaoAtom.reportWrite(value, super.dataMedicao, () {
      super.dataMedicao = value;
    });
  }

  late final _$horaInicioAtom =
      Atom(name: '_MedicoesStore.horaInicio', context: context);

  @override
  TimeOfDay? get horaInicio {
    _$horaInicioAtom.reportRead();
    return super.horaInicio;
  }

  @override
  set horaInicio(TimeOfDay? value) {
    _$horaInicioAtom.reportWrite(value, super.horaInicio, () {
      super.horaInicio = value;
    });
  }

  late final _$horaFimAtom =
      Atom(name: '_MedicoesStore.horaFim', context: context);

  @override
  TimeOfDay? get horaFim {
    _$horaFimAtom.reportRead();
    return super.horaFim;
  }

  @override
  set horaFim(TimeOfDay? value) {
    _$horaFimAtom.reportWrite(value, super.horaFim, () {
      super.horaFim = value;
    });
  }

  late final _$horaCalibracaoInicioAtom =
      Atom(name: '_MedicoesStore.horaCalibracaoInicio', context: context);

  @override
  TimeOfDay? get horaCalibracaoInicio {
    _$horaCalibracaoInicioAtom.reportRead();
    return super.horaCalibracaoInicio;
  }

  @override
  set horaCalibracaoInicio(TimeOfDay? value) {
    _$horaCalibracaoInicioAtom.reportWrite(value, super.horaCalibracaoInicio,
        () {
      super.horaCalibracaoInicio = value;
    });
  }

  late final _$horaCalibracaoFimAtom =
      Atom(name: '_MedicoesStore.horaCalibracaoFim', context: context);

  @override
  TimeOfDay? get horaCalibracaoFim {
    _$horaCalibracaoFimAtom.reportRead();
    return super.horaCalibracaoFim;
  }

  @override
  set horaCalibracaoFim(TimeOfDay? value) {
    _$horaCalibracaoFimAtom.reportWrite(value, super.horaCalibracaoFim, () {
      super.horaCalibracaoFim = value;
    });
  }

  late final _$tempoMostragemCtrlAtom =
      Atom(name: '_MedicoesStore.tempoMostragemCtrl', context: context);

  @override
  TextEditingController get tempoMostragemCtrl {
    _$tempoMostragemCtrlAtom.reportRead();
    return super.tempoMostragemCtrl;
  }

  @override
  set tempoMostragemCtrl(TextEditingController value) {
    _$tempoMostragemCtrlAtom.reportWrite(value, super.tempoMostragemCtrl, () {
      super.tempoMostragemCtrl = value;
    });
  }

  late final _$nenQ5CtrlAtom =
      Atom(name: '_MedicoesStore.nenQ5Ctrl', context: context);

  @override
  TextEditingController get nenQ5Ctrl {
    _$nenQ5CtrlAtom.reportRead();
    return super.nenQ5Ctrl;
  }

  @override
  set nenQ5Ctrl(TextEditingController value) {
    _$nenQ5CtrlAtom.reportWrite(value, super.nenQ5Ctrl, () {
      super.nenQ5Ctrl = value;
    });
  }

  late final _$lavgQ5CtrlAtom =
      Atom(name: '_MedicoesStore.lavgQ5Ctrl', context: context);

  @override
  TextEditingController get lavgQ5Ctrl {
    _$lavgQ5CtrlAtom.reportRead();
    return super.lavgQ5Ctrl;
  }

  @override
  set lavgQ5Ctrl(TextEditingController value) {
    _$lavgQ5CtrlAtom.reportWrite(value, super.lavgQ5Ctrl, () {
      super.lavgQ5Ctrl = value;
    });
  }

  late final _$nenQ3CtrlAtom =
      Atom(name: '_MedicoesStore.nenQ3Ctrl', context: context);

  @override
  TextEditingController get nenQ3Ctrl {
    _$nenQ3CtrlAtom.reportRead();
    return super.nenQ3Ctrl;
  }

  @override
  set nenQ3Ctrl(TextEditingController value) {
    _$nenQ3CtrlAtom.reportWrite(value, super.nenQ3Ctrl, () {
      super.nenQ3Ctrl = value;
    });
  }

  late final _$lavgQ3CtrlAtom =
      Atom(name: '_MedicoesStore.lavgQ3Ctrl', context: context);

  @override
  TextEditingController get lavgQ3Ctrl {
    _$lavgQ3CtrlAtom.reportRead();
    return super.lavgQ3Ctrl;
  }

  @override
  set lavgQ3Ctrl(TextEditingController value) {
    _$lavgQ3CtrlAtom.reportWrite(value, super.lavgQ3Ctrl, () {
      super.lavgQ3Ctrl = value;
    });
  }

  late final _$calibInicialCtrlAtom =
      Atom(name: '_MedicoesStore.calibInicialCtrl', context: context);

  @override
  TextEditingController get calibInicialCtrl {
    _$calibInicialCtrlAtom.reportRead();
    return super.calibInicialCtrl;
  }

  @override
  set calibInicialCtrl(TextEditingController value) {
    _$calibInicialCtrlAtom.reportWrite(value, super.calibInicialCtrl, () {
      super.calibInicialCtrl = value;
    });
  }

  late final _$calibFinalCtrlAtom =
      Atom(name: '_MedicoesStore.calibFinalCtrl', context: context);

  @override
  TextEditingController get calibFinalCtrl {
    _$calibFinalCtrlAtom.reportRead();
    return super.calibFinalCtrl;
  }

  @override
  set calibFinalCtrl(TextEditingController value) {
    _$calibFinalCtrlAtom.reportWrite(value, super.calibFinalCtrl, () {
      super.calibFinalCtrl = value;
    });
  }

  late final _$desvioCtrlAtom =
      Atom(name: '_MedicoesStore.desvioCtrl', context: context);

  @override
  TextEditingController get desvioCtrl {
    _$desvioCtrlAtom.reportRead();
    return super.desvioCtrl;
  }

  @override
  set desvioCtrl(TextEditingController value) {
    _$desvioCtrlAtom.reportWrite(value, super.desvioCtrl, () {
      super.desvioCtrl = value;
    });
  }

  late final _$tempoPausaCtrlAtom =
      Atom(name: '_MedicoesStore.tempoPausaCtrl', context: context);

  @override
  TextEditingController get tempoPausaCtrl {
    _$tempoPausaCtrlAtom.reportRead();
    return super.tempoPausaCtrl;
  }

  @override
  set tempoPausaCtrl(TextEditingController value) {
    _$tempoPausaCtrlAtom.reportWrite(value, super.tempoPausaCtrl, () {
      super.tempoPausaCtrl = value;
    });
  }

  late final _$jornadaCtrlAtom =
      Atom(name: '_MedicoesStore.jornadaCtrl', context: context);

  @override
  TextEditingController get jornadaCtrl {
    _$jornadaCtrlAtom.reportRead();
    return super.jornadaCtrl;
  }

  @override
  set jornadaCtrl(TextEditingController value) {
    _$jornadaCtrlAtom.reportWrite(value, super.jornadaCtrl, () {
      super.jornadaCtrl = value;
    });
  }

  late final _$obsCtrlAtom =
      Atom(name: '_MedicoesStore.obsCtrl', context: context);

  @override
  TextEditingController get obsCtrl {
    _$obsCtrlAtom.reportRead();
    return super.obsCtrl;
  }

  @override
  set obsCtrl(TextEditingController value) {
    _$obsCtrlAtom.reportWrite(value, super.obsCtrl, () {
      super.obsCtrl = value;
    });
  }

  late final _$inicioPausaAtom =
      Atom(name: '_MedicoesStore.inicioPausa', context: context);

  @override
  TimeOfDay? get inicioPausa {
    _$inicioPausaAtom.reportRead();
    return super.inicioPausa;
  }

  @override
  set inicioPausa(TimeOfDay? value) {
    _$inicioPausaAtom.reportWrite(value, super.inicioPausa, () {
      super.inicioPausa = value;
    });
  }

  late final _$finalPausaAtom =
      Atom(name: '_MedicoesStore.finalPausa', context: context);

  @override
  TimeOfDay? get finalPausa {
    _$finalPausaAtom.reportRead();
    return super.finalPausa;
  }

  @override
  set finalPausa(TimeOfDay? value) {
    _$finalPausaAtom.reportWrite(value, super.finalPausa, () {
      super.finalPausa = value;
    });
  }

  late final _$fotoAtom = Atom(name: '_MedicoesStore.foto', context: context);

  @override
  String? get foto {
    _$fotoAtom.reportRead();
    return super.foto;
  }

  @override
  set foto(String? value) {
    _$fotoAtom.reportWrite(value, super.foto, () {
      super.foto = value;
    });
  }

  late final _$assinaturaBytesAtom =
      Atom(name: '_MedicoesStore.assinaturaBytes', context: context);

  @override
  Uint8List? get assinaturaBytes {
    _$assinaturaBytesAtom.reportRead();
    return super.assinaturaBytes;
  }

  @override
  set assinaturaBytes(Uint8List? value) {
    _$assinaturaBytesAtom.reportWrite(value, super.assinaturaBytes, () {
      super.assinaturaBytes = value;
    });
  }

  late final _$loadEmpresasAsyncAction =
      AsyncAction('_MedicoesStore.loadEmpresas', context: context);

  @override
  Future<void> loadEmpresas() {
    return _$loadEmpresasAsyncAction.run(() => super.loadEmpresas());
  }

  late final _$selectEmpresaAsyncAction =
      AsyncAction('_MedicoesStore.selectEmpresa', context: context);

  @override
  Future<void> selectEmpresa(int id) {
    return _$selectEmpresaAsyncAction.run(() => super.selectEmpresa(id));
  }

  late final _$salvarAssinaturaAsyncAction =
      AsyncAction('_MedicoesStore.salvarAssinatura', context: context);

  @override
  Future<void> salvarAssinatura() {
    return _$salvarAssinaturaAsyncAction.run(() => super.salvarAssinatura());
  }

  late final _$loadEquipamentosAsyncAction =
      AsyncAction('_MedicoesStore.loadEquipamentos', context: context);

  @override
  Future<void> loadEquipamentos() {
    return _$loadEquipamentosAsyncAction.run(() => super.loadEquipamentos());
  }

  late final _$initMedicaoAsyncAction =
      AsyncAction('_MedicoesStore.initMedicao', context: context);

  @override
  Future<void> initMedicao(int funcId) {
    return _$initMedicaoAsyncAction.run(() => super.initMedicao(funcId));
  }

  late final _$submitAsyncAction =
      AsyncAction('_MedicoesStore.submit', context: context);

  @override
  Future<void> submit(int funcId, String status) {
    return _$submitAsyncAction.run(() => super.submit(funcId, status));
  }

  late final _$_MedicoesStoreActionController =
      ActionController(name: '_MedicoesStore', context: context);

  @override
  void setFoto(String b64) {
    final _$actionInfo = _$_MedicoesStoreActionController.startAction(
        name: '_MedicoesStore.setFoto');
    try {
      return super.setFoto(b64);
    } finally {
      _$_MedicoesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHoraInicio(TimeOfDay t) {
    final _$actionInfo = _$_MedicoesStoreActionController.startAction(
        name: '_MedicoesStore.setHoraInicio');
    try {
      return super.setHoraInicio(t);
    } finally {
      _$_MedicoesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHoraFim(TimeOfDay t) {
    final _$actionInfo = _$_MedicoesStoreActionController.startAction(
        name: '_MedicoesStore.setHoraFim');
    try {
      return super.setHoraFim(t);
    } finally {
      _$_MedicoesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setInicioPausa(TimeOfDay t) {
    final _$actionInfo = _$_MedicoesStoreActionController.startAction(
        name: '_MedicoesStore.setInicioPausa');
    try {
      return super.setInicioPausa(t);
    } finally {
      _$_MedicoesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFinalPausa(TimeOfDay t) {
    final _$actionInfo = _$_MedicoesStoreActionController.startAction(
        name: '_MedicoesStore.setFinalPausa');
    try {
      return super.setFinalPausa(t);
    } finally {
      _$_MedicoesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHoraCalibracaoInicio(TimeOfDay t) {
    final _$actionInfo = _$_MedicoesStoreActionController.startAction(
        name: '_MedicoesStore.setHoraCalibracaoInicio');
    try {
      return super.setHoraCalibracaoInicio(t);
    } finally {
      _$_MedicoesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHoraCalibracaoFim(TimeOfDay t) {
    final _$actionInfo = _$_MedicoesStoreActionController.startAction(
        name: '_MedicoesStore.setHoraCalibracaoFim');
    try {
      return super.setHoraCalibracaoFim(t);
    } finally {
      _$_MedicoesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetForm() {
    final _$actionInfo = _$_MedicoesStoreActionController.startAction(
        name: '_MedicoesStore.resetForm');
    try {
      return super.resetForm();
    } finally {
      _$_MedicoesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
empresas: ${empresas},
funcionarios: ${funcionarios},
equipList: ${equipList},
selectedEmpresaId: ${selectedEmpresaId},
loading: ${loading},
error: ${error},
fieldErrors: ${fieldErrors},
currentMedicao: ${currentMedicao},
equipamentoId: ${equipamentoId},
dataMedicao: ${dataMedicao},
horaInicio: ${horaInicio},
horaFim: ${horaFim},
horaCalibracaoInicio: ${horaCalibracaoInicio},
horaCalibracaoFim: ${horaCalibracaoFim},
tempoMostragemCtrl: ${tempoMostragemCtrl},
nenQ5Ctrl: ${nenQ5Ctrl},
lavgQ5Ctrl: ${lavgQ5Ctrl},
nenQ3Ctrl: ${nenQ3Ctrl},
lavgQ3Ctrl: ${lavgQ3Ctrl},
calibInicialCtrl: ${calibInicialCtrl},
calibFinalCtrl: ${calibFinalCtrl},
desvioCtrl: ${desvioCtrl},
tempoPausaCtrl: ${tempoPausaCtrl},
jornadaCtrl: ${jornadaCtrl},
obsCtrl: ${obsCtrl},
inicioPausa: ${inicioPausa},
finalPausa: ${finalPausa},
foto: ${foto},
assinaturaBytes: ${assinaturaBytes}
    ''';
  }
}
