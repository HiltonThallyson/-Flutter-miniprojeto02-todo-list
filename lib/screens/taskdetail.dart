import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/screenArgs.dart';

class TaskDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as ScreenArguments;

    return Scaffold(
        appBar: AppBar(
          title: Text('${args.tarefa.titulo}'),
        ),
        body: Center(
          child: Card(
            elevation: 10,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 350,
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                                'Observações: ${args.tarefa.observacao == null ? '' : args.tarefa.observacao}',
                                style: TextStyle(
                                  fontSize: 16,
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      RichText(
                          text: TextSpan(
                              text: 'Prioridade: ',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                              children: <TextSpan>[
                            TextSpan(
                                text: '${args.tarefa.prioridade}',
                                style: TextStyle(
                                    fontSize: 16, color: args.tarefa.cor))
                          ])),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: args.checkData(args.tarefa.criacao)
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context)
                                            .colorScheme
                                            .secondary),
                              ),
                              child: Text(
                                'Data de criação: ${DateFormat('d MMM y').format(args.tarefa.criacao)}',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: args.checkData(args.tarefa.criacao)
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: args.checkData(args.tarefa.data)
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context)
                                            .colorScheme
                                            .secondary),
                              ),
                              child: Text(
                                'Data da tarefa: ${DateFormat('d MMM y').format(args.tarefa.data)}',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: args.checkData(args.tarefa.data)
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context)
                                            .colorScheme
                                            .secondary),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
