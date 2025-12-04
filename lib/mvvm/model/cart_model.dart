
import 'package:queroobras_mobile/mvvm/const/export.dart';

class CartModel {
    final String? status;
    final DataCart? data;

    CartModel({
        this.status,
        this.data,
    });

    CartModel copyWith({
        String? status,
        DataCart? data,
    }) => 
        CartModel(
            status: status ?? this.status,
            data: data ?? this.data,
        );

    factory CartModel.fromRawJson(String str) => CartModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        status: json["status"],
        data: json["data"] == null ? null : DataCart.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
    };
}

class DataCart {
    final List<ItemElement>? items;
    final int? totalQuantity;
    final double? totalPrice;

    DataCart({
        this.items,
        this.totalQuantity,
        this.totalPrice,
    });

    DataCart copyWith({
        List<ItemElement>? items,
        int? totalQuantity,
        double? totalPrice,
    }) => 
        DataCart(
            items: items ?? this.items,
            totalQuantity: totalQuantity ?? this.totalQuantity,
            totalPrice: totalPrice ?? this.totalPrice,
        );

    factory DataCart.fromRawJson(String str) => DataCart.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DataCart.fromJson(Map<String, dynamic> json) => DataCart(
        items: json["items"] == null ? [] : List<ItemElement>.from(json["items"]!.map((x) => ItemElement.fromJson(x))),
        totalQuantity: json["total_quantity"],
        totalPrice: json["total_price"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
        "total_quantity": totalQuantity,
        "total_price": totalPrice,
    };
}

class ItemElement {
    final int? id;
    final String? userId;
    final String? itemId;
    final String? slug;
    final String? quantity;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final Item? item;

    ItemElement({
        this.id,
        this.userId,
        this.itemId,
        this.slug,
        this.quantity,
        this.createdAt,
        this.updatedAt,
        this.item,
    });

    ItemElement copyWith({
        int? id,
        String? userId,
        String? itemId,
        String? slug,
        String? quantity,
        DateTime? createdAt,
        DateTime? updatedAt,
        Item? item,
    }) => 
        ItemElement(
            id: id ?? this.id,
            userId: userId ?? this.userId,
            itemId: itemId ?? this.itemId,
            slug: slug ?? this.slug,
            quantity: quantity ?? this.quantity,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            item: item ?? this.item,
        );

    factory ItemElement.fromRawJson(String str) => ItemElement.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ItemElement.fromJson(Map<String, dynamic> json) => ItemElement(
        id: json["id"],
        userId: json["user_id"],
        itemId: json["item_id"],
        slug: json["slug"],
        quantity: json["quantity"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        item: json["item"] == null ? null : Item.fromJson(json["item"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "item_id": itemId,
        "slug": slug,
        "quantity": quantity,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "item": item?.toJson(),
    };
}



