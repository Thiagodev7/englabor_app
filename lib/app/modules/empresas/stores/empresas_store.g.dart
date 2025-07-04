// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'empresas_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EmpresasStore on _EmpresasStoreBase, Store {
  late final _$companiesAtom =
      Atom(name: '_EmpresasStoreBase.companies', context: context);

  @override
  ObservableList<Company> get companies {
    _$companiesAtom.reportRead();
    return super.companies;
  }

  @override
  set companies(ObservableList<Company> value) {
    _$companiesAtom.reportWrite(value, super.companies, () {
      super.companies = value;
    });
  }

  late final _$loadingAtom =
      Atom(name: '_EmpresasStoreBase.loading', context: context);

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
      Atom(name: '_EmpresasStoreBase.errorMessage', context: context);

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

  late final _$newNomeAtom =
      Atom(name: '_EmpresasStoreBase.newNome', context: context);

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

  late final _$newCnpjAtom =
      Atom(name: '_EmpresasStoreBase.newCnpj', context: context);

  @override
  String get newCnpj {
    _$newCnpjAtom.reportRead();
    return super.newCnpj;
  }

  @override
  set newCnpj(String value) {
    _$newCnpjAtom.reportWrite(value, super.newCnpj, () {
      super.newCnpj = value;
    });
  }

  late final _$loadAllAsyncAction =
      AsyncAction('_EmpresasStoreBase.loadAll', context: context);

  @override
  Future<void> loadAll() {
    return _$loadAllAsyncAction.run(() => super.loadAll());
  }

  late final _$addCompanyAsyncAction =
      AsyncAction('_EmpresasStoreBase.addCompany', context: context);

  @override
  Future<void> addCompany() {
    return _$addCompanyAsyncAction.run(() => super.addCompany());
  }

  late final _$deleteCompanyAsyncAction =
      AsyncAction('_EmpresasStoreBase.deleteCompany', context: context);

  @override
  Future<void> deleteCompany(int id) {
    return _$deleteCompanyAsyncAction.run(() => super.deleteCompany(id));
  }

  @override
  String toString() {
    return '''
companies: ${companies},
loading: ${loading},
errorMessage: ${errorMessage},
newNome: ${newNome},
newCnpj: ${newCnpj}
    ''';
  }
}
