import 'package:queroobras_mobile/mvvm/const/export.dart';
import 'dart:convert';

class NotificationCpn {
    final String? status;
    final String? message;
    final DataCpn? data;

    NotificationCpn({
        this.status,
        this.message,
        this.data,
    });

    NotificationCpn copyWith({
        String? status,
        String? message,
        DataCpn? data,
    }) => 
        NotificationCpn(
            status: status ?? this.status,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory NotificationCpn.fromRawJson(String str) => NotificationCpn.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory NotificationCpn.fromJson(Map<String, dynamic> json) => NotificationCpn(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : DataCpn.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class DataCpn {
    final int? currentPage;
    final List<DatumCpn>? data;
    final String? firstPageUrl;
    final int? from;
    final int? lastPage;
    final String? lastPageUrl;
    final List<LinkCpn>? links;
    final dynamic nextPageUrl;
    final String? path;
    final int? perPage;
    final dynamic prevPageUrl;
    final int? to;
    final int? total;

    DataCpn({
        this.currentPage,
        this.data,
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

    DataCpn copyWith({
        int? currentPage,
        List<DatumCpn>? data,
        String? firstPageUrl,
        int? from,
        int? lastPage,
        String? lastPageUrl,
        List<LinkCpn>? links,
        dynamic nextPageUrl,
        String? path,
        int? perPage,
        dynamic prevPageUrl,
        int? to,
        int? total,
    }) => 
        DataCpn(
            currentPage: currentPage ?? this.currentPage,
            data: data ?? this.data,
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

    factory DataCpn.fromRawJson(String str) => DataCpn.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DataCpn.fromJson(Map<String, dynamic> json) => DataCpn(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<DatumCpn>.from(json["data"]!.map((x) => DatumCpn.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null ? [] : List<LinkCpn>.from(json["links"]!.map((x) => LinkCpn.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
    };
}

class DatumCpn {
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
        final String? statusText;
    final Provider? provider;
    final List<ImageCpn>? images;
    final List<ReplyCpn>? replies;

    DatumCpn({
        this.id,
        this.userId,
        this.serviceProviderId,
        this.description,
        this.address,
        this.slug,
                this.statusText,

        this.status,
        this.customerAccepted,
        this.createdAt,
        this.updatedAt,
        this.provider,
        this.images,
        this.replies,
    });

    DatumCpn copyWith({
        int? id,
        String? userId,
        String? serviceProviderId,
        String? description,
        String? address,
        String? slug,
        String? status,
                String? statusText,

        String? customerAccepted,
        DateTime? createdAt,
        DateTime? updatedAt,
        Provider? provider,
        List<ImageCpn>? images,
        List<ReplyCpn>? replies,
    }) => 
        DatumCpn(
            id: id ?? this.id,
            userId: userId ?? this.userId,
            serviceProviderId: serviceProviderId ?? this.serviceProviderId,
            description: description ?? this.description,
            address: address ?? this.address,
            slug: slug ?? this.slug,
            status: status ?? this.status,
                        statusText: statusText ?? this.statusText,

            customerAccepted: customerAccepted ?? this.customerAccepted,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            provider: provider ?? this.provider,
            images: images ?? this.images,
            replies: replies ?? this.replies,
        );

    factory DatumCpn.fromRawJson(String str) => DatumCpn.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DatumCpn.fromJson(Map<String, dynamic> json) => DatumCpn(
        id: json["id"],
        userId: json["user_id"],
        serviceProviderId: json["service_provider_id"],
        description: json["description"],
        address: json["address"],
        slug: json["slug"],
        status: json["status"],
        customerAccepted: json["customer_accepted"],
                statusText: json["status_text"],

        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        provider: json["provider"] == null ? null : Provider.fromJson(json["provider"]),
        images: json["images"] == null ? [] : List<ImageCpn>.from(json["images"]!.map((x) => ImageCpn.fromJson(x))),
        replies: json["replies"] == null ? [] : List<ReplyCpn>.from(json["replies"]!.map((x) => ReplyCpn.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "service_provider_id": serviceProviderId,
        "description": description,
        "address": address,
        "slug": slug,
        "status": status,
                "status_text": statusText,

        "customer_accepted": customerAccepted,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "provider": provider?.toJson(),
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
        "replies": replies == null ? [] : List<dynamic>.from(replies!.map((x) => x.toJson())),
    };
}

class ImageCpn {
    final int? id;
    final String? serviceRequestId;
    final String? imageUrl;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    ImageCpn({
        this.id,
        this.serviceRequestId,
        this.imageUrl,
        this.createdAt,
        this.updatedAt,
    });

    ImageCpn copyWith({
        int? id,
        String? serviceRequestId,
        String? imageUrl,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        ImageCpn(
            id: id ?? this.id,
            serviceRequestId: serviceRequestId ?? this.serviceRequestId,
            imageUrl: imageUrl ?? this.imageUrl,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory ImageCpn.fromRawJson(String str) => ImageCpn.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ImageCpn.fromJson(Map<String, dynamic> json) => ImageCpn(
        id: json["id"],
        serviceRequestId: json["service_request_id"],
        imageUrl: json["image_url"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "service_request_id": serviceRequestId,
        "image_url": imageUrl,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class Provider {
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

    Provider({
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

    Provider copyWith({
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
    }) => 
        Provider(
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

    factory Provider.fromRawJson(String str) => Provider.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Provider.fromJson(Map<String, dynamic> json) => Provider(
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

class ReplyCpn {
    final int? id;
    final String? serviceRequestId;
    final String? amount;
    final String? note;
    final String? paymentLink;
    final String? slug;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    ReplyCpn({
        this.id,
        this.serviceRequestId,
        this.paymentLink,
        this.amount,
        this.note,
        this.slug,
        this.createdAt,
        this.updatedAt,
    });

    ReplyCpn copyWith({
        int? id,
        String? serviceRequestId,
        String? paymentLink,
        String? amount,
        String? note,
        String? slug,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        ReplyCpn(
            id: id ?? this.id,
            serviceRequestId: serviceRequestId ?? this.serviceRequestId,
            amount: amount ?? this.amount,
            paymentLink: paymentLink ?? this.paymentLink,
            note: note ?? this.note,
            slug: slug ?? this.slug,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory ReplyCpn.fromRawJson(String str) => ReplyCpn.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ReplyCpn.fromJson(Map<String, dynamic> json) => ReplyCpn(
        id: json["id"],
        serviceRequestId: json["service_request_id"],
        amount: json["amount"],
        paymentLink: json["payment_link"],
        note: json["note"],
        slug: json["slug"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "service_request_id": serviceRequestId,
        "amount": amount,
        "payment_link": paymentLink,
        "note": note,
        "slug": slug,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class LinkCpn {
    final String? url;
    final String? label;
    final int? page;
    final bool? active;

    LinkCpn({
        this.url,
        this.label,
        this.page,
        this.active,
    });

    LinkCpn copyWith({
        String? url,
        String? label,
        int? page,
        bool? active,
    }) => 
        LinkCpn(
            url: url ?? this.url,
            label: label ?? this.label,
            page: page ?? this.page,
            active: active ?? this.active,
        );

    factory LinkCpn.fromRawJson(String str) => LinkCpn.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LinkCpn.fromJson(Map<String, dynamic> json) => LinkCpn(
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
