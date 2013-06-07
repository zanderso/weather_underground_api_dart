import "dart:io";
import "dart:json";
import "dart:async";

class WeatherUnderground {
  const _apiURL= "http://api.wunderground.com/api/";
  String _apiKey;
  String _locQuery;
  HttpClient _client;
  
  void setLocationQuery(String locationQuery) {
    _locQuery = locationQuery;
  }
  
  WeatherUnderground(String apiKey, String locationQuery) {
    _apiKey = apiKey;
    setLocationQuery(locationQuery);
    _client = new HttpClient();
  }
  
  Future getConditions() {
    Completer completer = new Completer();
    
    String query = _apiURL + _apiKey + "/conditions/q/" + _locQuery + ".json";
    _client.getUrl(Uri.parse(query))
      .then((HttpClientRequest request) {
        return request.close();
      })
      .then((HttpClientResponse response) {
        response.transform(new StringDecoder()).toList().then((data) {
          var body = data.join('');
          var parsedList = parse(body);
          completer.complete(parsedList['current_observation']);
        });        
      });
    return completer.future;
  }
}