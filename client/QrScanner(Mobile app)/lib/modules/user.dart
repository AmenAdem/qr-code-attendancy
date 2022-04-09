 class User {
  String? cIN;
  String? nOM;
  String? pRENOM;
  String? fILIERE;
  String? tD;
  String? tP;
  String? eMAIL;
  String? pASSWORD;

  User(
      {this.cIN,
      this.nOM,
      this.pRENOM,
      this.fILIERE,
      this.tD,
      this.tP,
      this.eMAIL,
      this.pASSWORD});

  User.fromJson(Map<String, dynamic> json) {
    cIN = json['cin'];
    nOM = json['nom'];
    pRENOM = json['prenom'];
    fILIERE = json['filiere'];
    tD = json['td'];
    tP = json['tp'];
    eMAIL = json['email'];
    pASSWORD = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CIN'] = this.cIN;
    data['NOM'] = this.nOM;
    data['PRENOM'] = this.pRENOM;
    data['FILIERE'] = this.fILIERE;
    data['TD'] = this.tD;
    data['TP'] = this.tP;
    data['EMAIL'] = this.eMAIL;
    data['PASSWORD'] = this.pASSWORD;
    return data;
  }

  fromJson(Map<String, dynamic> userMap) {}
}