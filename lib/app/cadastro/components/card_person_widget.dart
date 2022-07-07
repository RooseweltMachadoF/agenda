import 'package:agenda_btg/app/cadastro/cadastro_page.dart';
import 'package:agenda_btg/app/cadastro/controllers/cadastro_controller.dart';
import 'package:agenda_btg/app/cadastro/models/person_model.dart';
import 'package:agenda_btg/app/controllers/app_controller.dart';

import 'package:flutter/material.dart';
import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

class CardPerson extends StatelessWidget {
  final PersonModel personModel;
  final CadastroController controller;
  const CardPerson({
    Key? key,
    required this.personModel,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 105,
          decoration: BoxDecoration(
              color: AppController.instance.switchTheme.value
                  ? Colors.blueGrey
                  : const Color.fromRGBO(100, 255, 218, 0.5),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 2, color: Colors.black)),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                personModel.img != null && personModel.img != ''
                    ? Container(
                        width: 80.0,
                        height: 80.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: FileImage(File(personModel.img!)),
                              fit: BoxFit.cover),
                        ),
                      )
                    : const Icon(
                        Icons.person,
                        size: 55,
                        color: Colors.white,
                      ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 100,
                        child: Text(
                          personModel.name,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.phone,
                            size: 13,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            personModel.phone,
                            style: const TextStyle(fontSize: 13.0),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.document_scanner_outlined,
                            size: 13,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            personModel.cpf,
                            style: const TextStyle(fontSize: 13.0),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.date_range_rounded,
                            size: 13,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            personModel.nascimento,
                            style: const TextStyle(fontSize: 13.0),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () async {
                          await controller.setThemeUser(personModel);
                          if (personModel.img != null) {
                            controller.imagem = File(personModel.img!);
                          }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CadastroPage(
                                        controller: controller,
                                        personModel: personModel,
                                      )));
                        },
                        icon: const Icon(
                          Icons.edit,
                          size: 20,
                        )),
                    IconButton(
                        onPressed: () async {
                          await controller.deletePerson(context, personModel);
                        },
                        icon: const Icon(
                          Icons.delete_forever,
                          size: 20,
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        _showOptions(context);
      },
    );
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextButton(
                        onPressed: () {
                          launch("tel:${personModel.phone}");
                          Navigator.pop(context);
                        },
                        child: Text("Ligar")),
                    const SizedBox(
                      height: 5,
                    ),
                    TextButton(
                        onPressed: () async {
                          await controller.setThemeUser(personModel);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CadastroPage(
                                        controller: controller,
                                        personModel: personModel,
                                      )));
                        },
                        child: Text("Editar")),
                    TextButton(
                        onPressed: () async {
                          await controller.deletePerson(context, personModel);
                          Navigator.pop(context);
                        },
                        child: Text("Excluir")),
                  ],
                ),
              );
            },
          );
        });
  }
}
