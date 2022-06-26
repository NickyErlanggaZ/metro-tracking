// To parse this JSON data, do
//
//     final devices = devicesFromJson(jsonString);

import 'dart:convert';

List<Devices> devicesFromJson(String str) => List<Devices>.from(json.decode(str).map((x) => Devices.fromJson(x)));

String devicesToJson(List<Devices> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Devices {
    Devices({
        required this.id,
        required this.attributes,
        required this.groupId,
        required this.name,
        required this.uniqueId,
        required this.status,
        required this.lastUpdate,
        required this.positionId,
        required this.geofenceIds,
        this.phone,
        this.model,
        this.contact,
        required this.category,
        required this.disabled,
    });

    int id;
    Attributes attributes;
    int groupId;
    String name;
    String uniqueId;
    String status;
    DateTime lastUpdate;
    int positionId;
    List<dynamic> geofenceIds;
    dynamic phone;
    dynamic model;
    dynamic contact;
    dynamic category;
    bool disabled;

    factory Devices.fromJson(Map<String, dynamic> json) => Devices(
        id: json["id"],
        attributes: Attributes.fromJson(json["attributes"]),
        groupId: json["groupId"],
        name: json["name"],
        uniqueId: json["uniqueId"],
        status: json["status"],
        lastUpdate: DateTime.parse(json["lastUpdate"]),
        positionId: json["positionId"],
        geofenceIds: List<dynamic>.from(json["geofenceIds"].map((x) => x)),
        phone: json["phone"],
        model: json["model"],
        contact: json["contact"],
        category: json["category"],
        disabled: json["disabled"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "attributes": attributes.toJson(),
        "groupId": groupId,
        "name": name,
        "uniqueId": uniqueId,
        "status": status,
        "lastUpdate": lastUpdate.toIso8601String(),
        "positionId": positionId,
        "geofenceIds": List<dynamic>.from(geofenceIds.map((x) => x)),
        "phone": phone,
        "model": model,
        "contact": contact,
        "category": category,
        "disabled": disabled,
    };
}

class Attributes {
    Attributes({
        this.platNomer,
    });

    String? platNomer;

    factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        platNomer: json["platNomer"] ?? null,
    );

    Map<String, dynamic> toJson() => {
        "platNomer": platNomer ?? null,
    };
}

