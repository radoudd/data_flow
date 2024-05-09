class InternalTrainingModel {
  TrainingPicture? trainingPicture;
  String? id;
  String? title;
  String? description;
  List<String>? whatYouWillLearn;
  List<TeachingInstructor>? teachingInstructor;
  String? startsFrom;
  String? endsAt;
  int? v;

  InternalTrainingModel(
      {this.trainingPicture,
      this.id,
      this.title,
      this.description,
      this.whatYouWillLearn,
      this.teachingInstructor,
      this.startsFrom,
      this.endsAt,
      this.v});

  InternalTrainingModel.fromJson(Map<String, dynamic> json) {
    if (json["trainingPicture"] is Map) {
      trainingPicture = json["trainingPicture"] == null
          ? null
          : TrainingPicture.fromJson(json["trainingPicture"]);
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
    if (json["whatYouWillLearn"] is List) {
      whatYouWillLearn = json["whatYouWillLearn"] == null
          ? null
          : List<String>.from(json["whatYouWillLearn"]);
    }
    if (json["teachingInstructor"] is List) {
      teachingInstructor = json["teachingInstructor"] == null
          ? null
          : (json["teachingInstructor"] as List)
              .map((e) => TeachingInstructor.fromJson(e))
              .toList();
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
    if (trainingPicture != null) {
      data["trainingPicture"] = trainingPicture?.toJson();
    }
    data["_id"] = id;
    data["title"] = title;
    data["description"] = description;
    if (whatYouWillLearn != null) {
      data["whatYouWillLearn"] = whatYouWillLearn;
    }
    if (teachingInstructor != null) {
      data["teachingInstructor"] =
          teachingInstructor?.map((e) => e.toJson()).toList();
    }
    data["startsFrom"] = startsFrom;
    data["endsAt"] = endsAt;
    data["__v"] = v;
    return data;
  }
}

class TeachingInstructor {
  ProfilePicture? profilePicture;
  String? name;
  String? title;
  String? description;
  String? id;

  TeachingInstructor(
      {this.profilePicture, this.name, this.title, this.description, this.id});

  TeachingInstructor.fromJson(Map<String, dynamic> json) {
    if (json["profilePicture"] is Map) {
      profilePicture = json["profilePicture"] == null
          ? null
          : ProfilePicture.fromJson(json["profilePicture"]);
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["description"] is String) {
      description = json["description"];
    }
    if (json["_id"] is String) {
      id = json["_id"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (profilePicture != null) {
      data["profilePicture"] = profilePicture?.toJson();
    }
    data["name"] = name;
    data["title"] = title;
    data["description"] = description;
    data["_id"] = id;
    return data;
  }
}

class ProfilePicture {
  String? publicId;
  String? secureUrl;

  ProfilePicture({this.publicId, this.secureUrl});

  ProfilePicture.fromJson(Map<String, dynamic> json) {
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

class TrainingPicture {
  String? publicId;
  String? secureUrl;

  TrainingPicture({this.publicId, this.secureUrl});

  TrainingPicture.fromJson(Map<String, dynamic> json) {
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
