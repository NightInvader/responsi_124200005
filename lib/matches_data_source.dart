import 'package:resp/base_network.dart';

class MatchesDataSource {
  static MatchesDataSource instance=MatchesDataSource();
  Future<Map<String,dynamic>> LoadMatches(){
    return BaseNetwork.get("matches");
  }
}