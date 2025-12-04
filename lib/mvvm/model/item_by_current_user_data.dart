import 'dart:convert';

class ItemForCurrentUser {
    final String? status;
    final List<Item>? items;
    final Pagination? pagination;
    final String? message;

    ItemForCurrentUser({
        this.status,
        this.items,
        this.pagination,
        this.message,
    });

    ItemForCurrentUser copyWith({
        String? status,
        List<Item>? items,
        Pagination? pagination,
        String? message,
    }) => 
        ItemForCurrentUser(
            status: status ?? this.status,
            items: items ?? this.items,
            pagination: pagination ?? this.pagination,
            message: message ?? this.message,
        );

    factory ItemForCurrentUser.fromRawJson(String str) => ItemForCurrentUser.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ItemForCurrentUser.fromJson(Map<String, dynamic> json) => ItemForCurrentUser(
        status: json["status"],
        items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
        "message": message,
    };
}

class Item {
    final int? id;
    final String? userId;
    final String? name;
    final String? slug;
    final String? type;
    final String? quantity;
    final String? price;
    final String? description;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final List<FileElement>? files;

    Item({
        this.id,
        this.userId,
        this.name,
        this.slug,
        this.type,
        this.quantity,
        this.price,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.files,
    });

    Item copyWith({
        int? id,
        String? userId,
        String? name,
        String? slug,
        String? type,
        String? quantity,
        String? price,
        String? description,
        DateTime? createdAt,
        DateTime? updatedAt,
        List<FileElement>? files,
    }) => 
        Item(
            id: id ?? this.id,
            userId: userId ?? this.userId,
            name: name ?? this.name,
            slug: slug ?? this.slug,
            type: type ?? this.type,
            quantity: quantity ?? this.quantity,
            price: price ?? this.price,
            description: description ?? this.description,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            files: files ?? this.files,
        );

    factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        slug: json["slug"],
        type: json["type"],
        quantity: json["quantity"],
        price: json["price"],
        description: json["description"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        files: json["files"] == null ? [] : List<FileElement>.from(json["files"]!.map((x) => FileElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "slug": slug,
        "type": type,
        "quantity": quantity,
        "price": price,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "files": files == null ? [] : List<dynamic>.from(files!.map((x) => x.toJson())),
    };
}

class FileElement {
    final int? id;
    final String? itemId;
    final String? path;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    FileElement({
        this.id,
        this.itemId,
        this.path,
        this.createdAt,
        this.updatedAt,
    });

    FileElement copyWith({
        int? id,
        String? itemId,
        String? path,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        FileElement(
            id: id ?? this.id,
            itemId: itemId ?? this.itemId,
            path: path ?? this.path,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory FileElement.fromRawJson(String str) => FileElement.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        id: json["id"],
        itemId: json["item_id"],
        path: json["path"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "item_id": itemId,
        "path": path,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class Pagination {
    final int? currentPage;
    final int? perPage;
    final int? total;
    final int? lastPage;
    final String? nextPageUrl;
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
        String? nextPageUrl,
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

    factory Pagination.fromRawJson(String str) => Pagination.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

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
