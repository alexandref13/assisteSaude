class MapaEvento {
  int? confdata;
  String? paciente;
  String? logradouro;
  String? bairro;
  String? cidade;
  String? uf;
  String? ctlGps;
  String? idsecao;
  String? idpftr;
  String? obs;
  String? idStatus;
  String? dtAgenda;
  String? checkin;
  String? checkout;
  String? ctlCheckin;
  String? ctlCheckout;
  String? infoCheck;
  String? infoCheckout;
  String? latlng;
  String? idpac;
  String? hragenda;
  String? evolcao;

  MapaEvento({
    this.confdata,
    this.paciente,
    this.logradouro,
    this.bairro,
    this.cidade,
    this.uf,
    this.ctlGps,
    this.idsecao,
    this.idpftr,
    this.obs,
    this.idStatus,
    this.dtAgenda,
    this.checkin,
    this.checkout,
    this.ctlCheckin,
    this.ctlCheckout,
    this.infoCheck,
    this.infoCheckout,
    this.latlng,
    this.idpac,
    this.hragenda,
    this.evolcao,
  });

  MapaEvento.fromJson(Map<String, dynamic> json) {
    confdata = json['confdata'];
    paciente = json['paciente'];
    logradouro = json['logradouro'];
    bairro = json['bairro'];
    cidade = json['cidade'];
    uf = json['uf'];
    ctlGps = json['ctl_gps'];
    idsecao = json['idsecao'];
    idpftr = json['idpftr'];
    obs = json['obs'];
    idStatus = json['id_status'];
    dtAgenda = json['dt_agenda'];
    checkin = json['checkin'];
    checkout = json['checkout'];
    ctlCheckin = json['ctl_checkin'];
    ctlCheckout = json['ctl_checkout'];
    infoCheck = json['info_check'];
    infoCheckout = json['info_checkout'];
    latlng = json['latlng'];
    idpac = json['idpac'];
    hragenda = json['idpac'];
    evolcao = json['evolcao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['confdata'] = this.confdata;
    data['paciente'] = this.paciente;
    data['logradouro'] = this.logradouro;
    data['bairro'] = this.bairro;
    data['cidade'] = this.cidade;
    data['uf'] = this.uf;
    data['ctl_gps'] = this.ctlGps;
    data['idsecao'] = this.idsecao;
    data['idpftr'] = this.idpftr;
    data['obs'] = this.obs;
    data['id_status'] = this.idStatus;
    data['dt_agenda'] = this.dtAgenda;
    data['checkin'] = this.checkin;
    data['checkout'] = this.checkout;
    data['ctl_checkin'] = this.ctlCheckin;
    data['ctl_checkout'] = this.ctlCheckout;
    data['info_check'] = this.infoCheck;
    data['info_checkout'] = this.infoCheckout;
    data['latlng'] = this.latlng;
    data['idpac'] = this.idpac;
    data['hragenda'] = this.hragenda;
    data['evolcao'] = this.evolcao;
    return data;
  }
}
