class Sales {
  final int skillindex;
  final String firstname;
  Sales(this.skillindex,this.firstname);

  Sales.fromMap(Map<String, dynamic> map)
      : assert(map['skillindex'] != null),
        assert(map['firstname'] != null),
        skillindex = map['skillindex'],
        firstname =map['firstname'];

  @override
  String toString() => "Record<$skillindex:$firstname>";

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