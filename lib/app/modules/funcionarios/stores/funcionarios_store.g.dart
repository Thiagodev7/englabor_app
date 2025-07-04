// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funcionarios_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FuncionariosStore on _FuncionariosStoreBase, Store {
  Computed<List<Funcionario>>? _$filteredComputed;

  @override
  List<Funcionario> get filtered =>
      (_$filteredComputed ??= Computed<List<Funcionario>>(() => super.filtered,
              name: '_FuncionariosStoreBase.filtered'))
          .value;

  late final _$funcionariosAtom =
      Atom(name: '_FuncionariosStoreBase.funcionarios', context: context);

  @override
  ObservableList<Funcionario> get funcionarios {
    _$funcionariosAtom.reportRead();
    return super.funcionarios;
  }

  @override
  set funcionarios(ObservableList<Funcionario> value) {
    _$funcionariosAtom.reportWrite(value, super.funcionarios, () {
      super.funcionarios = value;
    });
  }

  late final _$loadingAtom =
      Atom(name: '_FuncionariosStoreBase.loading', context: context);

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

  late final _$errorMessageAtom =
      Atom(name: '_FuncionariosStoreBase.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$searchQueryAtom =
      Atom(name: '_FuncionariosStoreBase.searchQuery', context: context);

  @override
  String get searchQuery {
    _$searchQueryAtom.reportRead();
    return super.searchQuery;
  }

  @override
  set searchQuery(String value) {
    _$searchQueryAtom.reportWrite(value, super.searchQuery, () {
      super.searchQuery = value;
    });
  }

  late final _$newNomeAtom =
      Atom(name: '_FuncionariosStoreBase.newNome', context: context);

  @override
  String get newNome {
    _$newNomeAtom.reportRead();
    return super.newNome;
  }

  @override
  set newNome(String value) {
    _$newNomeAtom.reportWrite(value, super.newNome, () {
      super.newNome = value;
    });
  }

  late final _$newMatriculaAtom =
      Atom(name: '_FuncionariosStoreBase.newMatricula', context: context);

  @override
  String get newMatricula {
    _$newMatriculaAtom.reportRead();
    return super.newMatricula;
  }

  @override
  set newMatricula(String value) {
    _$newMatriculaAtom.reportWrite(value, super.newMatricula, () {
      super.newMatricula = value;
    });
  }

  late final _$newSetorAtom =
      Atom(name: '_FuncionariosStoreBase.newSetor', context: context);

  @override
  String get newSetor {
    _$newSetorAtom.reportRead();
    return super.newSetor;
  }

  @override
  set newSetor(String value) {
    _$newSetorAtom.reportWrite(value, super.newSetor, () {
      super.newSetor = value;
    });
  }

  late final _$newGheAtom =
      Atom(name: '_FuncionariosStoreBase.newGhe', context: context);

  @override
  String get newGhe {
    _$newGheAtom.reportRead();
    return super.newGhe;
  }

  @override
  set newGhe(String value) {
    _$newGheAtom.reportWrite(value, super.newGhe, () {
      super.newGhe = value;
    });
  }

  late final _$newCargoAtom =
      Atom(name: '_FuncionariosStoreBase.newCargo', context: context);

  @override
  String get newCargo {
    _$newCargoAtom.reportRead();
    return super.newCargo;
  }

  @override
  set newCargo(String value) {
    _$newCargoAtom.reportWrite(value, super.newCargo, () {
      super.newCargo = value;
    });
  }

  late final _$loadByEmpresaAsyncAction =
      AsyncAction('_FuncionariosStoreBase.loadByEmpresa', context: context);

  @override
  Future<void> loadByEmpresa(int empresaId) {
    return _$loadByEmpresaAsyncAction.run(() => super.loadByEmpresa(empresaId));
  }

  late final _$addFuncionarioAsyncAction =
      AsyncAction('_FuncionariosStoreBase.addFuncionario', context: context);

  @override
  Future<void> addFuncionario(int empresaId) {
    return _$addFuncionarioAsyncAction
        .run(() => super.addFuncionario(empresaId));
  }

  late final _$deleteFuncionarioAsyncAction =
      AsyncAction('_FuncionariosStoreBase.deleteFuncionario', context: context);

  @override
  Future<void> deleteFuncionario(int id) {
    return _$deleteFuncionarioAsyncAction
        .run(() => super.deleteFuncionario(id));
  }

  late final _$updateFuncionarioAsyncAction =
      AsyncAction('_FuncionariosStoreBase.updateFuncionario', context: context);

  @override
  Future<void> updateFuncionario(int id, int empresaId) {
    return _$updateFuncionarioAsyncAction
        .run(() => super.updateFuncionario(id, empresaId));
  }

  late final _$_FuncionariosStoreBaseActionController =
      ActionController(name: '_FuncionariosStoreBase', context: context);

  @override
  void setSearch(String q) {
    final _$actionInfo = _$_FuncionariosStoreBaseActionController.startAction(
        name: '_FuncionariosStoreBase.setSearch');
    try {
      return super.setSearch(q);
    } finally {
      _$_FuncionariosStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
funcionarios: ${funcionarios},
loading: ${loading},
errorMessage: ${errorMessage},
searchQuery: ${searchQuery},
newNome: ${newNome},
newMatricula: ${newMatricula},
newSetor: ${newSetor},
newGhe: ${newGhe},
newCargo: ${newCargo},
filtered: ${filtered}
    ''';
  }
}
