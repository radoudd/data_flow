class CompetitionsModel {
  CompetitionPic? competitionPic;
  String? id;
  String? title;
  String? description;
  String? link;
  int? v;

  CompetitionsModel(
      {this.competitionPic,
      this.id,
      this.title,
      this.description,
      this.link,
      this.v});

  CompetitionsModel.fromJson(Map<String, dynamic> json) {
    if (json["competitionPic"] is Map) {
      competitionPic = json["competitionPic"] == null
          ? null
          : CompetitionPic.fromJson(json["competitionPic"]);
    }
    if (json["_id"] is String) {
      id = json["_id"];
    }
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["description"] is String) {
      description = json["description"];
    }
    if (json["link"] is String) {
      link = json["link"];
    }
    if (json["__v"] is int) {
      v = json["__v"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (competitionPic != null) {
      data["competitionPic"] = competitionPic?.toJson();
    }
    data["_id"] = id;
    data["title"] = title;
    data["description"] = description;
    data["link"] = link;
    data["__v"] = v;
    return data;
  }
}

class CompetitionPic {
  String? publicId;
  String? secureUrl;

  CompetitionPic({this.publicId, this.secureUrl});

  CompetitionPic.fromJson(Map<String, dynamic> json) {
    if (json["public_id"] is String) {
      publicId = json["public_id"];
    }
    if (json["secure_url"] is String) {
      secureUrl = json["secure_url"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["public_id"] = publicId;
    data["secure_url"] = secureUrl;
    return data;
  }
}
