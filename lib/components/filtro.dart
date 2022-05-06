import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Filtro extends StatefulWidget {
  void Function(String valorFiltro, String tipoFiltro, DateTime dataFiltro)
      onSubmit;

  Filtro(this.onSubmit);
  @override
  State<Filtro> createState() => _FiltroState();
}

class _FiltroState extends State<Filtro> {
  String _tipoFiltro = 'prioridade';
  String _valorPrioridade = 'NORMAL';
  DateTime _dataSelecionada = DateTime.now();

  _submitForm() {
    Navigator.pop(context);
    widget.onSubmit(_valorPrioridade, _tipoFiltro, _dataSelecionada);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990, 01, 01),
      lastDate: DateTime(2023),
      builder: (context, child) {
        return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: Theme.of(context).colorScheme.primary,
              ),
            ),
            child: child as Widget);
      },
    ).then((pickedDate) {
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
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Filtro: ',
                  style: Theme.of(context).textTheme.headline3,
                ),
                DropdownButton(
                  value: _tipoFiltro,
                  items: [
                    DropdownMenuItem(
                      child: Text(
                        'prioridade',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      value: 'prioridade',
                    ),
                    DropdownMenuItem(
                      child: Text('data',
                          style: Theme.of(context).textTheme.headline3),
                      value: 'data',
                    ),
                  ],
                  onChanged: <String>(String filtro) => {
                    setState(() {
                      _tipoFiltro = filtro.toString();
                    })
                  },
                ),
              ],
            ),
            (_tipoFiltro == 'prioridade'
                ? Row(
                    children: [
                      Text('Valor: ',
                          style: Theme.of(context).textTheme.headline3),
                      DropdownButton(
                          value: _valorPrioridade,
                          items: [
                            DropdownMenuItem(
                              child: Text('ALTA',
                                  style: Theme.of(context).textTheme.headline4),
                              value: 'ALTA',
                            ),
                            DropdownMenuItem(
                              child: Text('NORMAL',
                                  style: Theme.of(context).textTheme.headline4),
                              value: 'NORMAL',
                            ),
                            DropdownMenuItem(
                              child: Text('BAIXA',
                                  style: Theme.of(context).textTheme.headline4),
                              value: 'BAIXA',
                            ),
                          ],
                          onChanged: <String>(String valor) {
                            setState(() {
                              _valorPrioridade = valor.toString();
                            });
                          })
                    ],
                  )
                : Row(
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
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      )
                    ],
                  )),
            ElevatedButton(
                onPressed: _submitForm,
                child: Text('Aplicar filtro',
                    style: Theme.of(context).textTheme.headline3))
          ],
        ),
      ),
    );
  }
}
