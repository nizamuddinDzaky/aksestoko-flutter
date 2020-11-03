class PaymentModel {
  String uuid;
  BayarDitempat bayarDitempat;
  TempoDenganDistributor tempoDenganDistributor;
  BayarSebelumDikirim bayarSebelumDikirim;
  KreditPro kreditPro;

  PaymentModel(
      {this.uuid,
      this.bayarDitempat,
      this.tempoDenganDistributor,
      this.bayarSebelumDikirim,
      this.kreditPro});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    bayarDitempat = json['bayar_ditempat'] != null
        ? new BayarDitempat.fromJson(json['bayar_ditempat'])
        : null;
    tempoDenganDistributor = json['tempo_dengan_distributor'] != null
        ? new TempoDenganDistributor.fromJson(json['tempo_dengan_distributor'])
        : null;
    bayarSebelumDikirim = json['bayar_sebelum_dikirim'] != null
        ? new BayarSebelumDikirim.fromJson(json['bayar_sebelum_dikirim'])
        : null;
    kreditPro = json['kredit_pro'] != null
        ? new KreditPro.fromJson(json['kredit_pro'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    if (this.bayarDitempat != null) {
      data['bayar_ditempat'] = this.bayarDitempat.toJson();
    }
    if (this.tempoDenganDistributor != null) {
      data['tempo_dengan_distributor'] = this.tempoDenganDistributor.toJson();
    }
    if (this.bayarSebelumDikirim != null) {
      data['bayar_sebelum_dikirim'] = this.bayarSebelumDikirim.toJson();
    }
    if (this.kreditPro != null) {
      data['kredit_pro'] = this.kreditPro.toJson();
    }
    return data;
  }
}

class BayarDitempat {
  String logo;
  int total;
  Detail detail;

  BayarDitempat({this.logo, this.total, this.detail});

  BayarDitempat.fromJson(Map<String, dynamic> json) {
    logo = json['logo'];
    total = json['total'];
    detail =
        json['detail'] != null ? new Detail.fromJson(json['detail']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['logo'] = this.logo;
    data['total'] = this.total;
    if (this.detail != null) {
      data['detail'] = this.detail.toJson();
    }
    return data;
  }
}

class Detail {
  int harga;
  int charge;
  int disocunt;
  int total;
  int hargaTempo;
  String durasiPembayaran;
  int subtotal;
  String interestRate;
  int hargaInterestRate;

  Detail({
    this.harga,
    this.charge,
    this.disocunt,
    this.total,
    this.hargaTempo,
    this.durasiPembayaran,
    this.subtotal,
    this.interestRate,
    this.hargaInterestRate,
  });

  Detail.fromJson(Map<String, dynamic> json) {
    harga = json['harga'];
    charge = json['charge'];
    disocunt = json['disocunt'];
    total = json['total'];
    hargaTempo = json['harga_tempo'];
    durasiPembayaran = json['durasi_pembayaran'];
    subtotal = json['subtotal'];
    interestRate = json['interest_rate'];
    hargaInterestRate = json['harga_interest_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['harga'] = this.harga;
    data['charge'] = this.charge;
    data['disocunt'] = this.disocunt;
    data['total'] = this.total;
    data['harga_tempo'] = this.hargaTempo;
    data['durasi_pembayaran'] = this.durasiPembayaran;
    data['subtotal'] = this.subtotal;
    data['interest_rate'] = this.interestRate;
    data['harga_interest_rate'] = this.hargaInterestRate;
    return data;
  }
}

class TempoDenganDistributor {
  String logo;
  int total;
  List<ListBank> listBank;
  List<ListPaymentDurasi> listPaymentDurasi;
  Detail detail;

  TempoDenganDistributor(
      {this.logo,
      this.total,
      this.listBank,
      this.listPaymentDurasi,
      this.detail});

  TempoDenganDistributor.fromJson(Map<String, dynamic> json) {
    logo = json['logo'];
    total = json['total'];
    if (json['list_bank'] != null) {
      listBank = new List<ListBank>();
      json['list_bank'].forEach((v) {
        listBank.add(new ListBank.fromJson(v));
      });
    }
    if (json['list_payment_durasi'] != null) {
      listPaymentDurasi = new List<ListPaymentDurasi>();
      json['list_payment_durasi'].forEach((v) {
        listPaymentDurasi.add(new ListPaymentDurasi.fromJson(v));
      });
    }
    detail =
        json['detail'] != null ? new Detail.fromJson(json['detail']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['logo'] = this.logo;
    data['total'] = this.total;
    if (this.listBank != null) {
      data['list_bank'] = this.listBank.map((v) => v.toJson()).toList();
    }
    if (this.listPaymentDurasi != null) {
      data['list_payment_durasi'] =
          this.listPaymentDurasi.map((v) => v.toJson()).toList();
    }
    if (this.detail != null) {
      data['detail'] = this.detail.toJson();
    }
    return data;
  }
}

class ListBank {
  String noRek;
  String nama;
  String logoBank;
  String bankId;
  String bankName;

  ListBank({this.noRek, this.nama, this.logoBank, this.bankId, this.bankName});

  ListBank.fromJson(Map<String, dynamic> json) {
    noRek = json['no_rek'] ?? json['no_rekening'];
    nama = json['nama'];
    logoBank = json['logo_bank'];
    bankId = json['bank_id'] ?? json['id'];
    bankName = json['bank_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no_rek'] = this.noRek;
    data['nama'] = this.nama;
    data['logo_bank'] = this.logoBank;
    data['bank_id'] = this.bankId;
    data['bank_name'] = this.bankName;
    return data;
  }
}

class ListPaymentDurasi {
  String duration;
  String description;

  ListPaymentDurasi({this.duration, this.description});

  ListPaymentDurasi.fromJson(Map<String, dynamic> json) {
    duration = json['duration'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['duration'] = this.duration;
    data['description'] = this.description;
    return data;
  }

  @override
  String toString() {
    return '$duration HARI ($description)';
  }
}

class BayarSebelumDikirim {
  String logo;
  int total;
  List<ListBank> listBank;
  Detail detail;

  BayarSebelumDikirim({this.logo, this.total, this.listBank, this.detail});

  BayarSebelumDikirim.fromJson(Map<String, dynamic> json) {
    logo = json['logo'];
    total = json['total'];
    if (json['list_bank'] != null) {
      listBank = new List<ListBank>();
      json['list_bank'].forEach((v) {
        listBank.add(new ListBank.fromJson(v));
      });
    }
    detail =
        json['detail'] != null ? new Detail.fromJson(json['detail']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['logo'] = this.logo;
    data['total'] = this.total;
    if (this.listBank != null) {
      data['list_bank'] = this.listBank.map((v) => v.toJson()).toList();
    }
    if (this.detail != null) {
      data['detail'] = this.detail.toJson();
    }
    return data;
  }
}

class KreditPro {
  String logo;
  String total;
  List<Detail> detail;

  KreditPro({this.logo, this.total, this.detail});

  KreditPro.fromJson(Map<String, dynamic> json) {
    logo = json['logo'];
    total = json['total'];
    if (json['detail'] != null) {
      detail = new List<Detail>();
      json['detail'].forEach((v) {
        detail.add(new Detail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['logo'] = this.logo;
    data['total'] = this.total;
    if (this.detail != null) {
      data['detail'] = this.detail.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
