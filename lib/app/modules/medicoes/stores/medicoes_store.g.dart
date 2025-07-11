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

  @override
  String toString() {
    return '''
empresas: ${empresas},
funcionarios: ${funcionarios},
loading: ${loading},
error: ${error},
selectedEmpresaId: ${selectedEmpresaId}
    ''';
  }
}
