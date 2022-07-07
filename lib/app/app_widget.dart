import 'package:agenda_btg/app/animation.dart';
import 'package:agenda_btg/app/controllers/app_controller.dart';
import 'package:agenda_btg/app/themes/theme_dark.dart';
import 'package:agenda_btg/app/themes/theme_ligth.dart';
import 'package:flutter/material.dart';

import 'cadastro/lista_cadastro_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: AppController.instance.switchTheme,
      builder: (context, value, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: value ? ThemeLigth.instance.theme : ThemeDark.instance.theme,
          home: const SimpleAnimation(),
        );
      },
    );
  }
}
