Access the Weather Underground API from your Dart application

This library makes proper use of Futures to ensure non-blocking access to the full WeatherUndergound API (http://www.wunderground.com/weather/api/)

Currently has the following features enabled:
*   alerts
*   almanac
*   astronomy
*   conditions
*   currenthurricane
*   forecast
*   forecast10day
*   geolookup
*   history
*   hourly
*   hourly10day
*   planner
*   rawtide
*   satellite
*   tide
*   webcams
*   yesterday

The following features have not been added yet:
*   radar
*   satellite
*   radar + satellite
*   autocomplete

Also, error checking is abysmal.  All to be improved soon.

### Change Log ###
0.1.2 - Fixed a left behind debug print statement
      - Added very basic error checking for malformed server request URI's
      - Removed strong typing for API results
      
0.1.1 - Minor Cosmetic Changes

0.1.0 - Initial Revision