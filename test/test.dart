import "../lib/weather_underground_api_io.dart";
import "dart:collection";

WeatherUnderground wu;

void main() {
  print("WeatherUnderground Tests!");
   
  // You will need to place your own weather undergound API key in place of the x's
  wu = new WeatherUnderground("xxx", "37.776289,-122.395234");
  wu.setTimeout(1900);

  wu.getAutocomplete("Sunnyvale, CA").then((var val) {
    print(val.toString());
  });
  
  wu.getConditions().then((var val) {
    print(val['temp_c']);
    print(val['relative_humidity']);
  }).catchError((e) {
    print("An error occurred: ${e.toString()}");
  });
/*  
  wu.getAlerts().then((var val) {
    print(val.toString());
  }).catchError((e) {
    print("An error occurred: ${e.toString()}");
  });
  
  wu.getAlmanac().then((var val) {
    print(val.toString());
  } ).catchError((e) {
    print("An error occurred: ${e.toString()}");
  });
  
  wu.getAstronomy().then((var val) {
    print(val.toString());
  } ).catchError((e) {
    print("An error occurred: ${e.toString()}");
  });  
  
  wu.getCurrentHurricane().then((var val) {
    print(val.toString());
  } ).catchError((e) {
    print("An error occurred: ${e.toString()}");
  });    

  wu.getForecast().then((var val) {
    print(val.toString());
  } ).catchError((e) {
    print("An error occurred: ${e.toString()}");
  }); 
  
  wu.getForecast10Day().then((var val) {
    print(val.toString());
  } ).catchError((e) {
    print("An error occurred: ${e.toString()}");
  });    

  wu.getGeoLookup().then((var val) {
    print(val.toString());
  } ).catchError((e) {
    print("An error occurred: ${e.toString()}");
  });
    
  wu.getHistory(new DateTime(2000,1,1)).then((var val) {
    print(val.toString());
  } ).catchError((e) {
    print("An error occurred: ${e.toString()}");
  });

  wu.getHourly().then((var val) {
    print(val.toString());
  } ).catchError((e) {
    print("An error occurred: ${e.toString()}");
  });  

  wu.getHourly10Day().then((var val) {
    print(val.toString());
  } ).catchError((e) {
    print("An error occurred: ${e.toString()}");
  });   

  wu.getPlanner(7,11,7,15).then((var val) {
    print(val.toString());
  } ).catchError((e) {
    print("An error occurred: ${e.toString()}");
  });   

  wu.getRawTide().then((var val) {
    print(val.toString());
  } ).catchError((e) {
    print("An error occurred: ${e.toString()}");
  });  
  
  wu.getSatellite().then((var val) {
    print(val.toString());
  } ).catchError((e) {
    print("An error occurred: ${e.toString()}");
  });  

  wu.getTide().then((var val) {
    print(val.toString());
  } ).catchError((e) {
    print("An error occurred: ${e.toString()}");
  });   

  wu.getWebcams().then((var val) {
    print(val.toString());
  } ).catchError((e) {
    print("An error occurred: ${e.toString()}");
  });    
   
  wu.getYesterday().then((var val) {
    print(val.toString());
  } ).catchError((e) {
    print("An error occurred: ${e.toString()}");
  });    
  */
}