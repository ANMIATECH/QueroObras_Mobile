import 'dart:convert';

class ChatData {
    final String? status;
    final List<Datum>? data;

    ChatData({
        this.status,
        this.data,
    });

    ChatData copyWith({
        String? status,
        List<Datum>? data,
    }) => 
        ChatData(
            status: status ?? this.status,
            data: data ?? this.data,
        );

    factory ChatData.fromRawJson(String str) => ChatData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ChatData.fromJson(Map<String, dynamic> json) => ChatData(
        status: json["status"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    final int? chatId;
    final Receiver? receiver;
    final String? latestMessage;
    final dynamic latestFile;
    final int? unreadCount;
    final DateTime? updatedAt;

    Datum({
        this.chatId,
        this.receiver,
        this.latestMessage,
        this.latestFile,
        this.unreadCount,
        this.updatedAt,
    });

    Datum copyWith({
        int? chatId,
        Receiver? receiver,
        String? latestMessage,
        dynamic latestFile,
        int? unreadCount,
        DateTime? updatedAt,
    }) => 
        Datum(
            chatId: chatId ?? this.chatId,
            receiver: receiver ?? this.receiver,
            latestMessage: latestMessage ?? this.latestMessage,
            latestFile: latestFile ?? this.latestFile,
            unreadCount: unreadCount ?? this.unreadCount,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        chatId: json["chat_id"],
        receiver: json["receiver"] == null ? null : Receiver.fromJson(json["receiver"]),
        latestMessage: json["latest_message"],
        latestFile: json["latest_file"],
        unreadCount: json["unread_count"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "chat_id": chatId,
        "receiver": receiver?.toJson(),
        "latest_message": latestMessage,
        "latest_file": latestFile,
        "unread_count": unreadCount,
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class Receiver {
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

    Receiver({
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

    Receiver copyWith({
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
        Receiver(
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

    factory Receiver.fromRawJson(String str) => Receiver.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Receiver.fromJson(Map<String, dynamic> json) => Receiver(
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

    factory Profile.fromRawJson(String str) => Profile.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

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
