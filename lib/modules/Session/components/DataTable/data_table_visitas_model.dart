class DataTableModel {
  String? paciente;
  String? dtAgenda;
  String? checking;
  String? checkout;
  String? tempo;
  String? infoCheckin;
  String? infoCheckout;

  DataTableModel(
      {this.paciente,
      this.dtAgenda,
      this.checking,
      this.checkout,
      this.tempo,
      this.infoCheckin,
      this.infoCheckout});

  DataTableModel.fromJson(Map<String, dynamic> json) {
    paciente = json['paciente'];
    dtAgenda = json['dt_agenda'];
    checking = json['checking'];
    checkout = json['checkout'];
    tempo = json['tempo'];
    infoCheckin = json['info_checkin'];
    infoCheckout = json['info_checkout'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paciente'] = this.paciente;
    data['dt_agenda'] = this.dtAgenda;
    data['checking'] = this.checking;
    data['checkout'] = this.checkout;
    data['tempo'] = this.tempo;
    data['info_checkin'] = this.infoCheckin;
    data['info_checkout'] = this.infoCheckout;
    return data;
  }
}
