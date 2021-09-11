class DataTableModel {
  String? cliente;
  String? checking;
  String? checkout;
  int? tempo;
  String? tempototal;
  int? gps;
  int? parcial;
  String? infoCheckin;
  String? infoCheckout;

  DataTableModel(
      {this.cliente,
      this.checking,
      this.checkout,
      this.tempo,
      this.tempototal,
      this.gps,
      this.parcial,
      this.infoCheckin,
      this.infoCheckout});

  DataTableModel.fromJson(Map<String, dynamic> json) {
    cliente = json['cliente'];
    checking = json['checking'];
    checkout = json['checkout'];
    tempo = json['tempo'];
    tempototal = json['tempototal'];
    gps = json['gps'];
    parcial = json['parcial'];
    infoCheckin = json['info_checkin'];
    infoCheckout = json['info_checkout'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cliente'] = this.cliente;
    data['checking'] = this.checking;
    data['checkout'] = this.checkout;
    data['tempo'] = this.tempo;
    data['tempototal'] = this.tempototal;
    data['gps'] = this.gps;
    data['parcial'] = this.parcial;
    data['info_checkin'] = this.infoCheckin;
    data['info_checkout'] = this.infoCheckout;
    return data;
  }
}
