import "../lib/weather_underground_api.dart";
import "dart:collection";

WeatherUnderground wu;

void main() {
  print("WeatherUnderground Tests!");
   
  // You will need to place your own weather undergound API key in place of the x's
  wu = new WeatherUnderground("xxx", "84096");

 
  wu.getConditions().then((LinkedHashMap val) {
    print(val.toString());
  } );
  
  wu.getAlerts().then((List val) {
    print(val.toString());
  } );
  
  wu.getAlmanac().then((LinkedHashMap val) {
    print(val.toString());
  } );
  
  wu.getAstronomy().then((LinkedHashMap val) {
    print(val.toString());
  } );  
  
  wu.getCurrentHurricane().then((List val) {
    print(val.toString());
  } );    

  wu.getForecast().then((LinkedHashMap val) {
    print(val.toString());
  } ); 
  
  wu.getForecast10Day().then((LinkedHashMap val) {
    print(val.toString());
  } );    

  wu.getGeoLookup().then((LinkedHashMap val) {
    print(val.toString());
  } );
    
  wu.getHistory(new DateTime(2000,1,1)).then((LinkedHashMap val) {
    print(val.toString());
  } );

  wu.getHourly().then((List val) {
    print(val.toString());
  } );  

  wu.getHourly10Day().then((List val) {
    print(val.toString());
  } );   

  wu.getPlanner(7,11,7,15).then((LinkedHashMap val) {
    print(val.toString());
  } );   

  wu.getRawTide().then((LinkedHashMap val) {
    print(val.toString());
  } );  
  
  wu.getSatellite().then((LinkedHashMap val) {
    print(val.toString());
  } );  

  wu.getTide().then((LinkedHashMap val) {
    print(val.toString());
  } );   

  wu.getWebcams().then((List val) {
    print(val.toString());
  } );    
   
  wu.getYesterday().then((LinkedHashMap val) {
    print(val.toString());
  } );    
  
}