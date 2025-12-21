// To parse this JSON data, do
//
//     final reviews = reviewsFromJson(jsonString);

import 'dart:convert';

Reviews reviewsFromJson(String str) => Reviews.fromJson(json.decode(str));

String reviewsToJson(Reviews data) => json.encode(data.toJson());

class Reviews {
  final String? status;
  final List<Rating>? ratings;
  final Pagination? pagination;
  final String? message;

  Reviews({
    this.status,
    this.ratings,
    this.pagination,
    this.message,
  });

  Reviews copyWith({
    String? status,
    List<Rating>? ratings,
    Pagination? pagination,
    String? message,
  }) =>
      Reviews(
        status: status ?? this.status,
        ratings: ratings ?? this.ratings,
        pagination: pagination ?? this.pagination,
        message: message ?? this.message,
      );

  factory Reviews.fromJson(Map<String, dynamic> json) => Reviews(
    status: json["status"],
    ratings: json["ratings"] == null ? [] : List<Rating>.from(json["ratings"]!.map((x) => Rating.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "ratings": ratings == null ? [] : List<dynamic>.from(ratings!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
    "message": message,
  };
}

class Pagination {
  final int? currentPage;
  final int? perPage;
  final int? total;
  final int? lastPage;
  final dynamic nextPageUrl;
  final dynamic prevPageUrl;

  Pagination({
    this.currentPage,
    this.perPage,
    this.total,
    this.lastPage,
    this.nextPageUrl,
    this.prevPageUrl,
  });

  Pagination copyWith({
    int? currentPage,
    int? perPage,
    int? total,
    int? lastPage,
    dynamic nextPageUrl,
    dynamic prevPageUrl,
  }) =>
      Pagination(
        currentPage: currentPage ?? this.currentPage,
        perPage: perPage ?? this.perPage,
        total: total ?? this.total,
        lastPage: lastPage ?? this.lastPage,
        nextPageUrl: nextPageUrl ?? this.nextPageUrl,
        prevPageUrl: prevPageUrl ?? this.prevPageUrl,
      );

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    currentPage: json["current_page"],
    perPage: json["per_page"],
    total: json["total"],
    lastPage: json["last_page"],
    nextPageUrl: json["next_page_url"],
    prevPageUrl: json["prev_page_url"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "per_page": perPage,
    "total": total,
    "last_page": lastPage,
    "next_page_url": nextPageUrl,
    "prev_page_url": prevPageUrl,
  };
}

class Rating {
  final int? id;
  final String? ratedById;
  final String? ratedUserId;
  final String? stars;
  final String? comment;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Rater? rater;

  Rating({
    this.id,
    this.ratedById,
    this.ratedUserId,
    this.stars,
    this.comment,
    this.createdAt,
    this.updatedAt,
    this.rater,
  });

  Rating copyWith({
    int? id,
    String? ratedById,
    String? ratedUserId,
    String? stars,
    String? comment,
    DateTime? createdAt,
    DateTime? updatedAt,
    Rater? rater,
  }) =>
      Rating(
        id: id ?? this.id,
        ratedById: ratedById ?? this.ratedById,
        ratedUserId: ratedUserId ?? this.ratedUserId,
        stars: stars ?? this.stars,
        comment: comment ?? this.comment,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        rater: rater ?? this.rater,
      );

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    id: json["id"],
    ratedById: json["rated_by_id"],
    ratedUserId: json["rated_user_id"],
    stars: json["stars"],
    comment: json["comment"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    rater: json["rater"] == null ? null : Rater.fromJson(json["rater"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rated_by_id": ratedById,
    "rated_user_id": ratedUserId,
    "stars": stars,
    "comment": comment,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "rater": rater?.toJson(),
  };
}

class Rater {
  final int? id;
  final String? name;
  final String? userStatus;
  final String? email;
  final String? isVerified;
  final String? isAdmin;
  final String? status;
  final String? slug;
  final String? categoryId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Profile? profile;

  Rater({
    this.id,
    this.name,
    this.userStatus,
    this.email,
    this.isVerified,
    this.isAdmin,
    this.status,
    this.slug,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
    this.profile,
  });

  Rater copyWith({
    int? id,
    String? name,
    String? userStatus,
    String? email,
    String? isVerified,
    String? isAdmin,
    String? status,
    String? slug,
    String? categoryId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Profile? profile,
  }) =>
      Rater(
        id: id ?? this.id,
        name: name ?? this.name,
        userStatus: userStatus ?? this.userStatus,
        email: email ?? this.email,
        isVerified: isVerified ?? this.isVerified,
        isAdmin: isAdmin ?? this.isAdmin,
        status: status ?? this.status,
        slug: slug ?? this.slug,
        categoryId: categoryId ?? this.categoryId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        profile: profile ?? this.profile,
      );

  factory Rater.fromJson(Map<String, dynamic> json) => Rater(
    id: json["id"],
    name: json["name"],
    userStatus: json["user_status"],
    email: json["email"],
    isVerified: json["is_verified"],
    isAdmin: json["is_admin"],
    status: json["status"],
    slug: json["slug"],
    categoryId: json["category_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    profile: json["profile"] == null ? null : Profile.fromJson(json["profile"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "user_status": userStatus,
    "email": email,
    "is_verified": isVerified,
    "is_admin": isAdmin,
    "status": status,
    "slug": slug,
    "category_id": categoryId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "profile": profile?.toJson(),
  };
}

class Profile {
  final int? id;
  final String? avatar;
  final dynamic text;
  final String? address;
  final dynamic cpf;
  final String? cnpj;
  final dynamic phone;
  final String? zipCode;
  final String? userId;
  final String? latitude;
  final String? longitude;
  final String? city;
  final String? state;
  final String? corporateName;
  final String? legalRepresentativeName;
  final String? tradeName;
  final String? motherName;
  final DateTime? dateOfBirth;
  final String? stateRegistration;
  final String? cnpjDocument;
  final String? identificanDriverLicense;
  final dynamic username;
  final String? isAvailable;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Profile({
    this.id,
    this.avatar,
    this.text,
    this.address,
    this.cpf,
    this.cnpj,
    this.phone,
    this.zipCode,
    this.userId,
    this.latitude,
    this.longitude,
    this.city,
    this.state,
    this.corporateName,
    this.legalRepresentativeName,
    this.tradeName,
    this.motherName,
    this.dateOfBirth,
    this.stateRegistration,
    this.cnpjDocument,
    this.identificanDriverLicense,
    this.username,
    this.isAvailable,
    this.createdAt,
    this.updatedAt,
  });

  Profile copyWith({
    int? id,
    String? avatar,
    dynamic text,
    String? address,
    dynamic cpf,
    String? cnpj,
    dynamic phone,
    String? zipCode,
    String? userId,
    String? latitude,
    String? longitude,
    String? city,
    String? state,
    String? corporateName,
    String? legalRepresentativeName,
    String? tradeName,
    String? motherName,
    DateTime? dateOfBirth,
    String? stateRegistration,
    String? cnpjDocument,
    String? identificanDriverLicense,
    dynamic username,
    String? isAvailable,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Profile(
        id: id ?? this.id,
        avatar: avatar ?? this.avatar,
        text: text ?? this.text,
        address: address ?? this.address,
        cpf: cpf ?? this.cpf,
        cnpj: cnpj ?? this.cnpj,
        phone: phone ?? this.phone,
        zipCode: zipCode ?? this.zipCode,
        userId: userId ?? this.userId,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        city: city ?? this.city,
        state: state ?? this.state,
        corporateName: corporateName ?? this.corporateName,
        legalRepresentativeName: legalRepresentativeName ?? this.legalRepresentativeName,
        tradeName: tradeName ?? this.tradeName,
        motherName: motherName ?? this.motherName,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        stateRegistration: stateRegistration ?? this.stateRegistration,
        cnpjDocument: cnpjDocument ?? this.cnpjDocument,
        identificanDriverLicense: identificanDriverLicense ?? this.identificanDriverLicense,
        username: username ?? this.username,
        isAvailable: isAvailable ?? this.isAvailable,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["id"],
    avatar: json["avatar"],
    text: json["text"],
    address: json["address"],
    cpf: json["cpf"],
    cnpj: json["cnpj"],
    phone: json["phone"],
    zipCode: json["zip_code"],
    userId: json["user_id"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    city: json["city"],
    state: json["state"],
    corporateName: json["corporate_name"],
    legalRepresentativeName: json["legal_representative_name"],
    tradeName: json["trade_name"],
    motherName: json["mother_name"],
    dateOfBirth: json["date_of_birth"] == null ? null : DateTime.parse(json["date_of_birth"]),
    stateRegistration: json["state_registration"],
    cnpjDocument: json["cnpj_document"],
    identificanDriverLicense: json["identifican_driver_license"],
    username: json["username"],
    isAvailable: json["is_available"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "avatar": avatar,
    "text": text,
    "address": address,
    "cpf": cpf,
    "cnpj": cnpj,
    "phone": phone,
    "zip_code": zipCode,
    "user_id": userId,
    "latitude": latitude,
    "longitude": longitude,
    "city": city,
    "state": state,
    "corporate_name": corporateName,
    "legal_representative_name": legalRepresentativeName,
    "trade_name": tradeName,
    "mother_name": motherName,
    "date_of_birth": "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
    "state_registration": stateRegistration,
    "cnpj_document": cnpjDocument,
    "identifican_driver_license": identificanDriverLicense,
    "username": username,
    "is_available": isAvailable,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
