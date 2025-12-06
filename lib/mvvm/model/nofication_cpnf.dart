import 'package:queroobras_mobile/mvvm/const/export.dart';

class NotificationCpnf {
  final String? status;
  final String? message;
  final DataCpnf? data;

  NotificationCpnf({this.status, this.message, this.data});

  NotificationCpnf copyWith({String? status, String? message, DataCpnf? data}) =>
      NotificationCpnf(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory NotificationCpnf.fromRawJson(String str) =>
      NotificationCpnf.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationCpnf.fromJson(Map<String, dynamic> json) =>
      NotificationCpnf(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : DataCpnf.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class DataCpnf {
  final int? currentPage;
  final List<DatumCpnf>? datacpnf;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<LinkCpnf>? links;
  final dynamic nextPageUrl;
  final String? path;
  final int? perPage;
  final dynamic prevPageUrl;
  final int? to;
  final int? total;

  DataCpnf({
    this.currentPage,
    this.datacpnf,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  DataCpnf copyWith({
    int? currentPage,
    List<DatumCpnf>? datacpnf,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    List<LinkCpnf>? links,
    dynamic nextPageUrl,
    String? path,
    int? perPage,
    dynamic prevPageUrl,
    int? to,
    int? total,
  }) => DataCpnf(
    currentPage: currentPage ?? this.currentPage,
    datacpnf: datacpnf ?? this.datacpnf,
    firstPageUrl: firstPageUrl ?? this.firstPageUrl,
    from: from ?? this.from,
    lastPage: lastPage ?? this.lastPage,
    lastPageUrl: lastPageUrl ?? this.lastPageUrl,
    links: links ?? this.links,
    nextPageUrl: nextPageUrl ?? this.nextPageUrl,
    path: path ?? this.path,
    perPage: perPage ?? this.perPage,
    prevPageUrl: prevPageUrl ?? this.prevPageUrl,
    to: to ?? this.to,
    total: total ?? this.total,
  );

  factory DataCpnf.fromRawJson(String str) => DataCpnf.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataCpnf.fromJson(Map<String, dynamic> json) => DataCpnf(
    currentPage: json["current_page"],
    datacpnf: json["data"] == null
        ? []
        : List<DatumCpnf>.from(json["data"]!.map((x) => DatumCpnf.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: json["links"] == null
        ? []
        : List<LinkCpnf>.from(json["links"]!.map((x) => LinkCpnf.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": datacpnf == null
        ? []
        : List<dynamic>.from(datacpnf!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": links == null
        ? []
        : List<dynamic>.from(links!.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class DatumCpnf {
  final int? id;
  final String? userId;
  final String? serviceProviderId;
  final String? description;
  final String? address;
  final String? slug;
  final String? status;
  final String? customerAccepted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final User? user;
  final List<ImageCpnf>? images;
  final List<dynamic>? replies;

  DatumCpnf({
    this.id,
    this.userId,
    this.serviceProviderId,
    this.description,
    this.address,
    this.slug,
    this.status,
    this.customerAccepted,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.images,
    this.replies,
  });

  DatumCpnf copyWith({
    int? id,
    String? userId,
    String? serviceProviderId,
    String? description,
    String? address,
    String? slug,
    String? status,
    String? customerAccepted,
    DateTime? createdAt,
    DateTime? updatedAt,
    User? user,
    List<ImageCpnf>? images,
    List<dynamic>? replies,
  }) => DatumCpnf(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    serviceProviderId: serviceProviderId ?? this.serviceProviderId,
    description: description ?? this.description,
    address: address ?? this.address,
    slug: slug ?? this.slug,
    status: status ?? this.status,
    customerAccepted: customerAccepted ?? this.customerAccepted,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    user: user ?? this.user,
    images: images ?? this.images,
    replies: replies ?? this.replies,
  );

  factory DatumCpnf.fromRawJson(String str) => DatumCpnf.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DatumCpnf.fromJson(Map<String, dynamic> json) => DatumCpnf(
    id: json["id"],
    userId: json["user_id"],
    serviceProviderId: json["service_provider_id"],
    description: json["description"],
    address: json["address"],
    slug: json["slug"],
    status: json["status"],
    customerAccepted: json["customer_accepted"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    images: json["images"] == null
        ? []
        : List<ImageCpnf>.from(
            json["images"]!.map((x) => ImageCpnf.fromJson(x)),
          ),
    replies: json["replies"] == null
        ? []
        : List<dynamic>.from(json["replies"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "service_provider_id": serviceProviderId,
    "description": description,
    "address": address,
    "slug": slug,
    "status": status,
    "customer_accepted": customerAccepted,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "user": user?.toJson(),
    "images": images == null
        ? []
        : List<dynamic>.from(images!.map((x) => x.toJson())),
    "replies": replies == null
        ? []
        : List<dynamic>.from(replies!.map((x) => x)),
  };
}

class ImageCpnf {
  final int? id;
  final String? serviceRequestId;
  final String? imageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ImageCpnf({
    this.id,
    this.serviceRequestId,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  ImageCpnf copyWith({
    int? id,
    String? serviceRequestId,
    String? imageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ImageCpnf(
    id: id ?? this.id,
    serviceRequestId: serviceRequestId ?? this.serviceRequestId,
    imageUrl: imageUrl ?? this.imageUrl,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory ImageCpnf.fromRawJson(String str) =>
      ImageCpnf.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ImageCpnf.fromJson(Map<String, dynamic> json) => ImageCpnf(
    id: json["id"],
    serviceRequestId: json["service_request_id"],
    imageUrl: json["image_url"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "service_request_id": serviceRequestId,
    "image_url": imageUrl,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class User {
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

  User({
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
  });

  User copyWith({
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
  }) => User(
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
  );

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    userStatus: json["user_status"],
    email: json["email"],
    isVerified: json["is_verified"],
    isAdmin: json["is_admin"],
    status: json["status"],
    slug: json["slug"],
    categoryId: json["category_id"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
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
  };
}

class LinkCpnf {
  final String? url;
  final String? label;
  final int? page;
  final bool? active;

  LinkCpnf({this.url, this.label, this.page, this.active});

  LinkCpnf copyWith({String? url, String? label, int? page, bool? active}) => LinkCpnf(
    url: url ?? this.url,
    label: label ?? this.label,
    page: page ?? this.page,
    active: active ?? this.active,
  );

  factory LinkCpnf.fromRawJson(String str) => LinkCpnf.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LinkCpnf.fromJson(Map<String, dynamic> json) => LinkCpnf(
    url: json["url"],
    label: json["label"],
    page: json["page"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "page": page,
    "active": active,
  };
}
