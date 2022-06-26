// To parse this JSON data, do
//
//     final positions = positionsFromJson(jsonString);

import 'dart:convert';

List<Positions> positionsFromJson(String str) => List<Positions>.from(json.decode(str).map((x) => Positions.fromJson(x)));

String positionsToJson(List<Positions> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Positions {
    Positions({
        required this.id,
        required this.attributes,
        required this.deviceId,
        required this.protocol,
        required this.serverTime,
        required this.deviceTime,
        required this.fixTime,
        required this.outdated,
        required this.valid,
        required this.latitude,
        required this.longitude,
        required this.altitude,
        required this.speed,
        required this.course,
        this.address,
        required this.accuracy,
        this.network,
    });

    int id;
    Attributes attributes;
    int deviceId;
    String protocol;
    DateTime serverTime;
    DateTime deviceTime;
    DateTime fixTime;
    bool outdated;
    bool valid;
    double latitude;
    double longitude;
    double altitude;
    double speed;
    double course;
    dynamic address;
    double accuracy;
    dynamic network;

    factory Positions.fromJson(Map<String, dynamic> json) => Positions(
        id: json["id"],
        attributes: Attributes.fromJson(json["attributes"]),
        deviceId: json["deviceId"],
        protocol: json["protocol"],
        serverTime: DateTime.parse(json["serverTime"]),
        deviceTime: DateTime.parse(json["deviceTime"]),
        fixTime: DateTime.parse(json["fixTime"]),
        outdated: json["outdated"],
        valid: json["valid"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        altitude: json["altitude"].toDouble(),
        speed: json["speed"].toDouble(),
        course: json["course"].toDouble(),
        address: json["address"],
        accuracy: json["accuracy"].toDouble(),
        network: json["network"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "attributes": attributes.toJson(),
        "deviceId": deviceId,
        "protocol": protocol,
        "serverTime": serverTime.toIso8601String(),
        "deviceTime": deviceTime.toIso8601String(),
        "fixTime": fixTime.toIso8601String(),
        "outdated": outdated,
        "valid": valid,
        "latitude": latitude,
        "longitude": longitude,
        "altitude": altitude,
        "speed": speed,
        "course": course,
        "address": address,
        "accuracy": accuracy,
        "network": network,
    };
}

class Attributes {
    Attributes({
        this.batteryLevel,
        this.distance,
        this.totalDistance,
        this.motion,
    });

    dynamic batteryLevel;
    dynamic distance;
    dynamic totalDistance;
    dynamic motion;

    factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        batteryLevel: json["batteryLevel"] ?? null,
        distance: json["distance"] ?? null,
        totalDistance: json["totalDistance"] == null ? null : json["totalDistance"].toDouble(),
        motion: json["motion"] ?? null,
    );

    Map<String, dynamic> toJson() => {
        "batteryLevel": batteryLevel ?? null,
        "distance": distance ?? null,
        "totalDistance": totalDistance ?? null,
        "motion": motion ?? null,
    };
}
