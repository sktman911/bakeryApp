
class Order{
  int? OrderID;
  int? TotalQuantity;
  int? TotalPrice;
  String? Date;
  int? CustomerID;
  int? MethodID;
  int? StatusID;
  

  Order({
    this.OrderID,
    this.TotalQuantity,
    this.TotalPrice,
    this.Date,
    this.CustomerID,
    this.MethodID,
    this.StatusID,
  });

  Order.fromJson(Map<String, dynamic> json){
    OrderID = json['OrderID'];
    TotalQuantity = json['TotalQuantity'];
    TotalPrice = json['TotalPrice'];
    Date = json['Date'];
    CustomerID = json['CustomerID'];
    MethodID = json['MethodID'];
    StatusID = json['StatusID'];
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = <String,dynamic> {};
    data['OrderID'] = OrderID;
    data['TotalQuantity'] = TotalQuantity;
    data['TotalPrice'] = TotalPrice;
    data['Date'] = Date;
    data['CustomerID'] = CustomerID;
    data['MethodID'] = MethodID;
    data['StatusID'] = StatusID;
    return data;
  }
}