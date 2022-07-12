import 'package:agenda_btg/app/cadastro/components/card_person_widget.dart';
import 'package:agenda_btg/app/cadastro/controllers/cadastro_controller.dart';
import 'package:agenda_btg/app/cadastro/models/person_model.dart';
import 'package:agenda_btg/app/cadastro/pages/lista_cadastro_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  CadastroController cadastroController;

  group("Lista de cadastro", () {
    cadastroController = CadastroController();
    cadastroController.isLoading = true;
    testWidgets("Loading", (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: ListaCadastroPage(
          controller: cadastroController,
        ),
      ));
      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
