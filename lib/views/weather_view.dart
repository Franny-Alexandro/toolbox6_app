import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherView extends StatefulWidget {
  @override
  _WeatherViewState createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  String _weatherDescription = '';
  String _temperature = '';
  String _locationName = '';
  String _region = '';
  String _country = '';
  String _iconUrl = '';
  final String _apiKey = '57bc305d85dc47bbb0a181916243006'; // Replace with your weather API key

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  void _fetchWeather() async {
    final response = await http.get(
        Uri.parse('http://api.weatherapi.com/v1/current.json?key=$_apiKey&q=Santo%20Domingo'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      setState(() {
        _weatherDescription = data['current']['condition']['text'];
        _temperature = data['current']['temp_c'].toString();
        _locationName = data['location']['name'];
        _region = data['location']['region'];
        _country = data['location']['country'];
        _iconUrl = 'https:${data['current']['condition']['icon']}';
      });
    } else {
      throw Exception('Failed to load weather');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_iconUrl.isNotEmpty)
                          Image.network(
                            _iconUrl,
                            height: 80,
                          ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      _locationName.isNotEmpty ? 'Location: $_locationName' : 'Loading...',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      _region.isNotEmpty ? 'Region: $_region' : '',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      _country.isNotEmpty ? 'Country: $_country' : '',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    Text(
                      _weatherDescription.isNotEmpty ? 'Weather: $_weatherDescription' : 'Loading...',
                      style: TextStyle(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      _temperature.isNotEmpty ? 'Temperature: $_temperature°C' : '',
                      style: TextStyle(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
