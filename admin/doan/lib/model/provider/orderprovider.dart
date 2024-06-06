import 'package:cloud_firestore/cloud_firestore.dart';

class OrderProvider{

  var db = FirebaseFirestore.instance;

  Future<void> updateOrder(String orderId, DocumentReference<Object> statusOrder ) async
  {
    try
    {
       var querySnapshot =
          await db.collection('Orders').doc(orderId);
      querySnapshot.update({
        'purchase_status': statusOrder,
      }).then((value) => print("DocumentSnapshot successfully updated!"),
          onError: (e) => print("Error updating document $e"));
    }
    catch(e)
    {
      print("Error update order: $e");
    }
  }

}