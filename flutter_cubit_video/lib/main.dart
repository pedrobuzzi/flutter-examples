import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit_video/cubit/greeting_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: BlocProvider<GreetingCubit>(
          create: (context) => GreetingCubit(), child: HomePage()),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                TextMessage(),
                TextButton(
                    onPressed: () {
                      final greetingCubit = context.read<GreetingCubit>();
                      greetingCubit.getNextGreetingState();
                    },
                    child: Text('Próximo visita')),
                TextButton(
                    onPressed: () {
                      final greetingCubit = context.read<GreetingCubit>();
                      greetingCubit.resetCouting();
                    },
                    child: Text('Zerar contagem'))
              ],
            )));
  }
}

class TextMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GreetingCubit, GreetingState>(builder: (context, state) {
      String message = '';

      if (state is GreetingInitial) {
        message = 'Bem vindo';
      } else if (state is GreetingSecondTime) {
        message = 'É seu segundo acesso, parabéns!';
      } else if (state is GreetingThirdTime) {
        message = 'É seu terceiro acesso, continue assim!';
      } else {
        message = 'Bem vindo novamente';
      }

      return Text(
        message,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      );
    });
  }
}
