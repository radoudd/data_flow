class FormModel {
  String? id;
  UserId? userId;
  String? subject;
  String? description;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? v;
  String? handledBy;

  FormModel(
      {this.id,
      this.userId,
      this.subject,
      this.description,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.v,
      this.handledBy});

  FormModel.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }
    if (json["userId"] is Map) {
      userId = json["userId"] == null ? null : UserId.fromJson(json["userId"]);
    }
    if (json["subject"] is String) {
      subject = json["subject"];
    }
    if (json["description"] is String) {
      description = json["description"];
    }
    if (json["status"] is String) {
      status = json["status"];
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
    if (json["handledBy"] is String) {
      handledBy = json["handledBy"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    if (userId != null) {
      data["userId"] = userId?.toJson();
    }
    data["subject"] = subject;
    data["description"] = description;
    data["status"] = status;
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    data["__v"] = v;
    data["handledBy"] = handledBy;
    return data;
  }
}

class UserId {
  String? id;
  String? userId;
  String? name;
  String? email;
  String? password;
  String? role;
  String? slug;
  String? createdAt;
  String? updatedAt;
  int? v;

  UserId(
      {this.id,
      this.userId,
      this.name,
      this.email,
      this.password,
      this.role,
      this.slug,
      this.createdAt,
      this.updatedAt,
      this.v});

  UserId.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }
    if (json["id"] is String) {
      userId = json["id"];
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
    data["id"] = id;
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
