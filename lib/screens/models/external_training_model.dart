class ExternalTrainingModel {
  TrainingPic? trainingPic;
  String? id;
  String? title;
  String? description;
  String? link;
  String? startsFrom;
  String? endsAt;
  int? v;

  ExternalTrainingModel(
      {this.trainingPic,
      this.id,
      this.title,
      this.description,
      this.link,
      this.startsFrom,
      this.endsAt,
      this.v});

  ExternalTrainingModel.fromJson(Map<String, dynamic> json) {
    if (json["trainingPic"] is Map) {
      trainingPic = json["trainingPic"] == null
          ? null
          : TrainingPic.fromJson(json["trainingPic"]);
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
    if (json["startsFrom"] is String) {
      startsFrom = json["startsFrom"];
    }
    if (json["endsAt"] is String) {
      endsAt = json["endsAt"];
    }
    if (json["__v"] is int) {
      v = json["__v"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (trainingPic != null) {
      data["trainingPic"] = trainingPic?.toJson();
    }
    data["_id"] = id;
    data["title"] = title;
    data["description"] = description;
    data["link"] = link;
    data["startsFrom"] = startsFrom;
    data["endsAt"] = endsAt;
    data["__v"] = v;
    return data;
  }
}

class TrainingPic {
  String? publicId;
  String? secureUrl;

  TrainingPic({this.publicId, this.secureUrl});

  TrainingPic.fromJson(Map<String, dynamic> json) {
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
