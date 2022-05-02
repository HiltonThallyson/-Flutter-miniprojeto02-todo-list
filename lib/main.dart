//developed by Jean Lima

import 'dart:math';

import 'package:f2_todolist/components/TarefaForm.dart';
import 'package:f2_todolist/components/TarefaLista.dart';
import 'package:f2_todolist/models/tarefa.dart';
import 'package:flutter/material.dart';
import './utils/app-routes.dart';
import './screens/taskdetail.dart';

import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.HOME,
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: Colors.purple,
                secondary: Colors.red[700],
              )),
      routes: {
        AppRoutes.HOME: (context) => MyHomePage(),
        AppRoutes.DETAIL: (context) => TaskDetail(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _novaTarefa(String titulo, DateTime data, String observacao,
      String prioridade, Color cor) {
    Tarefa novaTarefa = Tarefa(
        id: Random().nextInt(9999).toString(),
        titulo: titulo,
        data: data,
        observacao: observacao,
        prioridade: prioridade,
        criacao: DateTime.now(),
        cor: cor);

    setState(() {
      _tarefas.add(novaTarefa);
    });
  }

  List<Tarefa> _tarefas = [
    Tarefa(
        id: '1',
        titulo: 'Renovar seguro do carro',
        data: DateTime(2022, 03, 30),
        prioridade: 'ALTA',
        criacao: DateTime.now(),
        cor: Colors.orange)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do List'),
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TarefaLista(_tarefas),
            ],
          )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return TarefaForm(_novaTarefa);
              });
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        label: Text('Nova Tarefa'),
        icon: Icon(Icons.add),
      ),
    );
  }
}
