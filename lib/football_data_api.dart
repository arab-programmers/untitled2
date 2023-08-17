import 'dart:convert';
import 'package:http/http.dart' as http;

class FootballDataApi {
  final String apiKey = '585000e175f24c4292a7bffbd08da67a'; // Replace with your Football-Data.org API key
  final String baseUrl = 'https://api.football-data.org/v3';

  Future<List<League>> getLeagues() async {
    final response = await http.get(
      Uri.parse('$baseUrl/competitions'),
      headers: {'X-Auth-Token': apiKey},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic> leaguesData = jsonData['competitions'];
      return leaguesData.map((item) => League.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load leagues');
    }
  }
}

class League {
  final int id;
  final String name;

  League({required this.id, required this.name});

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      id: json['id'],
      name: json['name'],
    );
  }
}