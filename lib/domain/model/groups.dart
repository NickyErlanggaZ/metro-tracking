// To parse this JSON data, do
//
//     final groups = groupsFromJson(jsonString);

import 'dart:convert';

List<Groups> groupsFromJson(String str) => List<Groups>.from(json.decode(str).map((x) => Groups.fromJson(x)));

String groupsToJson(List<Groups> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Groups {
    Groups({
        required this.id,
        required this.attributes,
        required this.groupId,
        required this.name,
    });

    int id;
    Attributes attributes;
    int groupId;
    String name;

    factory Groups.fromJson(Map<String, dynamic> json) => Groups(
        id: json["id"],
        attributes: Attributes.fromJson(json["attributes"]),
        groupId: json["groupId"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "attributes": attributes.toJson(),
        "groupId": groupId,
        "name": name,
    };
}

class Attributes {
    Attributes();

    factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
    );

    Map<String, dynamic> toJson() => {
    };
}
