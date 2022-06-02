// To parse this JSON data, do
//
//     final monkeyTower = monkeyTowerFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<MonkeyHero> monkeyHeroFromJson(String str) =>
    List<MonkeyHero>.from(json.decode(str).map((x) => MonkeyHero.fromJson(x)));

String monkeyHeroToJson(List<MonkeyHero> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MonkeyHero {
  MonkeyHero({
    required this.id,
    required this.name,
    required this.description,
    required this.skinChange,
    required this.skins,
    required this.cost,
    required this.stats,
    required this.unlock,
    required this.levelSpeed,
    required this.levels,
  });

  String id;
  String name;
  String description;
  List<int> skinChange;
  List<Skin> skins;
  Cost cost;
  Stats stats;
  Unlock unlock;
  String levelSpeed;
  List<Level> levels;

  factory MonkeyHero.fromJson(Map<String, dynamic> json) => MonkeyHero(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        skinChange: List<int>.from(json["skinChange"].map((x) => x)),
        skins: List<Skin>.from(json["skins"].map((x) => Skin.fromJson(x))),
        cost: Cost.fromJson(json["cost"]),
        stats: Stats.fromJson(json["stats"]),
        unlock: Unlock.fromJson(json["unlock"]),
        levelSpeed: json["levelSpeed"],
        levels: List<Level>.from(json["levels"].map((x) => Level.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "skinChange": List<dynamic>.from(skinChange.map((x) => x)),
        "skins": List<dynamic>.from(skins.map((x) => x.toJson())),
        "cost": cost.toJson(),
        "stats": stats.toJson(),
        "unlock": unlock.toJson(),
        "levelSpeed": levelSpeed,
        "levels": List<dynamic>.from(levels.map((x) => x.toJson())),
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

class Level {
  Level({
    required this.level,
    required this.description,
    required this.xp,
    required this.rounds,
    required this.effects,
    required this.source,
  });

  int level;
  String description;
  int xp;
  Rounds rounds;
  List<String> effects;
  String source;

  factory Level.fromJson(Map<String, dynamic> json) => Level(
        level: json["level"],
        description: json["description"],
        xp: json["xp"],
        rounds: Rounds.fromJson(json["rounds"]),
        effects: List<String>.from(json["effects"].map((x) => x)),
        source: json["source"],
      );

  Map<String, dynamic> toJson() => {
        "level": level,
        "description": description,
        "xp": xp,
        "rounds": rounds.toJson(),
        "effects": List<dynamic>.from(effects.map((x) => x)),
        "source": source,
      };
}

class Rounds {
  Rounds({
    required this.easy,
    required this.medium,
    required this.hard,
    required this.impoppable,
  });

  String easy;
  String medium;
  String hard;
  String impoppable;

  factory Rounds.fromJson(Map<String, dynamic> json) => Rounds(
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

class Skin {
  Skin({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory Skin.fromJson(Map<String, dynamic> json) => Skin(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
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

class Unlock {
  Unlock({
    required this.how,
    required this.value,
  });

  How? how;
  String value;

  factory Unlock.fromJson(Map<String, dynamic> json) => Unlock(
        how: howValues.map[json["how"]],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "how": howValues.reverse?[how],
        "value": value,
      };
}

enum How { LEVEL, MONEY }

final howValues = EnumValues({"level": How.LEVEL, "money": How.MONEY});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
