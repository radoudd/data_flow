class SuccessStoryModel {
  MainPicture? mainPicture;
  String? id;
  String? title;
  String? description;
  List<AdditionalPictures>? additionalPictures;
  List<TeamMembers>? teamMembers;
  int? v;

  SuccessStoryModel(
      {this.mainPicture,
      this.id,
      this.title,
      this.description,
      this.additionalPictures,
      this.teamMembers,
      this.v});

  SuccessStoryModel.fromJson(Map<String, dynamic> json) {
    if (json["mainPicture"] is Map) {
      mainPicture = json["mainPicture"] == null
          ? null
          : MainPicture.fromJson(json["mainPicture"]);
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
    if (json["additionalPictures"] is List) {
      additionalPictures = json["additionalPictures"] == null
          ? null
          : (json["additionalPictures"] as List)
              .map((e) => AdditionalPictures.fromJson(e))
              .toList();
    }
    if (json["teamMembers"] is List) {
      teamMembers = json["teamMembers"] == null
          ? null
          : (json["teamMembers"] as List)
              .map((e) => TeamMembers.fromJson(e))
              .toList();
    }
    if (json["__v"] is int) {
      v = json["__v"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (mainPicture != null) {
      data["mainPicture"] = mainPicture?.toJson();
    }
    data["_id"] = id;
    data["title"] = title;
    data["description"] = description;
    if (additionalPictures != null) {
      data["additionalPictures"] =
          additionalPictures?.map((e) => e.toJson()).toList();
    }
    if (teamMembers != null) {
      data["teamMembers"] = teamMembers?.map((e) => e.toJson()).toList();
    }
    data["__v"] = v;
    return data;
  }
}

class TeamMembers {
  Picture? picture;
  String? name;
  String? id;

  TeamMembers({this.picture, this.name, this.id});

  TeamMembers.fromJson(Map<String, dynamic> json) {
    if (json["picture"] is Map) {
      picture =
          json["picture"] == null ? null : Picture.fromJson(json["picture"]);
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["_id"] is String) {
      id = json["_id"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (picture != null) {
      data["picture"] = picture?.toJson();
    }
    data["name"] = name;
    data["_id"] = id;
    return data;
  }
}

class Picture {
  String? publicId;
  String? secureUrl;

  Picture({this.publicId, this.secureUrl});

  Picture.fromJson(Map<String, dynamic> json) {
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

class AdditionalPictures {
  String? publicId;
  String? secureUrl;
  String? id;

  AdditionalPictures({this.publicId, this.secureUrl, this.id});

  AdditionalPictures.fromJson(Map<String, dynamic> json) {
    if (json["public_id"] is String) {
      publicId = json["public_id"];
    }
    if (json["secure_url"] is String) {
      secureUrl = json["secure_url"];
    }
    if (json["_id"] is String) {
      id = json["_id"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["public_id"] = publicId;
    data["secure_url"] = secureUrl;
    data["_id"] = id;
    return data;
  }
}

class MainPicture {
  String? publicId;
  String? secureUrl;

  MainPicture({this.publicId, this.secureUrl});

  MainPicture.fromJson(Map<String, dynamic> json) {
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
