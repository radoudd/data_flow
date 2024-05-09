class StaffModel {
  ProfilePicture? profilePicture;
  String? id;
  User? user;
  String? brief;
  List<ResearchPapers>? researchPapers;
  List<SubjectHistory>? subjectHistory;
  int? v;

  StaffModel(
      {this.profilePicture,
      this.id,
      this.user,
      this.brief,
      this.researchPapers,
      this.subjectHistory,
      this.v});

  StaffModel.fromJson(Map<String, dynamic> json) {
    if (json["profilePicture"] is Map) {
      profilePicture = json["profilePicture"] == null
          ? null
          : ProfilePicture.fromJson(json["profilePicture"]);
    }
    if (json["_id"] is String) {
      id = json["_id"];
    }
    if (json["user"] is Map) {
      user = json["user"] == null ? null : User.fromJson(json["user"]);
    }
    if (json["brief"] is String) {
      brief = json["brief"];
    }
    if (json["researchPapers"] is List) {
      researchPapers = json["researchPapers"] == null
          ? null
          : (json["researchPapers"] as List)
              .map((e) => ResearchPapers.fromJson(e))
              .toList();
    }
    if (json["subjectHistory"] is List) {
      subjectHistory = json["subjectHistory"] == null
          ? null
          : (json["subjectHistory"] as List)
              .map((e) => SubjectHistory.fromJson(e))
              .toList();
    }
    if (json["__v"] is int) {
      v = json["__v"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (profilePicture != null) {
      data["profilePicture"] = profilePicture?.toJson();
    }
    data["_id"] = id;
    if (user != null) {
      data["user"] = user?.toJson();
    }
    data["brief"] = brief;
    if (researchPapers != null) {
      data["researchPapers"] = researchPapers?.map((e) => e.toJson()).toList();
    }
    if (subjectHistory != null) {
      data["subjectHistory"] = subjectHistory?.map((e) => e.toJson()).toList();
    }
    data["__v"] = v;
    return data;
  }
}

class SubjectHistory {
  dynamic subjectCode;
  String? subjectName;
  String? id;

  SubjectHistory({this.subjectCode, this.subjectName, this.id});

  SubjectHistory.fromJson(Map<String, dynamic> json) {
    subjectCode = json["subjectCode"];
    if (json["subjectName"] is String) {
      subjectName = json["subjectName"];
    }
    if (json["_id"] is String) {
      id = json["_id"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["subjectCode"] = subjectCode;
    data["subjectName"] = subjectName;
    data["_id"] = id;
    return data;
  }
}

class ResearchPapers {
  String? publicId;
  String? secureUrl;
  String? id;

  ResearchPapers({this.publicId, this.secureUrl, this.id});

  ResearchPapers.fromJson(Map<String, dynamic> json) {
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

class User {
  String? id;
  String? name;
  String? email;
  String? password;
  String? role;
  String? slug;
  String? createdAt;
  String? updatedAt;
  int? v;

  User(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.role,
      this.slug,
      this.createdAt,
      this.updatedAt,
      this.v});

  User.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }

    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["email"] is String) {
      email = json["email"];
    }
    if (json["password"] is String) {
      password = json["password"];
    }
    if (json["role"] is String) {
      role = json["role"];
    }
    if (json["slug"] is String) {
      slug = json["slug"];
    }
    if (json["createdAt"] is String) {
      createdAt = json["createdAt"];
    }
    if (json["updatedAt"] is String) {
      updatedAt = json["updatedAt"];
    }
    if (json["__v"] is int) {
      v = json["__v"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["name"] = name;
    data["email"] = email;
    data["password"] = password;
    data["role"] = role;
    data["slug"] = slug;
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    data["__v"] = v;
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
