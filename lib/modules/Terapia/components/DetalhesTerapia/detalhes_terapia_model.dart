class DetalhesTerapiaModel {
  String? id;
  String? idter;
  String? nome;
  String? end;
  String? comp;
  String? cidade;
  String? bairro;
  String? uf;
  String? reg;
  String? diagnostico;
  String? latlng;
  String? convenio;
  String? cel;
  String? tel;
  String? dtnasc;
  String? idade;
  String? status;
  String? idStatus;
  String? ctlAceito;

  DetalhesTerapiaModel(
      {this.id,
      this.idter,
      this.nome,
      this.end,
      this.comp,
      this.cidade,
      this.bairro,
      this.uf,
      this.reg,
      this.diagnostico,
      this.latlng,
      this.convenio,
      this.cel,
      this.tel,
      this.dtnasc,
      this.idade,
      this.status,
      this.idStatus,
      this.ctlAceito});

  DetalhesTerapiaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idter = json['idter'];
    nome = json['nome'];
    end = json['end'];
    comp = json['comp'];
    cidade = json['cidade'];
    bairro = json['bairro'];
    uf = json['uf'];
    reg = json['reg'];
    diagnostico = json['diagnostico'];
    latlng = json['latlng'];
    convenio = json['convenio'];
    cel = json['cel'];
    tel = json['tel'];
    dtnasc = json['dtnasc'];
    idade = json['idade'];
    status = json['status'];
    idStatus = json['id_status'];
    ctlAceito = json['ctl_aceito'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idter'] = this.idter;
    data['nome'] = this.nome;
    data['end'] = this.end;
    data['comp'] = this.comp;
    data['cidade'] = this.cidade;
    data['bairro'] = this.bairro;
    data['uf'] = this.uf;
    data['reg'] = this.reg;
    data['diagnostico'] = this.diagnostico;
    data['latlng'] = this.latlng;
    data['convenio'] = this.convenio;
    data['cel'] = this.cel;
    data['tel'] = this.tel;
    data['dtnasc'] = this.dtnasc;
    data['idade'] = this.idade;
    data['status'] = this.status;
    data['id_status'] = this.idStatus;
    data['ctl_aceito'] = this.ctlAceito;
    return data;
  }
}
