class MapaEvento {
  int? validausu;
  String? idevento;
  String? img;
  String? nome;
  String? unidade;
  String? titulo;
  String? descricao;
  String? respevent;
  String? areacom;
  String? dataAgenda;
  String? hragenda;
  String? ctl;
  String? status;

  MapaEvento(
      {this.validausu,
      this.idevento,
      this.img,
      this.nome,
      this.unidade,
      this.titulo,
      this.descricao,
      this.respevent,
      this.areacom,
      this.dataAgenda,
      this.hragenda,
      this.ctl,
      this.status});

  MapaEvento.fromJson(Map<String, dynamic> json) {
    validausu = json['validausu'];
    idevento = json['idevento'];
    img = json['img'];
    nome = json['nome'];
    unidade = json['unidade'];
    titulo = json['titulo'];
    descricao = json['descricao'];
    respevent = json['respevent'];
    areacom = json['areacom'];
    dataAgenda = json['data_agenda'];
    hragenda = json['hora_agenda'];
    ctl = json['ctl'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['validausu'] = this.validausu;
    data['idevento'] = this.idevento;
    data['img'] = this.img;
    data['nome'] = this.nome;
    data['unidade'] = this.unidade;
    data['titulo'] = this.titulo;
    data['descricao'] = this.descricao;
    data['respevent'] = this.respevent;
    data['areacom'] = this.areacom;
    data['data_agenda'] = this.dataAgenda;
    data['hora_agenda'] = this.hragenda;
    data['ctl'] = this.ctl;
    data['status'] = this.status;
    return data;
  }
}
