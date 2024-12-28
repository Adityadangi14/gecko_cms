class CompanyModel {
  List<Compaines>? compaines;
  String? message;
  bool? success;

  CompanyModel({this.compaines, this.success, this.message});

  CompanyModel.fromJson(Map<String, dynamic> json) {
    if (json['compaines'] != null) {
      compaines = <Compaines>[];
      json['compaines'].forEach((v) {
        compaines!.add(Compaines.fromJson(v));
      });
    }
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (compaines != null) {
      data['compaines'] = compaines!.map((v) => v.toJson()).toList();
    }
    data['success'] = success;
    return data;
  }
}

class Compaines {
  String? company;
  String? companyLogo;
  int? id;

  Compaines({this.company, this.companyLogo, this.id});

  Compaines.fromJson(Map<String, dynamic> json) {
    company = json['company'];
    companyLogo = json['companyLogo'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['company'] = company;
    data['companyLogo'] = companyLogo;
    data['id'] = id;
    return data;
  }
}
