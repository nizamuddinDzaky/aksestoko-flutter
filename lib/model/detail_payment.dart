class DetailPayment {
  int totalPembayaran;
  int jumlahYangHarusDibayar;
  List<ListPembayaran> listPembayaran;

  DetailPayment(
      {this.totalPembayaran, this.jumlahYangHarusDibayar, this.listPembayaran});

  DetailPayment.fromJson(Map<String, dynamic> json) {
    totalPembayaran = json['total_pembayaran'];
    jumlahYangHarusDibayar = json['jumlah_yang_harus_dibayar'];
    if (json['list_pembayaran'] is List) {
      listPembayaran = new List<ListPembayaran>();
      json['list_pembayaran']?.forEach((v) {
        listPembayaran.add(new ListPembayaran.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_pembayaran'] = this.totalPembayaran;
    data['jumlah_yang_harus_dibayar'] = this.jumlahYangHarusDibayar;
    if (this.listPembayaran != null) {
      data['list_pembayaran'] =
          this.listPembayaran.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListPembayaran {
  int no;
  String tanggalUnggah;
  int nominal;
  String status;
  String labelStatus;
  String foto;

  ListPembayaran(
      {this.no,
        this.tanggalUnggah,
        this.nominal,
        this.status,
        this.labelStatus,
        this.foto});

  ListPembayaran.fromJson(Map<String, dynamic> json) {
    no = json['no'];
    tanggalUnggah = json['tanggal_unggah'];
    nominal = json['nominal'];
    status = json['status'];
    labelStatus = json['label_status'];
    foto = json['foto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no'] = this.no;
    data['tanggal_unggah'] = this.tanggalUnggah;
    data['nominal'] = this.nominal;
    data['status'] = this.status;
    data['label_status'] = this.labelStatus;
    data['foto'] = this.foto;
    return data;
  }
}