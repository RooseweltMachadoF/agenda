import 'dart:io';

import 'package:agenda_btg/app/cadastro/pages/lista_cadastro_page.dart';
import 'package:agenda_btg/app/cadastro/models/person_model.dart';
import 'package:agenda_btg/app/controllers/app_controller.dart';
import 'package:agenda_btg/helpers/cadastro_helper_db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mobx/mobx.dart';
import 'dart:math';
import '../pages/cadastro_page.dart';
part 'cadastro_controller.g.dart';

class CadastroController = _CadastroControllerBase with _$CadastroController;

abstract class _CadastroControllerBase with Store {
  TextEditingController? txtName;
  TextEditingController? txtNascimento;
  TextEditingController? txtCpf;
  TextEditingController? txtphone;

  late final MaskTextInputFormatter phoneMask;
  late final MaskTextInputFormatter cpfMask;
  late final MaskTextInputFormatter nascimentoMask;
  late CadastroHelper helper;
  final nameFocus = FocusNode();
  final cpfFocus = FocusNode();
  final phoneFocus = FocusNode();
  final nascimentoFocus = FocusNode();
  _CadastroControllerBase() {
    helper = CadastroHelper();
    phoneMask = MaskTextInputFormatter(
      mask: '(##) #####-####',
      initialText: '',
    );
    cpfMask = MaskTextInputFormatter(
      mask: '###.###.###-##',
      initialText: '',
    );
    nascimentoMask = MaskTextInputFormatter(
      mask: "##/##/####",
      initialText: '',
    );
    txtName = TextEditingController();
    txtNascimento = TextEditingController();
    txtCpf = TextEditingController();
    txtphone = TextEditingController();
  }

  @observable
  File? imagem;

  @observable
  bool isLoading = false;

  @observable
  PickedFile? imagemTemporaria;

  @observable
  bool getTheme = false;

  @observable
  List<PersonModel> listPerson = [];

  @action
  setThemeUser(PersonModel model) async {
    //TODO: 0 =true: 1= false
    if (model.themeIsDark == 0) {
      await AppController.instance.editTheme(true);
      getTheme = true;
    } else {
      await AppController.instance.editTheme(false);
      getTheme = false;
    }
  }

  @action
  setThemeDefault() async {
    await AppController.instance.editTheme(false);
    getTheme = false;
  }

  @action
  setTheme(bool v) async {
    getTheme = v;
    await AppController.instance.editTheme(v);
  }

  @action
  savePerson(BuildContext context) async {
    PersonModel model = PersonModel(
        img: imagem != null ? imagem!.path : null,
        cpf: txtCpf!.text,
        name: txtName!.text,
        phone: txtphone!.text,
        themeIsDark: AppController.instance.switchTheme.value
            ? 0
            : 1, //TODO: 0 =true: 1= false
        nascimento: txtNascimento!.text);

    try {
      await helper.saveContact(model);
      await setThemeDefault();
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: SizedBox(
                width: 100,
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Salvo com sucesso!'),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ListaCadastroPage()));
                        },
                        child: Text('OK'))
                  ],
                ),
              ),
            );
          });
    } catch (e) {
      print(e);
    }
  }

  preencheCampos(PersonModel model) async {
    txtName!.text = model.name;
    txtCpf!.text = model.cpf;
    txtphone!.text = model.phone;
    txtNascimento!.text = model.nascimento;
    //await AppController.instance.editTheme(model.themeIsDark);
  }

  @action
  deletePerson(BuildContext context, PersonModel model) async {
    try {
      await helper.deleteContact(model.id!);
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: SizedBox(
                width: 100,
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Deseja excluir o ${model.name}?'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () async {
                              Navigator.pop(context);
                              await helper.deleteContact(model.id!);
                              await getAllPersons();
                            },
                            child: const Text('Sim')),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Não')),
                      ],
                    )
                  ],
                ),
              ),
            );
          });
    } catch (e) {
      print(e);
    }
  }

  @action
  editPerson(BuildContext context, PersonModel model) async {
    model.cpf = txtCpf!.text;
    model.name = txtName!.text;
    model.phone = txtphone!.text;
    model.themeIsDark = AppController.instance.switchTheme.value ? 0 : 1;
    model.nascimento = txtNascimento!.text;
    if (imagem != null) {
      model.img = imagem!.path;
    }
    try {
      await helper.updateContact(model);
      await setThemeDefault();
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: SizedBox(
                width: 100,
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Editado com sucesso!'),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ListaCadastroPage()));
                        },
                        child: Text('OK'))
                  ],
                ),
              ),
            );
          });
    } catch (e) {
      print(e);
    }
  }

  @action
  getAllPersons() async {
    isLoading = true;
    listPerson = await helper.getAllContacts();
    isLoading = false;
  }

  @action
  Future pegarImagem() async {
    imagemTemporaria =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (imagemTemporaria == null) return;

    imagem = File(imagemTemporaria!.path);
  }

  @action
  Future tirarFoto() async {
    imagemTemporaria = await ImagePicker().getImage(source: ImageSource.camera);
    imagem = File(imagemTemporaria!.path);
  }

  cadastrarAluno() async {
    Map<String, dynamic> body = {"": 1};
  }

  void seletor(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: 100,
              width: 100,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                            backgroundColor: Colors.black.withOpacity(0.5),
                            radius: 32,
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  pegarImagem();
                                },
                                icon: const Icon(
                                  Icons.photo,
                                  color: Colors.white,
                                ))),
                        const Text("Galeria")
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.black.withOpacity(0.5),
                          radius: 32,
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                                tirarFoto();
                              },
                              icon: const Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.white,
                              )),
                        ),
                        const Text("Tirar foto")
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
