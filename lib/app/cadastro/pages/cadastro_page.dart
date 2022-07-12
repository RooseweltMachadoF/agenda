import 'package:agenda_btg/app/cadastro/components/textfield_custom.dart';
import 'package:agenda_btg/app/cadastro/controllers/cadastro_controller.dart';
import 'package:agenda_btg/app/cadastro/models/person_model.dart';

import 'package:agenda_btg/app/controllers/app_controller.dart';
import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/src/size_extension.dart';

class CadastroPage extends StatefulWidget {
  final PersonModel? personModel;
  final CadastroController? controller;
  const CadastroPage({Key? key, this.personModel, this.controller})
      : super(key: key);

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  late CadastroController controller;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      controller = CadastroController();
    } else if (widget.controller != null && widget.personModel != null) {
      controller = widget.controller!;
      controller.preencheCampos(widget.personModel!);
      controller.setThemeUser(widget.personModel!);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(
            height: MediaQuery.of(context).size.height * 0.08,
            width: MediaQuery.of(context).size.width * .5,
            child: Image.asset('assets/images/btgimage.png')),
        leading: IconButton(
            onPressed: () async {
              await controller.setThemeDefault();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.chevron_left)),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Observer(builder: (_) {
                return GestureDetector(
                  onTap: () {
                    controller.seletor(context);
                  },
                  child: controller.imagem == null
                      ? Container(
                          height: 150.h,
                          width: 120.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_a_photo,
                                  size: 50.sp,
                                  color: Color.fromARGB(255, 35, 78, 152)),
                              Text("Adicionar foto")
                            ],
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromARGB(255, 35, 78, 152),
                                width: 3.w),
                          ),
                        )
                      : GestureDetector(
                          child: SizedBox(
                            height: 150.h,
                            width: 120.w,
                            child:
                                ClipRect(child: Image.file(controller.imagem!)),
                          ),
                        ),
                );
              }),
              Container(
                  height: 500.h,
                  width: 310.w,
                  decoration: BoxDecoration(
                      color: AppController.instance.switchTheme.value
                          ? Color.fromRGBO(5, 19, 42, 1)
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextFieldCustom(
                          onSubmitted: (v) {
                            FocusScope.of(context)
                                .requestFocus(controller.nascimentoFocus);
                          },
                          focusNode: controller.nameFocus,
                          keyboardType: TextInputType.name,
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Color.fromARGB(255, 35, 78, 152),
                          ),
                          controller: controller.txtName,
                          labelText: "Nome",
                        ),
                        TextFieldCustom(
                          focusNode: controller.nascimentoFocus,
                          keyboardType: TextInputType.number,
                          prefixIcon: const Icon(
                            Icons.date_range,
                            color: Color.fromARGB(255, 35, 78, 152),
                          ),
                          inputFormatters: [controller.nascimentoMask],
                          controller: controller.txtNascimento,
                          onSubmitted: (v) {
                            FocusScope.of(context)
                                .requestFocus(controller.cpfFocus);
                          },
                          labelText: "Nascimento",
                        ),
                        TextFieldCustom(
                          focusNode: controller.cpfFocus,
                          keyboardType: TextInputType.number,
                          prefixIcon: const Icon(
                            Icons.document_scanner_outlined,
                            color: Color.fromARGB(255, 35, 78, 152),
                          ),
                          controller: controller.txtCpf,
                          inputFormatters: [controller.cpfMask],
                          onSubmitted: (v) {
                            FocusScope.of(context)
                                .requestFocus(controller.phoneFocus);
                          },
                          labelText: "Cpf",
                        ),
                        TextFieldCustom(
                          focusNode: controller.phoneFocus,
                          keyboardType: TextInputType.number,
                          prefixIcon: const Icon(
                            Icons.phone,
                            color: Color.fromARGB(255, 35, 78, 152),
                          ),
                          inputFormatters: [controller.phoneMask],
                          controller: controller.txtphone,
                          labelText: "Telefone",
                        ),
                        const Text('Escolha um tema:'),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Container(
                            height: 55,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2,
                                    color:
                                        AppController.instance.switchTheme.value
                                            ? Colors.black
                                            : Colors.white)),
                            child: Observer(builder: (_) {
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text('Ligth'),
                                      Switch(
                                          value: controller.getTheme,
                                          onChanged: (v) async {
                                            await controller.setTheme(v);
                                          }),
                                      const Text('Dark'),
                                    ],
                                  ),
                                ],
                              );
                            }),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        widget.controller == null
                            ? _buildButtonCadastrar()
                            : _buildButtonEditar(context)
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  _buildButtonCadastrar() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 35, 78, 152),
          borderRadius: BorderRadius.circular(30)),
      child: TextButton(
          onPressed: () async {
            await controller.savePerson(context);
          },
          child: const Center(
              child: Text(
            "Cadastrar",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ))),
    );
  }

  _buildButtonEditar(BuildContext cntx) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 35, 78, 152),
          borderRadius: BorderRadius.circular(30)),
      child: TextButton(
          onPressed: () async {
            await widget.controller!.editPerson(context, widget.personModel!);
          },
          child: const Center(
              child: Text(
            "Editar",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ))),
    );
  }
}
