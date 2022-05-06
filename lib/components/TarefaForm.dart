import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TarefaForm extends StatefulWidget {
  void Function(String, DateTime, String, String, Color) onSubmit;

  TarefaForm(this.onSubmit);

  @override
  State<TarefaForm> createState() => _TarefaFormState();
}

class _TarefaFormState extends State<TarefaForm> {
  final _tarefaController = TextEditingController();
  final _observacaoController = TextEditingController();
  String _prioridade = 'NORMAL';
  String _observacao = '';

  DateTime _dataSelecionada = DateTime.now();

  _submitForm() {
    final titulo = _tarefaController.text;
    final observacao = _observacaoController.text;
    final prioridade = _prioridade;
    final corPrioridade;

    if (prioridade == 'BAIXA') {
      corPrioridade = Colors.green;
    } else if (prioridade == 'NORMAL') {
      corPrioridade = Colors.blue;
    } else {
      corPrioridade = Colors.orange;
    }

    if (titulo.isEmpty) {
      return;
    }

    Navigator.pop(context);

    widget.onSubmit(
        titulo, _dataSelecionada, observacao, prioridade, corPrioridade);
  }

  _showDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2023),
        builder: (context, child) {
          return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light(
                  primary: Theme.of(context).colorScheme.primary,
                ),
              ),
              child: child as Widget);
        }).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _dataSelecionada = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Container(
      padding: EdgeInsets.all(15),
      child: Column(children: <Widget>[
        TextField(
          style: Theme.of(context).textTheme.headline3,
          controller: _tarefaController,
          decoration: InputDecoration(
            labelText: 'Tarefa',
          ),
        ),
        TextField(
          style: Theme.of(context).textTheme.headline3,
          controller: _observacaoController,
          decoration: InputDecoration(
            labelText: 'Observacoes',
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
          alignment: Alignment.centerLeft,
          child: DropdownButton(
            value: _prioridade,
            onChanged: <String>(String prioridade) {
              setState(() {
                _prioridade = prioridade.toString();
              });
            },
            items: [
              DropdownMenuItem(
                  child: Text(
                    'BAIXA',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  value: 'BAIXA'),
              DropdownMenuItem(
                child: Text(
                  'NORMAL',
                  style: Theme.of(context).textTheme.headline3,
                ),
                value: 'NORMAL',
              ),
              DropdownMenuItem(
                child: Text(
                  'ALTA',
                  style: Theme.of(context).textTheme.headline3,
                ),
                value: 'ALTA',
              ),
            ],
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'Data selecionada ${DateFormat('dd/MM/y').format(_dataSelecionada)}',
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              TextButton(
                  onPressed: _showDatePicker,
                  child: Text(
                    'Selecionar data',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              ElevatedButton(onPressed: _submitForm, child: Text('Confirmar')),
        ),
      ]),
    ));
  }
}
