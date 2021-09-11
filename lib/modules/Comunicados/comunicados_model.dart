class ComunicadosModel {
  String? descricao;
  String? titulo;
  String? datacom;
  String? dia;
  String? mes;
  String? ano;

  ComunicadosModel({
    this.descricao,
    this.titulo,
    this.datacom,
    this.ano,
    this.mes,
    this.dia,
  });

  ComunicadosModel.fromJson(Map<String, dynamic> json) {
    descricao = json['descricao'];
    datacom = json['datacom'];
    titulo = json['titulo'];
    ano = json['ano'];
    mes = json['mes'];
    dia = json['dia'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['descricao'] = this.descricao;
    data['datacom'] = this.datacom;
    data['titulo'] = this.titulo;
    data['mes'] = this.mes;
    data['ano'] = this.ano;
    data['dia'] = this.dia;

    return data;
  }
}
