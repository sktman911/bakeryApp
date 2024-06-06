class Voucher {
  int? Voucher_ID;
  String? VoucherName;
  String? Expire;
  String? DateCreated;
  int? ValueVoucher;
  int? Quantity;

  Voucher(
      {this.Voucher_ID,
      this.VoucherName,
      this.Expire,
      this.DateCreated,
      this.ValueVoucher,
      this.Quantity});

  Voucher.fromJson(Map<String, dynamic> json) {
    Voucher_ID = json['Voucher_ID'];
    VoucherName = json['VoucherName'];
    Expire = json['Expire'];
    DateCreated = json['DateCreated'];
    ValueVoucher = json['ValueVoucher'];
    Quantity = json['Quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Voucher_ID'] = Voucher_ID;
    data['VoucherName'] = VoucherName;
    data['Expire'] = Expire;
    data['DateCreated'] = DateCreated;
    data['ValueVoucher'] = ValueVoucher;
    data['Quantity'] = Quantity;
    return data;
  }
}
