class UserModel {
  String? id;
  String? userID;
  String? name;
  String? email;
  String? password;
  String? role;
  String? slug;
  String? createdAt;
  String? updatedAt;
  int? v;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.role,
      this.slug,
      this.createdAt,
      this.updatedAt,
      this.v});

  UserModel.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }
    if (json["id"] is String) {
      userID = json["id"];
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
