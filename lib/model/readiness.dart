class Readiness {
  final String firstname;
  final String readiness;
  Readiness(this.firstname, this.readiness);

  Readiness.fromMap(Map<String, dynamic> map)
      : assert(map['firstname'] != null),
        assert(map['readiness'] != null),
        firstname = map['firstname'],
        readiness = map['readiness'];

  @override
  String toString() => "Record<$readiness:$firstname>";

//  final int saleVal;
//  final String saleYear;
//  final String colorVal;
//  Sales(this.saleVal,this.saleYear,this.colorVal);
//
//  Sales.fromMap(Map<String, dynamic> map)
//      : assert(map['saleVal'] != null),
//        assert(map['saleYear'] != null),
//        assert(map['colorVal'] != null),
//        saleVal = map['saleVal'],
//        colorVal = map['colorVal'],
//        saleYear=map['saleYear'];
//
//  @override
//  String toString() => "Record<$saleVal:$saleYear:$colorVal>";
}
