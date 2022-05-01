import 'package:flutter/cupertino.dart';

class Tarefa {
  String id;
  String titulo;
  DateTime data;
  DateTime criacao;
  String? observacao;
  String prioridade;
  Color cor;

  Tarefa(
      {required this.id,
      required this.titulo,
      required this.data,
      this.observacao,
      required this.prioridade,
      required this.criacao,
      required this.cor});
}
