import 'dart:developer';

import 'package:bloons_calculator/APIConstants.dart';
import 'package:bloons_calculator/monkeyHero.dart';
import 'package:bloons_calculator/monkeyTower.dart';
import 'package:http/http.dart' as http;

class APIService {
  Future<List<MonkeyTower>> getTowers() async {
    List<MonkeyTower> towers = [];
    try {
      var url = Uri.parse(APIConstants.towersUrl);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        towers = monkeyTowerFromJson(response.body);
      }
    } catch (e) {
      log("Towers: ${e.toString()}");
    }

    return towers;
  }

  Future<List<MonkeyHero>> getHeroes() async {
    List<MonkeyHero> heroes = [];
    try {
      var url = Uri.parse(APIConstants.heroesUrl);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        heroes = monkeyHeroFromJson(response.body);
      }
    } catch (e) {
      log("Heroes: ${e.toString()}");
    }

    return heroes;
  }
}
