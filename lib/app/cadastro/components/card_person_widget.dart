import 'package:agenda_btg/app/cadastro/pages/cadastro_page.dart';
import 'package:agenda_btg/app/cadastro/controllers/cadastro_controller.dart';
import 'package:agenda_btg/app/cadastro/models/person_model.dart';
import 'package:agenda_btg/app/controllers/app_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
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
        padding: EdgeInsets.all(8.0.sp),
        child: Container(
          height: 105.h,
          decoration: BoxDecoration(
              color: AppController.instance.switchTheme.value
                  ? Colors.blueGrey
                  : const Color.fromRGBO(5, 19, 42, 0.5),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  blurRadius: 20.0,
                  spreadRadius: 0.0,
                  offset: Offset(5, 5),
                  color: Colors.grey,
                )
              ],
              border: Border.all(width: 1, color: Colors.black)),
          child: Padding(
            padding: EdgeInsets.all(10.0.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                personModel.img != null && personModel.img != ''
                    ? Container(
                        width: 80.0.w,
                        height: 80.0.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: FileImage(File(personModel.img!)),
                              fit: BoxFit.cover),
                        ),
                      )
                    : Icon(
                        Icons.person,
                        size: 55.sp,
                        color: Colors.white,
                      ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 100.w,
                        child: Text(
                          personModel.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16.0.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.phone,
                            size: 13.sp,
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Text(
                            personModel.phone,
                            style: TextStyle(fontSize: 13.0.sp),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.document_scanner_outlined,
                            size: 13.sp,
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Text(
                            personModel.cpf,
                            style: TextStyle(fontSize: 13.0.sp),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.date_range_rounded,
                            size: 13.sp,
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Text(
                            personModel.nascimento,
                            style: TextStyle(fontSize: 13.0.sp),
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
                        icon: Icon(
                          Icons.edit,
                          size: 20.sp,
                        )),
                    IconButton(
                        onPressed: () async {
                          await controller.deletePerson(context, personModel);
                        },
                        icon: Icon(
                          Icons.delete_forever,
                          size: 20.sp,
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
                  ],
                ),
              );
            },
          );
        });
  }
}
