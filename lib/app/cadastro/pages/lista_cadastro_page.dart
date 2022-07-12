import 'package:agenda_btg/app/cadastro/components/animated_list.dart';
import 'package:agenda_btg/app/cadastro/components/card_person_widget.dart';
import 'package:agenda_btg/app/cadastro/controllers/cadastro_controller.dart';
import 'package:agenda_btg/app/cadastro/models/person_model.dart';

import 'package:agenda_btg/app/controllers/app_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'cadastro_page.dart';

class ListaCadastroPage extends StatefulWidget {
  const ListaCadastroPage({Key? key}) : super(key: key);

  @override
  State<ListaCadastroPage> createState() => _ListaCadastroPageState();
}

class _ListaCadastroPageState extends State<ListaCadastroPage>
    with SingleTickerProviderStateMixin {
  late CadastroController controller;
  late Animation<EdgeInsets> listSlidePosition;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    listSlidePosition = EdgeInsetsTween(
            begin: EdgeInsets.only(bottom: 0), end: EdgeInsets.only(bottom: 80))
        .animate(CurvedAnimation(
            parent: animationController,
            curve: Interval(0.325, 0.8, curve: Curves.ease)));
    controller = CadastroController();

    controller.getAllPersons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromRGBO(5, 19, 42, 1),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CadastroPage()));
          },
          child: const Icon(Icons.person_add_alt),
        ),
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Container(
            height: MediaQuery.of(context).size.height * 0.08,
            width: MediaQuery.of(context).size.width * .5,
            child: Image.asset(
              'assets/images/btgimage.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        body: SafeArea(
          child: Observer(builder: (_) {
            if (controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Center(
              child: ListView.builder(
                itemCount: controller.listPerson.length,
                itemBuilder: (_, index) {
                  return CardPerson(
                    personModel: controller.listPerson[index],
                    controller: controller,
                  );
                },
              ),
            );
          }),
        ));
  }
}
