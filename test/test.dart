import "package:weather_underground_api/weather_underground_api.dart";
import "dart:collection";

WeatherUnderground wu;

void main() {
  print("WeatherUnderground Tests!");
   
  // You will need to place your own weather undergound API key in place of the x's
  wu = new WeatherUnderground("xxx", "84096");


  wu.getConditions().then((var val) {
    print(val.toString());
  });
  
  wu.getAlerts().then((var val) {
    print(val.toString());
  } );

/*  
  wu.getAlmanac().then((var val) {
    print(val.toString());
  } );
  
  wu.getAstronomy().then((var val) {
    print(val.toString());
  } );  
  
  wu.getCurrentHurricane().then((var val) {
    print(val.toString());
  } );    

  wu.getForecast().then((var val) {
    print(val.toString());
  } ); 
  
  wu.getForecast10Day().then((var val) {
    print(val.toString());
  } );    

  wu.getGeoLookup().then((var val) {
    print(val.toString());
  } );
    
  wu.getHistory(new DateTime(2000,1,1)).then((var val) {
    print(val.toString());
  } );

  wu.getHourly().then((var val) {
    print(val.toString());
  } );  

  wu.getHourly10Day().then((var val) {
    print(val.toString());
  } );   

  wu.getPlanner(7,11,7,15).then((var val) {
    print(val.toString());
  } );   

  wu.getRawTide().then((var val) {
    print(val.toString());
  } );  
  
  wu.getSatellite().then((var val) {
    print(val.toString());
  } );  

  wu.getTide().then((var val) {
    print(val.toString());
  } );   

  wu.getWebcams().then((var val) {
    print(val.toString());
  } );    
   
  wu.getYesterday().then((var val) {
    print(val.toString());
  } );    
  */
}