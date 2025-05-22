class AdTypeBen {
  AdTypeBen({
      this.senceOpen, 
      this.senceInt, 
      this.senceRv,});

  AdTypeBen.fromJson(dynamic json) {
    senceOpen = json['sence_open'];
    senceInt = json['sence_int'];
    senceRv = json['sence_rv'];
  }
  String? senceOpen;
  String? senceInt;
  String? senceRv;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sence_open'] = senceOpen;
    map['sence_int'] = senceInt;
    map['sence_rv'] = senceRv;
    return map;
  }

  @override
  String toString() {
    return 'AdTypeBen{senceOpen: $senceOpen, senceInt: $senceInt, senceRv: $senceRv}';
  }
}