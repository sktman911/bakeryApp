import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCondition {
  static const int equal = 0,
      lower = 1,
      higher = 2,
      arrayContain = 3,
      isNull = 4;
  String? field;
  int? operator;
  dynamic value;
  FirebaseCondition({this.field, this.operator, this.value});
  Filter? convertToCondition() {
    switch (operator) {
      case equal:
        return Filter(field!, isEqualTo: value);
      case lower:
        return Filter(field!, isLessThan: value);
      case higher:
        return Filter(field!, isGreaterThan: value);
      case arrayContain:
        return Filter(field!, arrayContains: value);
      case isNull:
        return Filter(field!, isNull: true);
      default:
        return null;
    }
  }
}
