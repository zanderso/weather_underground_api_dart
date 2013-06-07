import "dart:io";
import "dart:json";
import "dart:async";
import "dart:collection";

class WeatherUnderground {
  const _apiURL= "http://api.wunderground.com/api/";
  String _apiKey;
  String _locQuery;
  HttpClient _client;
  Map _apiMap = {'conditions': 'current_observation',
                 'alerts': 'alerts',
                 'almanac': 'almanac',
                 'astronomy': 'moon_phase'};
  
  void setLocationQuery(String locationQuery) {
    _locQuery = locationQuery;
  }
  
  WeatherUnderground(String apiKey, String locationQuery) {
    _apiKey = apiKey;
    setLocationQuery(locationQuery);
    _client = new HttpClient();
  }
  
  Future getAlmanac() {
    return makeAPICall('almanac');
  }
  
  Future getConditions() {
    return makeAPICall('conditions');
  }
  
  Future getAlerts() {
    return makeAPICall('alerts');
  }
  
  Future getAstronomy() {
    return makeAPICall('astronomy');
  }
  
  Future makeAPICall(String apiName) {
    Completer completer = new Completer();
    
    String query = _apiURL + _apiKey + "/" + apiName + "/q/" + _locQuery + ".json";
    _client.getUrl(Uri.parse(query))
      .then((HttpClientRequest request) {
        return request.close();
      })
      .then((HttpClientResponse response) {
        response.transform(new StringDecoder()).toList().then((data) {
          String body = data.join('');
          LinkedHashMap parsedList = parse(body);
          String dataKey = parsedList['response']['features'].keys.first; 
          print(parsedList.toString()); 
          completer.complete(parsedList[_apiMap[dataKey]]);       
        });        
      });
    return completer.future;
  }
}