import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather/services/location.dart';
import 'package:weather/services/networking.dart';

String? apiKey = dotenv.env['API_KEY'];
const String openWeatherMapURL = "https://api.openweathermap.org/data/2.5/weather";

class WeatherModel {

  Future<dynamic> getCityWeather(String cityName)async{
    String url = "$openWeatherMapURL?q=$cityName&appid=${apiKey}&units=metric";
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }


  Future<dynamic>getLocationWeather()async{
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper("$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=${apiKey}&units=metric");
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'É hora do 🍦';
    } else if (temp > 20) {
      return 'Hora de vestir shorts e 👕';
    } else if (temp < 10) {
      return 'Você vai precisar de 🧣 e 🧤';
    } else {
      return 'Leve um 🧥 só por precaução';
    }
  }
}
