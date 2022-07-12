import 'package:agenda_btg/app/cadastro/pages/cadastro_page.dart';
import 'package:agenda_btg/app/cadastro/pages/lista_cadastro_page.dart';
import 'package:agenda_btg/app/cadastro/pages/lista_cadastro_page.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SimpleAnimation extends StatefulWidget {
  const SimpleAnimation({Key? key}) : super(key: key);

  @override
  State<SimpleAnimation> createState() => _SimpleAnimationState();
}

class _SimpleAnimationState extends State<SimpleAnimation> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4)).then((_) => Navigator.push(
        context, MaterialPageRoute(builder: (context) => ListaCadastroPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          SizedBox(
            height: 100,
            width: 100,
            child: RiveAnimation.asset(
              'assets/animations/2359-4685-spinning-gears.riv',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Estamos carregando os seus dados',
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
