class ComunicadosModel {
  String? idcom;
  String? titulo;
  String? descricao;
  String? datacom;
  String? dia;
  String? mes;
  String? ano;

  ComunicadosModel(
      {this.idcom,
      this.titulo,
      this.descricao,
      this.datacom,
      this.dia,
      this.mes,
      this.ano});

  ComunicadosModel.fromJson(Map<String, dynamic> json) {
    idcom = json['idcom'];
    titulo = json['titulo'];
    descricao = json['descricao'];
    datacom = json['datacom'];
    dia = json['dia'];
    mes = json['mes'];
    ano = json['ano'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idcom'] = this.idcom;
    data['titulo'] = this.titulo;
    data['descricao'] = this.descricao;
    data['datacom'] = this.datacom;
    data['dia'] = this.dia;
    data['mes'] = this.mes;
    data['ano'] = this.ano;
    return data;
  }
}
