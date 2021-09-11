class ListOfClientsModel {
  String? nomecliente;
  String? idprof;
  String? idcliente;
  String? imglogo;
  String? slogan;

  ListOfClientsModel({
    this.nomecliente,
    this.idprof,
    this.idcliente,
    this.imglogo,
    this.slogan,
  });

  ListOfClientsModel.fromJson(Map<String, dynamic> json) {
    nomecliente = json['nomecliente'];
    idprof = json['idprof'];
    idcliente = json['idcliente'];
    imglogo = json['imglogo'];
    slogan = json['slogan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nomecliente'] = this.nomecliente;
    data['idprof'] = this.idprof;
    data['idcliente'] = this.idcliente;
    data['imglogo'] = this.imglogo;
    data['slogan'] = this.slogan;
    return data;
  }
}
