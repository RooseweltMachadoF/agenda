import 'package:agenda_btg/app/animation.dart';
import 'package:agenda_btg/app/controllers/app_controller.dart';
import 'package:agenda_btg/app/themes/theme_dark.dart';
import 'package:agenda_btg/app/themes/theme_ligth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'cadastro/pages/lista_cadastro_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (context, child) {
      return ValueListenableBuilder<bool>(
        valueListenable: AppController.instance.switchTheme,
        builder: (context, value, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: value ? ThemeDark.instance.theme : ThemeLigth.instance.theme,
            home: const SimpleAnimation(),
          );
        },
      );
    });
  }
}
