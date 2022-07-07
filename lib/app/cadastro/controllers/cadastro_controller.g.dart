// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cadastro_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CadastroController on _CadastroControllerBase, Store {
  late final _$imagemAtom =
      Atom(name: '_CadastroControllerBase.imagem', context: context);

  @override
  File? get imagem {
    _$imagemAtom.reportRead();
    return super.imagem;
  }

  @override
  set imagem(File? value) {
    _$imagemAtom.reportWrite(value, super.imagem, () {
      super.imagem = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_CadastroControllerBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$imagemTemporariaAtom =
      Atom(name: '_CadastroControllerBase.imagemTemporaria', context: context);

  @override
  PickedFile? get imagemTemporaria {
    _$imagemTemporariaAtom.reportRead();
    return super.imagemTemporaria;
  }

  @override
  set imagemTemporaria(PickedFile? value) {
    _$imagemTemporariaAtom.reportWrite(value, super.imagemTemporaria, () {
      super.imagemTemporaria = value;
    });
  }

  late final _$getThemeAtom =
      Atom(name: '_CadastroControllerBase.getTheme', context: context);

  @override
  bool get getTheme {
    _$getThemeAtom.reportRead();
    return super.getTheme;
  }

  @override
  set getTheme(bool value) {
    _$getThemeAtom.reportWrite(value, super.getTheme, () {
      super.getTheme = value;
    });
  }

  late final _$listPersonAtom =
      Atom(name: '_CadastroControllerBase.listPerson', context: context);

  @override
  List<PersonModel> get listPerson {
    _$listPersonAtom.reportRead();
    return super.listPerson;
  }

  @override
  set listPerson(List<PersonModel> value) {
    _$listPersonAtom.reportWrite(value, super.listPerson, () {
      super.listPerson = value;
    });
  }

  late final _$setThemeUserAsyncAction =
      AsyncAction('_CadastroControllerBase.setThemeUser', context: context);

  @override
  Future setThemeUser(PersonModel model) {
    return _$setThemeUserAsyncAction.run(() => super.setThemeUser(model));
  }

  late final _$setThemeDefaultAsyncAction =
      AsyncAction('_CadastroControllerBase.setThemeDefault', context: context);

  @override
  Future setThemeDefault() {
    return _$setThemeDefaultAsyncAction.run(() => super.setThemeDefault());
  }

  late final _$setThemeAsyncAction =
      AsyncAction('_CadastroControllerBase.setTheme', context: context);

  @override
  Future setTheme(bool v) {
    return _$setThemeAsyncAction.run(() => super.setTheme(v));
  }

  late final _$savePersonAsyncAction =
      AsyncAction('_CadastroControllerBase.savePerson', context: context);

  @override
  Future savePerson(BuildContext context) {
    return _$savePersonAsyncAction.run(() => super.savePerson(context));
  }

  late final _$deletePersonAsyncAction =
      AsyncAction('_CadastroControllerBase.deletePerson', context: context);

  @override
  Future deletePerson(BuildContext context, PersonModel model) {
    return _$deletePersonAsyncAction
        .run(() => super.deletePerson(context, model));
  }

  late final _$editPersonAsyncAction =
      AsyncAction('_CadastroControllerBase.editPerson', context: context);

  @override
  Future editPerson(BuildContext context, PersonModel model) {
    return _$editPersonAsyncAction.run(() => super.editPerson(context, model));
  }

  late final _$getAllPersonsAsyncAction =
      AsyncAction('_CadastroControllerBase.getAllPersons', context: context);

  @override
  Future getAllPersons() {
    return _$getAllPersonsAsyncAction.run(() => super.getAllPersons());
  }

  late final _$pegarImagemAsyncAction =
      AsyncAction('_CadastroControllerBase.pegarImagem', context: context);

  @override
  Future<dynamic> pegarImagem() {
    return _$pegarImagemAsyncAction.run(() => super.pegarImagem());
  }

  late final _$tirarFotoAsyncAction =
      AsyncAction('_CadastroControllerBase.tirarFoto', context: context);

  @override
  Future<dynamic> tirarFoto() {
    return _$tirarFotoAsyncAction.run(() => super.tirarFoto());
  }

  @override
  String toString() {
    return '''
imagem: ${imagem},
isLoading: ${isLoading},
imagemTemporaria: ${imagemTemporaria},
getTheme: ${getTheme},
listPerson: ${listPerson}
    ''';
  }
}
