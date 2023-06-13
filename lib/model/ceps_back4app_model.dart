class CEPSBack4AppModel {
  List<CEP> results = [];

  CEPSBack4AppModel(this.results);

  CEPSBack4AppModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <CEP>[];
      json['results'].forEach((v) {
        results.add(CEP.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = results.map((v) => v.toJson()).toList();
    return data;
  }

  @override
  String toString() {
    return 'CEPSBack4AppModel(results: $results)';
  }
}

class CEP {
  String objectId = "";
  String createdAt = "";
  String updatedAt = "";
  String cep = "";

  CEP(this.objectId, this.createdAt, this.updatedAt, this.cep);

  CEP.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    cep = json['cep'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['cep'] = cep;
    return data;
  }
}
