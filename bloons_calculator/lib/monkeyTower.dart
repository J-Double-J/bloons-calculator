import 'package:meta/meta.dart';
import 'dart:convert';

//

List<MonkeyTower> monkeyTowerFromJson(String str) => List<MonkeyTower>.from(
    json.decode(str).map((x) => MonkeyTower.fromJson(x)));

String monkeyTowerToJson(List<MonkeyTower> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MonkeyTower {
  MonkeyTower({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.cost,
    required this.stats,
    required this.footprint,
    required this.defaultHotkey,
    required this.paths,
  });

  String id;
  String name;
  String description;
  Type? type;
  Cost cost;
  Stats stats;
  int footprint;
  String defaultHotkey;
  Paths paths;

  factory MonkeyTower.fromJson(Map<String, dynamic> json) => MonkeyTower(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        type: typeValues.map[json["type"]],
        cost: Cost.fromJson(json["cost"]),
        stats: Stats.fromJson(json["stats"]),
        footprint: json["footprint"],
        defaultHotkey: json["defaultHotkey"],
        paths: Paths.fromJson(json["paths"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "type": typeValues.reverse?[type],
        "cost": cost.toJson(),
        "stats": stats.toJson(),
        "footprint": footprint,
        "defaultHotkey": defaultHotkey,
        "paths": paths.toJson(),
      };
}

class Cost {
  Cost({
    required this.easy,
    required this.medium,
    required this.hard,
    required this.impoppable,
  });

  int easy;
  int medium;
  int hard;
  int impoppable;

  factory Cost.fromJson(Map<String, dynamic> json) => Cost(
        easy: json["easy"],
        medium: json["medium"],
        hard: json["hard"],
        impoppable: json["impoppable"],
      );

  Map<String, dynamic> toJson() => {
        "easy": easy,
        "medium": medium,
        "hard": hard,
        "impoppable": impoppable,
      };
}

class Paths {
  Paths({
    required this.path1,
    required this.path2,
    required this.path3,
    required this.paragon,
  });

  List<Path> path1;
  List<Path> path2;
  List<Path> path3;
  Path? paragon;

  factory Paths.fromJson(Map<String, dynamic> json) => Paths(
        path1: List<Path>.from(json["path1"].map((x) => Path.fromJson(x))),
        path2: List<Path>.from(json["path2"].map((x) => Path.fromJson(x))),
        path3: List<Path>.from(json["path3"].map((x) => Path.fromJson(x))),
        paragon:
            json["paragon"] == null ? null : Path.fromJson(json["paragon"]),
      );

  Map<String, dynamic> toJson() => {
        "path1": List<dynamic>.from(path1.map((x) => x.toJson())),
        "path2": List<dynamic>.from(path2.map((x) => x.toJson())),
        "path3": List<dynamic>.from(path3.map((x) => x.toJson())),
        "paragon": paragon == null ? null : paragon?.toJson(),
      };
}

class Path {
  Path({
    required this.name,
    required this.description,
    required this.cost,
    required this.unlockXp,
    required this.effects,
    required this.source,
  });

  String name;
  String description;
  Cost cost;
  int unlockXp;
  List<String> effects;
  String source;

  factory Path.fromJson(Map<String, dynamic> json) => Path(
        name: json["name"],
        description: json["description"],
        cost: Cost.fromJson(json["cost"]),
        unlockXp: json["unlockXp"],
        effects: List<String>.from(json["effects"].map((x) => x)),
        source: json["source"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "cost": cost.toJson(),
        "unlockXp": unlockXp,
        "effects": List<dynamic>.from(effects.map((x) => x)),
        "source": source,
      };
}

class Stats {
  Stats({
    required this.damage,
    required this.pierce,
    required this.attackSpeed,
    required this.range,
    required this.type,
    required this.special,
  });

  String damage;
  String pierce;
  String attackSpeed;
  String range;
  String type;
  List<Special>? special;

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
        damage: json["damage"],
        pierce: json["pierce"],
        attackSpeed: json["attackSpeed"],
        range: json["range"],
        type: json["type"],
        special: json["special"] == null
            ? null
            : List<Special>.from(
                json["special"].map((x) => Special.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "damage": damage,
        "pierce": pierce,
        "attackSpeed": attackSpeed,
        "range": range,
        "type": type,
        "special": special == null
            ? null
            : List<dynamic>.from(special!.map((x) => x.toJson())),
      };
}

class Special {
  Special({
    required this.name,
    required this.value,
  });

  String name;
  String value;

  factory Special.fromJson(Map<String, dynamic> json) => Special(
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
      };
}

enum Type { PRIMARY, MILITARY, MAGIC, SUPPORT }

final typeValues = EnumValues({
  "Magic": Type.MAGIC,
  "Military": Type.MILITARY,
  "Primary": Type.PRIMARY,
  "Support": Type.SUPPORT
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => new MapEntry(v, k));
    return reverseMap;
  }
}
