class Product{
  int? Product_ID;
  String? ProductName;
  int? Price;
  String? Image;
  int? Discount;
  int? Quantity;
  int? Category_ID;

  Product({
    this.Product_ID,
    this.ProductName,
    this.Price,
    this.Image,
    this.Quantity,
    this.Category_ID,
  });

  Product.fromJson(Map<String, dynamic> json){
    Product_ID = json['Product_ID'];
    ProductName = json['ProductName'];
    Price = json['Price'];
    Image = json['Image'];
    Discount = json['Discount'];
    Quantity = json['Quantity'];
    Category_ID = json['Category_ID'];
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = <String,dynamic> {};
    data['Product_ID'] = Product_ID;
    data['ProductName'] = ProductName;
    data['Price'] = Price;
    data['Image'] = Image;
    data['Discount'] = Discount;
    data['Quantity'] = Quantity;
    data['Category_ID'] = Category_ID;
    return data;
  }
}