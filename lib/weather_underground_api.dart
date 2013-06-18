library weather_underground_api;

import "dart:io";
import "dart:json";
import "dart:async";

class QueryNotFound implements Exception {
  final String msg;
  const QueryNotFound([this.msg]);
  String toString() => msg == null ? 'QueryNotFound' : 'QueryNotFound: ${msg}';
}

class KeyNotFound implements Exception {
  final String msg;
  const KeyNotFound([this.msg]);
  String toString() => msg == null ? 'KeyNotFound' : 'KeyNotFound: ${msg}';
}

class UnknownException implements Exception {
  final String msg;
  const UnknownException([this.msg]);
  String toString() => msg == null ? 'UnknownException' : 'UnknownException: ${msg}';
}

class TimeoutException implements Exception {
  final String msg;
  const TimeoutException([this.msg]);
  String toString() => msg == null ? 'TimeoutException' : 'TimeoutException: ${msg}';
}

class WeatherUnderground {
  static const _apiURL= "http://api.wunderground.com/api/";
  static const _autocompleteURL= "http://autocomplete.wunderground.com/";
  String _apiKey;
  String _locQuery;
  HttpClient _client;
  int _timeout;
  
  Map _apiMap = {'alerts': 'alerts',
                 'almanac': 'almanac',
                 'astronomy': 'moon_phase',
                 'conditions': 'current_observation',
                 'currenthurricane': 'currenthurricane',
                 'forecast': 'forecast',
                 'forecast10day': 'forecast',
                 'geolookup': 'location',
                 'history': 'history',
                 'hourly': 'hourly_forecast',
                 'hourly10day': 'hourly_forecast',
                 'planner': 'trip',
                 'rawtide': 'rawtide',
                 'satellite': 'satellite',
                 'tide': 'tide',
                 'webcams': 'webcams',
                 'yesterday': 'history'};
  
  void setLocationQuery(String locationQuery) {
    _locQuery = locationQuery;
  }
  
  void setTimeout(int timeout) {
    _timeout = timeout;
  }
  
  WeatherUnderground(String apiKey, String locationQuery) {
    _apiKey = apiKey;
    setLocationQuery(locationQuery);
    _client = new HttpClient();
    _timeout = 2000;
  }
  
  Future getAlmanac() {
    return makeAPIKeyCall('almanac');
  }
  
  Future getAlerts() {
    return makeAPIKeyCall('alerts');
  }
  
  Future getAstronomy() {
    return makeAPIKeyCall('astronomy');
  }
  
  Future getConditions() {
    return makeAPIKeyCall('conditions');
  }
  
  Future getCurrentHurricane() {
    return makeAPIKeyCall('currenthurricane');
  }
  
  Future getForecast() {
    return makeAPIKeyCall('forecast');
  }
  
  Future getForecast10Day() {
    return makeAPIKeyCall('forecast');    
  }
  
  Future getGeoLookup() {
    return makeAPIKeyCall('geolookup');
  }
  
  Future getHistory(DateTime when) {
    String s = "";
    s = when.year.toString();
    if(when.month < 10) {
      s = s + "0";
    }
    s = s + when.month.toString();
    if(when.day < 10) {
      s = s + "0";
    }
    s = s + when.day.toString();
    return makeAPIKeyCall('history_${s}');
  }
  
  Future getHourly() {
    return makeAPIKeyCall('hourly');
  }
  
  Future getHourly10Day() {
    return makeAPIKeyCall('hourly10day');
  }  
  
  Future getPlanner(int startMonth, int startDay, int endMonth, int endDay) {
    String s = "";
    if(startMonth < 10) {
      s = s + "0";
    }
    s = s + startMonth.toString();
    if(startDay < 10) {
      s = s + "0";
    }
    s = s + startDay.toString();    
    if(endMonth < 10) {
      s = s + "0";
    }
    s = s + endMonth.toString();
    if(endDay < 10) {
      s = s + "0";
    }
    s = s + endDay.toString();
    return makeAPIKeyCall('planner_${s}');
  }

  Future getRawTide() {
    return makeAPIKeyCall('rawtide');
  }    

  Future getSatellite() {
    return makeAPIKeyCall('satellite');
  }    

  Future getTide() {
    return makeAPIKeyCall('tide');
  }      

  Future getWebcams() {
    return makeAPIKeyCall('webcams');
  }        

  Future getYesterday() {
    return makeAPIKeyCall('yesterday');
  }        
  
  Future timeout(Future input, int milliseconds) {
    var completer = new Completer();
    var timer = new Timer(new Duration(milliseconds: milliseconds), () {
      completer.completeError(new TimeoutException());
    });
    input.then((value) {
      if (completer.isCompleted) return;
      timer.cancel();
      completer.complete(value);
    }).catchError((e) {
      if (completer.isCompleted) return;
      timer.cancel();
      completer.completeError(e);
    });
    return completer.future;
  } 
  
  Future getAutocomplete(String acquery) {
    Completer completer = new Completer();
    
    String query = _autocompleteURL + "aq?query=" + acquery;        
    
    _client.getUrl(Uri.parse(query))
      .then((HttpClientRequest request) {
        return request.close();
      })
      .then((HttpClientResponse response) {
        response.transform(new StringDecoder()).toList().then((data) {          
          String body = data.join('');
          var parsedList = parse(body);
          completer.complete(parsedList['RESULTS']);
        });        
      });
    return timeout(completer.future, _timeout);
  }
  
  Future makeAPIKeyCall(String apiName) {
    Completer completer = new Completer();
    
    String query = _apiURL + _apiKey + "/" + apiName + "/q/" + _locQuery + ".json";
    _client.getUrl(Uri.parse(query))
      .then((HttpClientRequest request) {
        return request.close();
      })
      .then((HttpClientResponse response) {
        response.transform(new StringDecoder()).toList().then((data) {          
          String body = data.join('');
          var parsedList = parse(body);
          if(parsedList['response']['error'] != null) {
            if(parsedList['response']['error']['type'] == 'keynotfound') {
              throw new KeyNotFound(parsedList['response']['error']['description']);
            } else if(parsedList['response']['error']['type'] == 'querynotfound') {
              throw new QueryNotFound(parsedList['response']['error']['description']);
            } else {
              throw new UnknownException(); 
            }
          } else {
            String dataKey = parsedList['response']['features'].keys.first; 
            completer.complete(parsedList[_apiMap[dataKey]]);
          }
        });        
      });
    return timeout(completer.future, _timeout);
  }
}