// import 'package:agenda_btg/app/cadastro/components/card_person_widget.dart';
// import 'package:agenda_btg/app/cadastro/controllers/cadastro_controller.dart';
// import 'package:agenda_btg/app/cadastro/models/person_model.dart';

// import 'package:flutter/material.dart';

// class AnimatedListView extends StatelessWidget {
//   final Animation<EdgeInsets> listSlidePosition;
//   final List<PersonModel> listPersons;
//   final CadastroController controller;

//   AnimatedListView(
//       {required this.listSlidePosition,
//       required this.listPersons,
//       required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     List<CardPerson> listCard = [];
//     double margin = 0;
//     listPersons.forEach((element) {
//       CardPerson card = CardPerson(
//         personModel: element,
//         controller: controller,
//         margin: listSlidePosition.value * margin,
//       );
//       listCard.add(card);
//       margin++;
//     });
//     return Stack(
//       alignment: Alignment.bottomCenter,
//       children: listCard,
//     );
//   }
// }
