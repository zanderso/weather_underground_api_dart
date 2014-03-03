library weather_underground_api_html;

import "dart:html";
import "dart:convert";
import "dart:async";

class QueryNotFoundException implements Exception {
  final String msg;
  const QueryNotFoundException([this.msg]);
  String toString() =>
      (msg == null) ? "QueryNotFoundException"
                    : "QueryNotFoundException: ${msg}";
}


// "
class KeyNotFoundException implements Exception {
  final String msg;
  const KeyNotFoundException([this.msg]);
  String toString() =>
      msg == null ? "KeyNotFoundException"
                  : "KeyNotFoundException: ${msg}";
}


// "
class UnknownException implements Exception {
  final String msg;
  const UnknownException([this.msg]);
  String toString() =>
      (msg == null) ? "UnknownException" :
                      "UnknownException: ${msg}";
}


// "
class TimeoutException implements Exception {
  final String msg;
  const TimeoutException([this.msg]);
  String toString() =>
      (msg == null) ? "TimeoutException"
                    : "TimeoutException: ${msg}";
}

/**
 * Interface to the WeatherUnderground API.
 * 
 * This class implements an interface to the WeatherUnderground API defined at http://www.wunderground.com/weather/api/d/docs."
 */
class WeatherUnderground {
  static const _apiURL= "http://api.wunderground.com/api/";
  static const _autocompleteURL= "http://autocomplete.wunderground.com/";
  String _apiKey;
  String _locQuery;
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
  
   /// Set the query string for this instance.
   /// 
   /// Unfortunately, WU does not define this very well, as a result, the safest thing is to provide
   /// a query result string from an autocomplete, as it should be reliable.
  void setLocationQuery(String locationQuery) {
    _locQuery = locationQuery;
  }
  
  /// Set the default time for HTTP requests to timeout if no response is received.
  /// This value is provided in milliseconds and has a default value of 2000 (2 seconds.)
  void setTimeout(int timeout) {
    _timeout = timeout;
  }
  
  /// Constructor
  /// Takes one required parameter which is the API key which must be attained from WeatherUnderground.
  /// Also, a second optional paramter indicating the location query may be provided (and in most cases should be).
  WeatherUnderground(String apiKey, [String locationQuery]) {
    locationQuery = locationQuery == null ? "" : locationQuery;
    _apiKey = apiKey;
    setLocationQuery(locationQuery);
    _timeout = 2000;
  }
  
  /// Returns any severe alerts issued for the queried location (US an EU only.)
  /// Uses NWS VTEC codes.
  Future getAlerts() {
    return _makeAPIKeyCall('alerts');
  }  
  
  /// Historical average temperature for TODAY.
  Future getAlmanac() {
    return _makeAPIKeyCall('almanac');
  }
  
  /// Returns the moon phase, sunrise, and sunset times.
  Future getAstronomy() {
    return _makeAPIKeyCall('astronomy');
  }
  
  /// Returns comprehensive weather information for right now.
  Future getConditions() {
    return _makeAPIKeyCall('conditions');
  }
  
  /// Returns information about current hurricanes and tropical storms.
  Future getCurrentHurricane() {
    return _makeAPIKeyCall('currenthurricane');
  }
  
  /// Returns a summary of the weather for the next 3 days.
  Future getForecast() {
    return _makeAPIKeyCall('forecast');
  }
  
  /// Returns a summary of the weather for the next 10 days.
  Future getForecast10Day() {
    return _makeAPIKeyCall('forecast');    
  }
  
  /// Returns geographic information based on the current query.
  Future getGeoLookup() {
    return _makeAPIKeyCall('geolookup');
  }
  
  /// Returns a summary of the observed weather for a specific date.
  /// Requires a DateTime object, but only the year, month, and day fields are used.
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
    return _makeAPIKeyCall('history_${s}');
  }
  
  /// Provides hourly data information.
  Future getHourly() {
    return _makeAPIKeyCall('hourly');
  }
  
  /// Provides hourly data for the next 10 days.
  Future getHourly10Day() {
    return _makeAPIKeyCall('hourly10day');
  }  
  
  /// Returns a weather summary based on histroical information between the two specified dates.
  /// The dates must be no more than 30 days apart.
  /// Takes 4 numeric parameters represending the start and end month and days.
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
    return _makeAPIKeyCall('planner_${s}');
  }

  /// Raw tidal information for use in graphing etc.
  Future getRawTide() {
    return _makeAPIKeyCall('rawtide');
  }    

  /// Returns a URL link to .gif visual and ifrared satellite images.
  Future getSatellite() {
    return _makeAPIKeyCall('satellite');
  }    

  /// Current tidal information.
  Future getTide() {
    return _makeAPIKeyCall('tide');
  }      

  /// Returns the locations of nearby PWS andd URLS for their webcam images.
  Future getWebcams() {
    return _makeAPIKeyCall('webcams');
  }        

  /// Returns a summary of the observed weather history for yesterday.
  Future getYesterday() {
    return _makeAPIKeyCall('yesterday');
  }        
  
  /// Because once in a great while these requests never complete, and it is bad form with a future
  /// to never respond, this function can wrap a future and throw a TimeoutException if it fails to
  /// complete before the timer expires.
  /// Takes two parameters, a Future to wrap and the number of milliseconds to expire in.
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
  
  /// Handles making the call to the autocomplete API
  /// Takes one required parameter representing the string to search on.
  Future getAutocomplete(String acquery) {
    Completer completer = new Completer();
    
    String query = _autocompleteURL + "aq?query=" + acquery;        

    HttpRequest.getString(query).then((responseText) {
      var parsedJson = JSON.decode(responseText);
      completer.complete(parsedJson['RESULTS']);
    });

    return timeout(completer.future, _timeout);
  }
  
  /// Handles making calls to the standard API
  /// In general you will not directly call this method, but should rather be called by the various
  /// getter helper methods defined in this class.
  Future _makeAPIKeyCall(String apiName) {
    Completer completer = new Completer();
    
    String query = _apiURL + _apiKey + "/" + apiName + "/q/" + _locQuery + ".json";

    HttpRequest.getString(query).then((responseText) {
      var parsedList = JSON.decode(responseText);
      if(parsedList['response']['error'] != null) {
        if(parsedList['response']['error']['type'] == 'keynotfound') {
          completer.completeError(new KeyNotFoundException(parsedList['response']['error']['description']));
        } else if(parsedList['response']['error']['type'] == 'querynotfound') {
          completer.completeError(new QueryNotFoundException(parsedList['response']['error']['description']));
        } else {
          completer.complete(new UnknownException()); 
        }
      } else {
        String dataKey = parsedList['response']['features'].keys.first; 
        completer.complete(parsedList[_apiMap[dataKey]]);
      }
    });

    return timeout(completer.future, _timeout);
  }
}