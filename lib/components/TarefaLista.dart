import 'package:f2_todolist/models/tarefa.dart';
import 'package:f2_todolist/utils/app-routes.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import '../models/screenArgs.dart';

class TarefaLista extends StatefulWidget {
  List<Tarefa> _tarefasFiltradas;
  List<Tarefa> _tarefas;
  String _filtro;

  TarefaLista(this._tarefasFiltradas, this._tarefas, this._filtro);

  @override
  State<TarefaLista> createState() => _TarefaListaState();
}

class _TarefaListaState extends State<TarefaLista> {
  bool _checkData(DateTime data) {
    DateTime now = DateTime.now();
    if (data.year > now.year) {
      return true;
    } else if (data.year == now.year && data.month > now.month) {
      return true;
    } else if (data.year == now.year &&
        data.month == now.month &&
        data.day >= now.day) {
      return true;
    } else {
      return false;
    }
  }

  _removeItem(index) {
    setState(() {
      if (widget._filtro != '') {
        widget._tarefas.removeWhere((tarefa) =>
            tarefa.id == widget._tarefasFiltradas.elementAt(index).id);
      }
      widget._tarefasFiltradas.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: (widget._tarefasFiltradas.length > 0
          ? ListView.builder(
              itemCount: widget._tarefasFiltradas.length,
              itemBuilder: (context, index) {
                final tarefa = widget._tarefasFiltradas[index];
                return Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.DETAIL,
                          arguments: ScreenArguments(tarefa, _checkData));
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2,
                                    color: _checkData(tarefa.data)
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context)
                                            .colorScheme
                                            .secondary),
                              ),
                              margin: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              padding: EdgeInsets.all(10),
                              child: Text(
                                  DateFormat('d MMM y').format(tarefa.data),
                                  style: TextStyle(
                                      color: _checkData(tarefa.data)
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Theme.of(context)
                                              .colorScheme
                                              .secondary))),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tarefa.titulo,
                                style: Theme.of(context).textTheme.headline3,
                              ),
                              RichText(
                                  text: TextSpan(
                                      text: 'Prioridade: ',
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey[700]),
                                      children: <TextSpan>[
                                    TextSpan(
                                        text: '${tarefa.prioridade}',
                                        style: TextStyle(
                                            fontSize: 10, color: tarefa.cor))
                                  ])),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 10),
                          child: GestureDetector(
                              child: Icon(Icons.delete),
                              onTap: () => _removeItem(index)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Text(
                'Nenhuma tarefa cadastrada!',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            )),
    );
  }
}
