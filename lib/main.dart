import 'package:flutter/material.dart';
import 'views/gender_view.dart';
import 'views/age_view.dart';
import 'views/university_view.dart';
import 'views/weather_view.dart';
import 'views/news_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toolbox App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        '/gender': (context) => GenderView(),
        '/age': (context) => AgeView(),
        '/university': (context) => UniversityView(),
        '/weather': (context) => WeatherView(),
        '/news': (context) => NewsView(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toolbox App'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.white, // Set the background color here
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/toolbox.jpg'),
            SizedBox(height: 20), // Add space between the image and the first button
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/gender');
              },
              child: Text('Predict Gender'),
            ),
            SizedBox(height: 10), // Add space between buttons
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/age');
              },
              child: Text('Predict Age'),
            ),
            SizedBox(height: 10), // Add space between buttons
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/university');
              },
              child: Text('List Universities'),
            ),
            SizedBox(height: 10), // Add space between buttons
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/weather');
              },
              child: Text('Weather in RD'),
            ),
            SizedBox(height: 10), // Add space between buttons
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/news');
              },
              child: Text('Latest News'),
            ),
          ],
        ),
      ),
    );
  }
}
