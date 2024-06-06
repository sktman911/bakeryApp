
class Customer{
  int? CustomerID;
  String? CustomerName;
  String? CustomerPhone;
  String? CustomerAddress;
  String? CustomerUserName;
  String? CustomerPasswork;
  int? CustomerPoint;
  String? CustomerIsActive;
  int? RoleID;

  Customer({
    this.CustomerID,
    this.CustomerName,
    this.CustomerPhone,
    this.CustomerAddress,
    this.CustomerUserName,
    this.CustomerPasswork,
    this.CustomerPoint,
    this.CustomerIsActive,
    this.RoleID,
  });

  Customer.fromJson(Map<String, dynamic> json){
    CustomerID = json['CustomerID'];
    CustomerName = json['CustomerName'];
    CustomerPhone = json['CustomerPhone'];
    CustomerAddress = json['CustomerAddress'];
    CustomerUserName = json['CustomerUserName'];
    CustomerPasswork = json['CustomerPasswork'];
    CustomerPoint = json['CustomerPoint'];
    CustomerIsActive = json['CustomerIsActive'];
    RoleID = json['RoleID'];
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = <String,dynamic> {};
    data['CustomerID'] = CustomerID;
    data['CustomerName'] = CustomerName;
    data['CustomerPhone'] = CustomerPhone;
    data['CustomerAddress'] = CustomerAddress;
    data['CustomerUserName'] = CustomerUserName;
    data['CustomerPasswork'] = CustomerPasswork;
    data['CustomerPoint'] = CustomerPoint;
    data['CustomerIsActive'] = CustomerIsActive;
    data['RoleID'] = RoleID;
    return data;
  }
}