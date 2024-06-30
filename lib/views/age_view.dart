import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GenderView extends StatefulWidget {
  @override
  _GenderViewState createState() => _GenderViewState();
}

class _GenderViewState extends State<GenderView> {
  final _controller = TextEditingController();
  String _gender = '';
  Color _bgColor = Colors.white;

  void _predictGender() async {
    final name = _controller.text;
    final response = await http.get(Uri.parse('https://api.genderize.io/?name=$name'));
    final data = jsonDecode(response.body);

    setState(() {
      _gender = data['gender'];
      _bgColor = _gender == 'male' ? Colors.blue[100]! : Colors.pink[100]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Predict Gender'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: _bgColor,
        padding: EdgeInsets.all(20), // Añadir padding alrededor del cuerpo
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Enter Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 20), // Espacio entre el TextField y el botón
              ElevatedButton(
                onPressed: _predictGender,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: _gender == 'male' ? Colors.blue : Colors.pink, // Color del texto del botón
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Ajustar el tamaño del botón
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Predict',
                  style: TextStyle(fontSize: 20), // Tamaño del texto del botón
                ),
              ),
              SizedBox(height: 20), // Espacio entre el botón y el texto de género
              Text(
                _gender.isNotEmpty ? 'Gender: $_gender' : '',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // Estilo del texto de género
              ),
            ],
          ),
        ),
      ),
    );
  }
}
