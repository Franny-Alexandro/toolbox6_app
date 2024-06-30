import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AgeView extends StatefulWidget {
  @override
  _AgeViewState createState() => _AgeViewState();
}

class _AgeViewState extends State<AgeView> {
  final _controller = TextEditingController();
  int _age = 0;
  String _message = '';
  String _image = '';

  void _predictAge() async {
    final name = _controller.text;
    final response = await http.get(Uri.parse('https://api.agify.io/?name=$name'));
    final data = jsonDecode(response.body);

    setState(() {
      _age = data['age'];
      if (_age < 18) {
        _message = 'You are young';
        _image = 'assets/young.jpg';
      } else if (_age < 60) {
        _message = 'You are an adult';
        _image = 'assets/adult.jpg';
      } else {
        _message = 'You are old';
        _image = 'assets/old.jpg';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Predict Age'),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Enter Name',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _predictAge,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue, // Button text color
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Predict'), // Button text
            ),
            SizedBox(height: 20),
            Text(
              _message,
              style: const TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            _image.isNotEmpty ? Image.asset(_image, height: 200) : Container(),
            SizedBox(height: 20),
            Text(
              _age > 0 ? 'Age: $_age' : '',
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
