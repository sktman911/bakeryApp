import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/components/Checkout/CheckoutItems.dart';
import 'package:demo_app/conf/const.dart';
import 'package:demo_app/data/model/cart.dart';
import 'package:demo_app/data/provider/cartProvider.dart';
import 'package:demo_app/firebase/model/customer_model.dart';
import 'package:demo_app/firebase/model/firebase_operator.dart';
import 'package:demo_app/firebase/model/order_model.dart';
import 'package:demo_app/firebase/model/product_model.dart';
import 'package:demo_app/firebase/model/voucher_model.dart';
import 'package:demo_app/main_page.dart';
import 'package:demo_app/pages/delivery_page.dart';
import 'package:demo_app/pages/home_page.dart';
import 'package:demo_app/pages/order_page.dart';
import 'package:demo_app/pages/voucher_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vnpay_flutter/vnpay_flutter.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  CartProvider cartProvider = CartProvider();
  List<VoucherModel> voucherLst = [];
  VoucherModel? selectedVoucher;
  late String paymentUrl;
  String responseCode = '';
  TextEditingController addressController = TextEditingController();

  List<CartItem> cartList = [];
  double subTotal = 0;
  double shipFee = 30000;
  double preDiscount = 0, sufDiscount = 0;
  int voucherPrice = 0;

  void loadCartItems() async {
    final cart = await cartProvider.getCart();
    setState(() {
      cartList = cart;
    });
  }

  void loadSubTotal() async {
    final subTotal = await cartProvider.getTotalPrice();
    setState(() {
      this.subTotal = subTotal;
    });
  }

  setNewVoucher(VoucherModel newVoucher) {
    setState(() {
      selectedVoucher = newVoucher;
      voucherPrice = newVoucher.voucherValue!;
    });
  }

  Future<List<VoucherModel>> loadVouchers() async {
    voucherLst = await VoucherModel().getListDataWhereAnd(
        VoucherModel().collection,
        () => VoucherModel(),
        FirebaseCondition(
            field: 'quantity', operator: FirebaseCondition.higher, value: 0),
        FirebaseCondition(
            field: 'expire',
            operator: FirebaseCondition.higher,
            value: Timestamp.now()));
    voucherLst.removeWhere((element) => element.required! > subTotal);
    voucherLst.sort(
      (a, b) => b.voucherValue!.compareTo(a.voucherValue!),
    );

    return voucherLst;
  }

  Future<void> setAddress() async {
    final id = FirebaseAuth.instance.currentUser!.uid;
    CustomerModel customerModel =
        await CustomerModel().getDataById(() => CustomerModel(), id);

    addressController.text = customerModel.customerAddress ?? '';
  }

  Future<void> setSelectedVoucher() async {
    List<VoucherModel> voucherList = await loadVouchers();
    if (voucherList.isNotEmpty) {
      setState(() {
        selectedVoucher = voucherList[0];
      });
      if (selectedVoucher!.voucherValue != null) {
        setState(() {
          voucherPrice = selectedVoucher!.voucherValue!;
          sufDiscount = subTotal + shipFee - voucherPrice;
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCartItems();
    loadSubTotal();

    setSelectedVoucher();
    setAddress();
    // setPrice();
    paymentUrl = VNPAYFlutter.instance.generatePaymentUrl(
      url:
          'https://sandbox.vnpayment.vn/paymentv2/vpcpay.html', //vnpay url, default is https://sandbox.vnpayment.vn/paymentv2/vpcpay.html
      version: '2.0.1', //version of VNPAY, default is 2.0.1
      tmnCode: 'G421CTS3', //vnpay tmn code, get from vnpay
      txnRef: DateTime.now()
          .millisecondsSinceEpoch
          .toString(), //ref code, default is timestamp
      orderInfo: 'Pay 30.000 VND', //order info, default is Pay Order
      amount: sufDiscount, //amount
      returnUrl:
          'https://abc.com/return', //https://sandbox.vnpayment.vn/apis/docs/huong-dan-tich-hop/#code-returnurl
      ipAdress: '192.168.10.10', //Your IP address
      vnpayHashKey:
          'QBEBZUMOAJNSGCUPTMGQEHBTFRGJREOI', //vnpay hash key, get from vnpay
      vnPayHashType: VNPayHashType
          .HMACSHA512, //hash type. Default is HmacSHA512, you can chang it in: https://sandbox.vnpayment.vn/merchantv2
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            // checkout appbar
            AppBar(
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: customOrange,
                ),
              ),
              title: const Text(
                'Checkout',
                style: TextStyle(
                    fontSize: 28,
                    color: customOrange,
                    fontWeight: FontWeight.w500),
              ),
              centerTitle: true,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Delivery Address',
                        style: TextStyle(
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DeliveryPage(
                                          addressController: addressController,
                                        )));
                          },
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(customOrange)),
                          child: const Text(
                            'Choose address',
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: TextField(
                      controller: addressController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        label: const Text('My Address'),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              BorderSide(color: Colors.grey.shade500, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.shade800, width: 2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 12,
            ),

            Container(
              height: 15,
              decoration: BoxDecoration(
                  border: const Border(
                      top: BorderSide(width: 1, color: Colors.grey)),
                  color: Colors.grey.shade300.withOpacity(.7)),
            ),

            // checkout items
            checkoutItems(cartList),

            const Divider(),

            // order bill
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Total Bill',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(width: 1, color: customOrange)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Subtotal',
                            ),
                            Text(
                                '${NumberFormat('###,###.###').format(subTotal)} VNĐ')
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Delivery fee',
                            ),
                            Text(
                                '${NumberFormat('###,###.###').format(shipFee)} VNĐ')
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Discount',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: customOrange),
                            ),
                            Text(
                              '- ${NumberFormat('###,###.###').format(voucherPrice)} VNĐ',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: customOrange),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total price',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Row(
                                children: [
                                  if (sufDiscount != 0)
                                    Text(
                                      '${NumberFormat('###,###.###').format(subTotal + shipFee)} VNĐ',
                                      style: const TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: 16,
                                      ),
                                    ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    '${NumberFormat('###,###.###').format(subTotal + shipFee - voucherPrice)} VNĐ',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),

                  // voucher seleted
                  FutureBuilder(
                      future: loadVouchers(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: customWhite,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        voucherLst.isNotEmpty
                                            ? selectedVoucher!.voucherName!
                                            : 'Choose voucher',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        voucherLst.isNotEmpty
                                            ? 'Applied the best discount'
                                            : '',
                                      )
                                    ],
                                  ),
                                  Icon(
                                    voucherLst.isNotEmpty
                                        ? Icons.check_circle
                                        : Icons.cancel,
                                    color: customOrange,
                                    size: 24,
                                  )
                                ],
                              ),
                              const Divider(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('More voucher'),
                                  InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    VoucherPage(
                                                      voucherModel:
                                                          selectedVoucher ??
                                                              VoucherModel(),
                                                      setNewVoucher:
                                                          setNewVoucher,
                                                      voucherPrice:
                                                          voucherPrice,
                                                    )));
                                      },
                                      child: const Icon(Icons.arrow_forward))
                                ],
                              )
                            ],
                          ),
                        );
                      }),
                  // order discount
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        clipBehavior: Clip.antiAlias,
        height: 110,
        decoration: BoxDecoration(
            boxShadow: const [BoxShadow(color: Colors.white)],
            border: Border(
                top: BorderSide(width: 5, color: Colors.grey.withOpacity(.1)))),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.payments,
                        color: Colors.green,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text('Cash'),
                    ],
                  ),
                  Icon(Icons.more_horiz)
                ],
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            SizedBox(
              width: 320,
              child: ElevatedButton(
                  onPressed: () async {
                    if (addressController.text.isEmpty) {
                      return;
                    }
                    OrderModel orderModel = OrderModel();
                    List<Map<String, dynamic>> orderProduct =
                        List.empty(growable: true);
                    int qty = 0;
                    for (CartItem item in cartList) {
                      qty += item.quantity;
                      final doc = FirebaseFirestore.instance
                          .collection("Products")
                          .doc(item.productId);
                      // update product in order
                      ProductModel product = await ProductModel()
                          .getDataById(() => ProductModel(), item.productId);
                      num removeItem = product.quantity! - item.quantity;
                      ProductModel(
                              name: product.name,
                              price: product.price,
                              category: product.category,
                              bannerImage: product.bannerImage,
                              description: product.description,
                              quantity: removeItem)
                          .update(item.productId);

                      orderProduct
                          .add({'product': doc, 'quantity': item.quantity});
   
                      cartProvider.clearCart();
                    }
                    orderModel.items = orderProduct;
                    orderModel.orderAddress = addressController.text;
                    orderModel.orderedDate = Timestamp.now();
                    orderModel.totalPrice =
                        (subTotal + shipFee - voucherPrice).round();
                    orderModel.totalQuantity = qty;
                    String uid = FirebaseAuth.instance.currentUser!.uid;
                    orderModel.username = FirebaseFirestore.instance
                        .collection("Customers")
                        .doc(uid);
                    if (selectedVoucher == null) {
                      orderModel.voucher = null;
                    } else {
                      orderModel.voucher = FirebaseFirestore.instance
                          .collection("Vouchers")
                          .doc(selectedVoucher!.id);

                      VoucherModel voucherModel = await VoucherModel()
                          .getDataById(
                              () => VoucherModel(), selectedVoucher!.id!);
                      await VoucherModel(
                              expire: voucherModel.expire,
                              required: voucherModel.required,
                              quantity: voucherModel.quantity! - 1,
                              description: voucherModel.description,
                              voucherName: voucherModel.voucherName,
                              voucherValue: voucherModel.voucherValue)
                          .update(selectedVoucher!.id!);
                    }
                    // orderModel.voucher = (selectedVoucher == null)
                    //     ? null
                    //     : FirebaseFirestore.instance
                    //         .collection("Vouchers")
                    //         .doc(selectedVoucher!.id);
                    String purchase = "9sv5OtBoR7JRceHUC9DR";
                    String status = "G06OcF3ToNDIkNKDycUq";
                    orderModel.purchaseMethod = FirebaseFirestore.instance
                        .collection("PaymentMethods")
                        .doc(purchase);
                    orderModel.purchaseStatus = FirebaseFirestore.instance
                        .collection("PaymentStatus")
                        .doc(status);
                    await orderModel.add("Orders");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SuccessScreen(
                          image: successIcon,
                          title: 'Đặt hàng thành công',
                          subTitle: 'Thanh toán khi nhận hàng',
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(builder: (context) {
                              return const MainPage();
                            }), (route) => false);
                          });
                    }));

                    // VNPAYFlutter.instance.show(
                    //   paymentUrl: paymentUrl,
                    //   onPaymentSuccess: (params) {
                    //     setState(() {
                    //       responseCode = params['vnp_ResponseCode'];
                    //     });
                    //   },
                    //   onPaymentError: (params) {
                    //     setState(() {
                    //       responseCode = 'Error';
                    //     });
                    //   },
                    // );
                  },
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(customOrange)),
                  child: const Text(
                    'Order',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  const SuccessScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle,
      required this.onPressed});

  final String image, title, subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 56, bottom: 24, left: 24, right: 24),
            child: Column(
              children: [
                //image
                Image(
                  image: AssetImage(image),
                  width: MediaQuery.of(context).size.width * 0.6,
                ),
                const SizedBox(height: 32),

                //title va subtitle
                Text(title,
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center),
                const SizedBox(height: 16),
                Text(subTitle,
                    style: Theme.of(context).textTheme.labelMedium,
                    textAlign: TextAlign.center),
                const SizedBox(height: 32),

                //buttons
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: onPressed,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(customOrange),
                        side: MaterialStateProperty.all<BorderSide>(
                          const BorderSide(
                              color: Colors.white), // Màu của border
                        ),
                      ),
                      child: const Text(
                        "Xác nhận",
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
