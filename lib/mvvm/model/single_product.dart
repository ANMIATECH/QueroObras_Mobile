import 'dart:convert';

class SingleProduct {
    final String? status;
    final ItemSingleProduct? item;
    final String? paymentStatus;
    final List<dynamic>? similarItems;
    final String? message;

    SingleProduct({
        this.status,
        this.item,
        this.paymentStatus,
        this.similarItems,
        this.message,
    });

    SingleProduct copyWith({
        String? status,
        ItemSingleProduct? item,
        String? paymentStatus,
        List<dynamic>? similarItems,
        String? message,
    }) => 
        SingleProduct(
            status: status ?? this.status,
            item: item ?? this.item,
            paymentStatus: paymentStatus ?? this.paymentStatus,
            similarItems: similarItems ?? this.similarItems,
            message: message ?? this.message,
        );

    factory SingleProduct.fromRawJson(String str) => SingleProduct.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SingleProduct.fromJson(Map<String, dynamic> json) => SingleProduct(
        status: json["status"],
        item: json["item"] == null ? null : ItemSingleProduct.fromJson(json["item"]),
        paymentStatus: json["payment_status"],
        similarItems: json["similar_items"] == null ? [] : List<dynamic>.from(json["similar_items"]!.map((x) => x)),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "item": item?.toJson(),
        "payment_status": paymentStatus,
        "similar_items": similarItems == null ? [] : List<dynamic>.from(similarItems!.map((x) => x)),
        "message": message,
    };
}

class ItemSingleProduct {
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
    final List<FileElementSingleProduct>? files;
    final UserSingleProduct? user;

    ItemSingleProduct({
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
        this.user,
    });

    ItemSingleProduct copyWith({
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
        List<FileElementSingleProduct>? files,
        UserSingleProduct? user,
    }) => 
        ItemSingleProduct(
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
            user: user ?? this.user,
        );

    factory ItemSingleProduct.fromRawJson(String str) => ItemSingleProduct.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ItemSingleProduct.fromJson(Map<String, dynamic> json) => ItemSingleProduct(
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
        files: json["files"] == null ? [] : List<FileElementSingleProduct>.from(json["files"]!.map((x) => FileElementSingleProduct.fromJson(x))),
        user: json["user"] == null ? null : UserSingleProduct.fromJson(json["user"]),
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
        "user": user?.toJson(),
    };
}

class FileElementSingleProduct {
    final int? id;
    final String? itemId;
    final String? path;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    FileElementSingleProduct({
        this.id,
        this.itemId,
        this.path,
        this.createdAt,
        this.updatedAt,
    });

    FileElementSingleProduct copyWith({
        int? id,
        String? itemId,
        String? path,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        FileElementSingleProduct(
            id: id ?? this.id,
            itemId: itemId ?? this.itemId,
            path: path ?? this.path,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory FileElementSingleProduct.fromRawJson(String str) => FileElementSingleProduct.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory FileElementSingleProduct.fromJson(Map<String, dynamic> json) => FileElementSingleProduct(
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

class UserSingleProduct {
    final int? id;
    final String? name;
    final String? userStatus;
    final String? email;
    final String? isVerified;
    final String? isAdmin;
    final String? status;
    final String? slug;
    final dynamic categoryId;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final ProfileSingleProduct? profile;

    UserSingleProduct({
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

    UserSingleProduct copyWith({
        int? id,
        String? name,
        String? userStatus,
        String? email,
        String? isVerified,
        String? isAdmin,
        String? status,
        String? slug,
        dynamic categoryId,
        DateTime? createdAt,
        DateTime? updatedAt,
        ProfileSingleProduct? profile,
    }) => 
        UserSingleProduct(
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

    factory UserSingleProduct.fromRawJson(String str) => UserSingleProduct.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserSingleProduct.fromJson(Map<String, dynamic> json) => UserSingleProduct(
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
        profile: json["profile"] == null ? null : ProfileSingleProduct.fromJson(json["profile"]),
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

class ProfileSingleProduct {
    final int? id;
    final String? avatar;
    final dynamic text;
    final String? address;
    final String? cpf;
    final dynamic cnpj;
    final dynamic phone;
    final String? zipCode;
    final String? userId;
    final String? latitude;
    final String? longitude;
    final String? city;
    final String? state;
    final dynamic corporateName;
    final dynamic legalRepresentativeName;
    final dynamic tradeName;
    final String? motherName;
    final dynamic dateOfBirth;
    final dynamic stateRegistration;
    final dynamic cnpjDocument;
    final String? identificanDriverLicense;
    final dynamic username;
    final String? isAvailable;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    ProfileSingleProduct({
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

    ProfileSingleProduct copyWith({
        int? id,
        String? avatar,
        dynamic text,
        String? address,
        String? cpf,
        dynamic cnpj,
        dynamic phone,
        String? zipCode,
        String? userId,
        String? latitude,
        String? longitude,
        String? city,
        String? state,
        dynamic corporateName,
        dynamic legalRepresentativeName,
        dynamic tradeName,
        String? motherName,
        dynamic dateOfBirth,
        dynamic stateRegistration,
        dynamic cnpjDocument,
        String? identificanDriverLicense,
        dynamic username,
        String? isAvailable,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        ProfileSingleProduct(
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

    factory ProfileSingleProduct.fromRawJson(String str) => ProfileSingleProduct.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ProfileSingleProduct.fromJson(Map<String, dynamic> json) => ProfileSingleProduct(
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
        dateOfBirth: json["date_of_birth"],
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
        "date_of_birth": dateOfBirth,
        "state_registration": stateRegistration,
        "cnpj_document": cnpjDocument,
        "identifican_driver_license": identificanDriverLicense,
        "username": username,
        "is_available": isAvailable,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
