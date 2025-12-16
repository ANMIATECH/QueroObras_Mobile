import 'dart:convert';

import 'package:queroobras_mobile/mvvm/model/item_by_current_user_data.dart';

class OrderPayed {
  final String? status;
  final DataOrderPay? data;

  OrderPayed({this.status, this.data});

  OrderPayed copyWith({String? status, DataOrderPay? data}) =>
      OrderPayed(status: status ?? this.status, data: data ?? this.data);

  factory OrderPayed.fromRawJson(String str) =>
      OrderPayed.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderPayed.fromJson(Map<String, dynamic> json) => OrderPayed(
    status: json["status"],
    data: json["data"] == null ? null : DataOrderPay.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {"status": status, "data": data?.toJson()};
}

class DataOrderPay {
  final List<DataItemPayOrder>? items;
  final int? total;
  final int? perPage;
  final int? currentPage;
  final int? lastPage;

  DataOrderPay({
    this.items,
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
  });

  DataOrderPay copyWith({
    List<DataItemPayOrder>? items,
    int? total,
    int? perPage,
    int? currentPage,
    int? lastPage,
  }) => DataOrderPay(
    items: items ?? this.items,
    total: total ?? this.total,
    perPage: perPage ?? this.perPage,
    currentPage: currentPage ?? this.currentPage,
    lastPage: lastPage ?? this.lastPage,
  );

  factory DataOrderPay.fromRawJson(String str) =>
      DataOrderPay.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataOrderPay.fromJson(Map<String, dynamic> json) => DataOrderPay(
    items: json["items"] == null
        ? []
        : List<DataItemPayOrder>.from(
            json["items"]!.map((x) => DataItemPayOrder.fromJson(x)),
          ),
    total: json["total"],
    perPage: json["per_page"],
    currentPage: json["current_page"],
    lastPage: json["last_page"],
  );

  Map<String, dynamic> toJson() => {
    "items": items == null
        ? []
        : List<dynamic>.from(items!.map((x) => x.toJson())),
    "total": total,
    "per_page": perPage,
    "current_page": currentPage,
    "last_page": lastPage,
  };
}

class DataItemPayOrder {
  final OrderItem? orderItem;
  final Order? order;
  final ItemItemOrder? item;
  


     final int? id;
    final String? orderId;
    final String? itemId;
    final String? sellerId;
    final String? quantity;
    final String? pricePerItem;
    final String? totalPrice;
    final String? status;
    final String? slug;
    final DateTime? createdAt;
    final DateTime? updatedAt;

  DataItemPayOrder({this.orderItem, this.order, this.item, this.id, this.orderId, this.itemId, this.sellerId, this.quantity, this.pricePerItem, this.totalPrice, this.status, this.slug, this.createdAt, this.updatedAt});

  DataItemPayOrder copyWith({
    OrderItem? orderItem,
    Order? order,
    ItemItemOrder? item,
       int? id,
        String? orderId,
        String? itemId,
        String? sellerId,
        String? quantity,
        String? pricePerItem,
        String? totalPrice,
        String? status,
        String? slug,
        DateTime? createdAt,
  }) => DataItemPayOrder(
    orderItem: orderItem ?? this.orderItem,
    order: order ?? this.order,
    item: item ?? this.item,
     id: id ?? this.id,
            orderId: orderId ?? this.orderId,
            itemId: itemId ?? this.itemId,
            sellerId: sellerId ?? this.sellerId,
            quantity: quantity ?? this.quantity,
            pricePerItem: pricePerItem ?? this.pricePerItem,
            totalPrice: totalPrice ?? this.totalPrice,
            status: status ?? this.status,
            slug: slug ?? this.slug,
            createdAt: createdAt ?? this.createdAt,
  );

  factory DataItemPayOrder.fromRawJson(String str) =>
      DataItemPayOrder.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataItemPayOrder.fromJson(Map<String, dynamic> json) =>
      DataItemPayOrder(
           id: json["id"],
        orderId: json["order_id"],
        itemId: json["item_id"],
        sellerId: json["seller_id"],
        quantity: json["quantity"],
        pricePerItem: json["price_per_item"],
        totalPrice: json["total_price"],
        status: json["status"],
        slug: json["slug"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        orderItem: json["order_item"] == null
            ? null
            : OrderItem.fromJson(json["order_item"]),
        order: json["order"] == null ? null : Order.fromJson(json["order"]),
        item: json["item"] == null
            ? null
            : ItemItemOrder.fromJson(json["item"]),
      );

  Map<String, dynamic> toJson() => {
    "order_item": orderItem?.toJson(),
    "order": order?.toJson(),
    "item": item?.toJson(),
  };
}

class ItemItemOrder {
  final int? id;
  final String? userId;
  final String? name;
  final String? slug;
  final String? type;
  final String? status;
  final String? quantity;
  final String? price;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<FileElement>? files;

