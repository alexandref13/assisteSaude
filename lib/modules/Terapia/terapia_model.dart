class TerapiaModel {
  String? idpftr;
  String? ctlaceito;
  String? idstatus;
  String? idpac;
  String? nomepac;

  TerapiaModel(
      {this.idpftr, this.ctlaceito, this.idstatus, this.idpac, this.nomepac});

  TerapiaModel.fromJson(Map<String, dynamic> json) {
    idpftr = json['idpftr'];
    ctlaceito = json['ctlaceito'];
    idstatus = json['idstatus'];
    idpac = json['idpac'];
    nomepac = json['nomepac'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idpftr'] = this.idpftr;
    data['ctlaceito'] = this.ctlaceito;
    data['idstatus'] = this.idstatus;
    data['idpac'] = this.idpac;
    data['nomepac'] = this.nomepac;
    return data;
  }
}
