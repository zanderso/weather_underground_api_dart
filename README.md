### What is this thing?
This is a library for providing access to the Weather Underground API to [Dart](http://www.dartlang.org/) applications.  
It provides for asynchronous access to the REST API for dart:io based applications, support for dart:html is on the road map for release in June.

### Where can I get it?
You can add it to your project directly in the Dart Editor by including [weather_underground_api](http://pub.dartlang.org/packages/weather_underground_api) in your project.  You can also contribute to the project via [github](https://github.com/iburton/weather_underground_api_dart).

### How do I use it?

```dart
WeatherUndergound wu = new WeatherUnderground("apikeyhere", "84096");

wu.getConditions().then((var val) {
  print(val.toString());
});
```
### Exceptions
There are currently three exceptions that this API can throw.  Unfortuantely, the WeatherUnderground API documentation does not define any error return values, though it does return some, so more may be added as I come across them.
For now, the following exceptions may be thrown:
- QueryNotFound - Raised if the defined query string does not return an appropriate result for the assigned query.
- KeyNotFound - Raised if the API key provided at instantiation is not valid at WeatherUnderground.
- UnknownException - This should not be seen in the wild, but is provided in the likely case that new errors are discovered.  If you find this being thrown, let me know so I can add more code around it.
- TimeoutException - Occurs if an API request takes longer than the timout (default 2000 ms or 2 seconds) to complete.

### Notes
- If your API key does not include access to a particular function, the WeatherUndergound returns no indication that access is not allowed, other than a complete data structure with no values.  
- This library also does no checking to ensure values provided from WeatherUndergound are valid.  This will be addressed in a later version.
- Per the WeatherUndergound Terms Of Service, the WU logo must be included with a credit line where the returned data is displayed.

### TODO
- Check that returned values are valid.  This is to catch the case where a request is made for a feature not supported by the API key license level.  Unfortunately, this does not appear to be easily discerned from the data returned by WU.
- Implement dart:html library support (in addition to dart:io)
- Implement radar
- Implement satellite
- Implement radar + satellite
- Modify returned values to intended types instead of strings
- Implement multiple feature requests
- Include code samples in documentation

### Change Log
- 0.1.5 (not yet released)
    - Added code comments and verified proper generation by the Dartdoc generator    
- 0.1.4
    - Added timeout functionality to handle requests that never come back
    - Autocomplete API implemented
- 0.1.3
    - Added better error handling and documentation
- 0.1.2 
    - Fixed a left behind debug print statement
    - Added very basic error checking for malformed server request URI's
    - Removed strong typing for API results      
- 0.1.1 
    - Minor Cosmetic Changes
- 0.1.0 
    - Initial Revision

### Authors and Contributors
To date, all code has been written by Ira Burton (@iburton), a very rookie Dart programmer.  If something is not working correctly, it is likely because he made some sort of dunderheaded mistake.  Please feel free to thoroughly bash him for all mistakes so he can learn the right way to do it.  There is no pride of authorship here.