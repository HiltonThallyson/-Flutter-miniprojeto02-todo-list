//developed by Jean Lima

import 'dart:math';

import 'package:f2_todolist/components/TarefaForm.dart';
import 'package:f2_todolist/components/TarefaLista.dart';
import 'package:f2_todolist/components/filtro.dart';
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
              ),
          textTheme: const TextTheme().copyWith(
            headline4: TextStyle(fontSize: 13, color: Colors.black),
            headline3: TextStyle(fontSize: 16, color: Colors.black),
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
  String _filtroAplicado = '';
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

  List<Tarefa> _tarefasFiltradas = [];

  List<Tarefa> _tarefas = [
    Tarefa(
        id: '1',
        titulo: 'Renovar seguro do carro',
        data: DateTime(2022, 03, 30),
        prioridade: 'ALTA',
        criacao: DateTime(2022, 02, 01),
        cor: Colors.orange)
  ];

  @override
  void initState() {
    setState(() {
      _tarefasFiltradas = _tarefas;
    });
    super.initState();
  }

  _filtrarTarefas(String valor, String tipo, DateTime data) {
    setState(() {
      if (tipo == 'prioridade') {
        _filtroAplicado = valor;
        _tarefasFiltradas =
            _tarefas.where((tarefa) => tarefa.prioridade == valor).toList();
      } else if (tipo == 'data') {
        _filtroAplicado = DateFormat('dd/MM/y').format(data).toString();
        _tarefasFiltradas = _tarefas
            .where((tarefa) => tarefa.data.difference(data).inDays == 0)
            .toList();
      }
    });
  }

  _limparFiltros() {
    setState(() {
      _filtroAplicado = '';
      _tarefasFiltradas = _tarefas;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do List'),
      ),
      body: Column(
        children: [
          Container(
              margin: EdgeInsets.all(10),
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  Text(
                    '${_filtroAplicado}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  (_filtroAplicado != ''
                      ? GestureDetector(
                          onTap: _limparFiltros,
                          child: Icon(Icons.highlight_remove_sharp))
                      : Text('')),
                ],
              )),
          InkWell(
            onLongPress: () => showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(height: 200, child: Filtro(_filtrarTarefas));
              },
            ),
            child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    TarefaLista(_tarefasFiltradas),
                  ],
                )),
          ),
        ],
      ),
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
