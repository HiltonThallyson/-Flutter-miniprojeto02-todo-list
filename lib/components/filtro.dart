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
            lastDate: DateTime(2023))
        .then((pickedDate) {
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
                  style: TextStyle(fontSize: 16),
                ),
                DropdownButton(
                  value: _tipoFiltro,
                  items: [
                    DropdownMenuItem(
                      child: Text(
                        'prioridade',
                        style: TextStyle(fontSize: 13),
                      ),
                      value: 'prioridade',
                    ),
                    DropdownMenuItem(
                      child: Text('data', style: TextStyle(fontSize: 13)),
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
                      Text('Valor: ', style: TextStyle(fontSize: 16)),
                      DropdownButton(
                          value: _valorPrioridade,
                          items: [
                            DropdownMenuItem(
                              child:
                                  Text('ALTA', style: TextStyle(fontSize: 13)),
                              value: 'ALTA',
                            ),
                            DropdownMenuItem(
                              child: Text('NORMAL',
                                  style: TextStyle(fontSize: 13)),
                              value: 'NORMAL',
                            ),
                            DropdownMenuItem(
                              child:
                                  Text('BAIXA', style: TextStyle(fontSize: 13)),
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
                            'Data selecionada ${DateFormat('dd/MM/y').format(_dataSelecionada)}'),
                      ),
                      TextButton(
                          onPressed: _showDatePicker,
                          child: Text('Selecionar data'))
                    ],
                  )),
            ElevatedButton(
                onPressed: _submitForm, child: Text('Aplicar filtro'))
          ],
        ),
      ),
    );
  }
}
