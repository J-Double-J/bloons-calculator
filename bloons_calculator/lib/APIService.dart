import 'package:bloons_calculator/APIConstants.dart';
import 'package:bloons_calculator/monkeyTower.dart';



class APIService {
  Future<List<MonkeyTower>> getTowers() async {
    List<MonkeyTower> towers = [];
    try {
      var url = Uri.parse(APIConstants.towersUrl);
      var response = await http.get(url);
    }


    return towers;
  }
}
