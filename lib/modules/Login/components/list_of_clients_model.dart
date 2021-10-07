class ListOfClientsModel {
  String? nomecliente;
  String? idprof;
  String? idcliente;
  String? imglogo;
  String? imglogobranca;
  String? slogan;
  String? nomeprof;
  String? emailprof;
  String? especialidade;
  String? imgperfil;

  ListOfClientsModel({
    this.nomecliente,
    this.idprof,
    this.idcliente,
    this.imglogo,
    this.imglogobranca,
    this.slogan,
    this.nomeprof,
    this.emailprof,
    this.especialidade,
    this.imgperfil,
  });

  ListOfClientsModel.fromJson(Map<String, dynamic> json) {
    nomecliente = json['nomecliente'];
    idprof = json['idprof'];
    idcliente = json['idcliente'];
    imglogo = json['imglogo'];
    imglogobranca = json['imglogobranca'];
    slogan = json['slogan'];
    nomeprof = json['nomeprof'];
    emailprof = json['emailprof'];
    especialidade = json['especialidade'];
    imgperfil = json['imgperfil'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nomecliente'] = this.nomecliente;
    data['idprof'] = this.idprof;
    data['idcliente'] = this.idcliente;
    data['imglogo'] = this.imglogo;
    data['imglogobranca'] = this.imglogobranca;
    data['slogan'] = this.slogan;
    data['nomeprof'] = this.nomeprof;
    data['emailprof'] = this.emailprof;
    data['especialidade'] = this.especialidade;
    data['imgperfil'] = this.imgperfil;
    return data;
  }
}
