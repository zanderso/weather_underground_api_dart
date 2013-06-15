Access the Weather Underground API from your Dart application

This library makes proper use of Futures to ensure non-blocking access to the full WeatherUndergound API (http://www.wunderground.com/weather/api/)

Currently has the following features enabled:  alerts, almanac, astronomy, conditions, currenthurricane, forecast, forecast10day, geolookup, history, hourly, hourly10day, planner, rawtide, satellite, tide, webcams, yesterday. 

The following features have not been added yet:  radar, satellite, radar + satellite, autocomplete.

### Exceptions ###
There are currently three exceptions that this API can throw.  Unfortuantely, the WeatherUnderground API documentation does not define any error return values, though it does return some, so more may be added as I come across them.
For now, the following exceptions may be thrown:
- QueryNotFound - Raised if the defined query string does not return an appropriate result for the assigned query.
- KeyNotFound - Raised if the API key provided at instantiation is not valid at WeatherUnderground.
- UnknownException - This should not be seen in the wild, but is provided in the likely case that new errors are discovered.  If you find this being thrown, let me know so I can add more code around it.

### Notes ###
- If your API key does not include access to a particular function, the WeatherUndergound returns no indication that access is not allowed, other than a complete data structure with no values.  
- This library also does no checking to ensure values provided from WeatherUndergound are valid.  This will be addressed in a later version.
- Per the WeatherUndergound Terms Of Service, the WU logo must be included with a credit line where the returned data is displayed.

### TODO ###
- Check that returned values are valid
- Implement radar
- Implement satellite
- Implement radar + satellite
- Implement autocomplete
- Modify returned values to intended types instead of strings
- Implement multiple feature requests
- Include code samples in documentation

### Change Log ###
- 0.1.3 (Not yet released)
    - Added better error handling and documentation
- 0.1.2 
    - Fixed a left behind debug print statement
    - Added very basic error checking for malformed server request URI's
    - Removed strong typing for API results      
- 0.1.1 
    - Minor Cosmetic Changes
- 0.1.0 
    - Initial Revision