  ItemItemOrder({
    this.id,
    this.userId,
    this.name,
    this.slug,
    this.type,
    this.quantity,
    this.status,
    this.price,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.files,
  });

  ItemItemOrder copyWith({
    int? id,
    String? userId,
    String? name,
    String? slug,
    String? type,
    String? quantity,
    String? price,
    String? status,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<FileElement>? files,
  }) => ItemItemOrder(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    name: name ?? this.name,
    slug: slug ?? this.slug,
    type: type ?? this.type,
    status: status ?? this.status,
    quantity: quantity ?? this.quantity,
    price: price ?? this.price,
    description: description ?? this.description,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    files: files ?? this.files,
  );

  factory ItemItemOrder.fromRawJson(String str) =>
      ItemItemOrder.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ItemItemOrder.fromJson(Map<String, dynamic> json) => ItemItemOrder(
    id: json["id"],
    userId: json["user_id"],
    name: json["name"],
    slug: json["slug"],
    status: json["status"],
    type: json["type"],
    quantity: json["quantity"],
    price: json["price"],
    description: json["description"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    files: json["files"] == null
        ? []
        : List<FileElement>.from(
            json["files"]!.map((x) => FileElement.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "slug": slug,
    "status": status,
    "type": type,
    "quantity": quantity,
    "price": price,
    "description": description,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "files": files == null
        ? []
        : List<dynamic>.from(files!.map((x) => x.toJson())),
  };
}

class Order {
  final int? id;
  final String? userId;
  final String? slug;
  final String? totalPrice;
  final String? totalQuantity;
  final String? orderNumber;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Order({
    this.id,
    this.userId,
    this.slug,
    this.totalPrice,
    this.totalQuantity,
    this.orderNumber,
    this.createdAt,
    this.updatedAt,
  });

  Order copyWith({
    int? id,
    String? userId,
    String? slug,
    String? totalPrice,
    String? totalQuantity,
    String? orderNumber,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Order(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    slug: slug ?? this.slug,
    totalPrice: totalPrice ?? this.totalPrice,
    totalQuantity: totalQuantity ?? this.totalQuantity,
    orderNumber: orderNumber ?? this.orderNumber,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory Order.fromRawJson(String str) => Order.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    userId: json["user_id"],
    slug: json["slug"],
    totalPrice: json["total_price"],
    totalQuantity: json["total_quantity"],
    orderNumber: json["order_number"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "slug": slug,
    "total_price": totalPrice,
    "total_quantity": totalQuantity,
    "order_number": orderNumber,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class OrderItem {
  final int? id;
  final String? orderId;
  final String? itemId;
  final String? sellerId;
  final String? quantity;
  final String? pricePerItem;
  final String? totalPrice;
  final String? status;
  final String? slug;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Order? order;
  final ItemItemOrder? item;

  OrderItem({
    this.id,
    this.orderId,
    this.itemId,
    this.sellerId,
    this.quantity,
    this.pricePerItem,
    this.totalPrice,
    this.status,
    this.slug,
    this.createdAt,
    this.updatedAt,
    this.order,
    this.item,
  });

  OrderItem copyWith({
    int? id,
    String? orderId,
    String? itemId,
    String? sellerId,
    String? quantity,
    String? pricePerItem,
    String? totalPrice,
    String? status,
    String? slug,
    DateTime? createdAt,
    DateTime? updatedAt,
    Order? order,
    ItemItemOrder? item,
  }) => OrderItem(
    id: id ?? this.id,
    orderId: orderId ?? this.orderId,
    itemId: itemId ?? this.itemId,
    sellerId: sellerId ?? this.sellerId,
    quantity: quantity ?? this.quantity,
    pricePerItem: pricePerItem ?? this.pricePerItem,
    totalPrice: totalPrice ?? this.totalPrice,
    status: status ?? this.status,
    slug: slug ?? this.slug,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    order: order ?? this.order,
    item: item ?? this.item,
  );

  factory OrderItem.fromRawJson(String str) =>
      OrderItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
    id: json["id"],
    orderId: json["order_id"],
    itemId: json["item_id"],
    sellerId: json["seller_id"],
    quantity: json["quantity"],
    pricePerItem: json["price_per_item"],
    totalPrice: json["total_price"],
    status: json["status"],
    slug: json["slug"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    order: json["order"] == null ? null : Order.fromJson(json["order"]),
    item: json["item"] == null ? null : ItemItemOrder.fromJson(json["item"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "item_id": itemId,
    "seller_id": sellerId,
    "quantity": quantity,
    "price_per_item": pricePerItem,
    "total_price": totalPrice,
    "status": status,
    "slug": slug,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "order": order?.toJson(),
    "item": item?.toJson(),
  };
}
