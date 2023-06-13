import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'back4app/ceps_back4app_repository.dart';

Future<Map<String, dynamic>> consultarCep(String cep) async {
  final response =
      await http.get(Uri.parse('https://viacep.com.br/ws/$cep/json/'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Falha ao consultar o CEP');
  }
}

void main() async {
  // Certifique-se de chamar o método `WidgetsFlutterBinding.ensureInitialized`
  // antes de usar qualquer código assíncrono no método `main`
  WidgetsFlutterBinding.ensureInitialized();

  final repository = CEPSBack4AppRepository();
  final ceps = await repository.getCPFs();

  for (final cep in ceps.results) {
    print(cep.cep);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Consulta CEP',
      home: MyHomePage(key: Key('my_home_page'), title: 'Consulta CEP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({required Key key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _cepController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _cepController,
              decoration: const InputDecoration(labelText: 'CEP'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira o CEP';
                }
                if (!RegExp(r'^[0-9]{5}-[0-9]{3}$').hasMatch(value)) {
                  return 'Por favor, insira um CEP válido';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState?.validate() == true) {
                  try {
                    final endereco = await consultarCep(_cepController.text);
                    if (endereco['localidade'] == null) {
                      // Trate o erro aqui
                      // Exemplo: exibir uma mensagem de erro
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('CEP não encontrado')),
                      );
                    } else {
                      // Use os dados do endereço aqui
                      // Exemplo: exibir o nome da cidade
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Cidade: ${endereco['localidade']}')),
                      );
                    }
                  } catch (e) {
                    // Trate o erro aqui
                    // Exemplo: exibir uma mensagem de erro
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('CEP não encontrado')),
                    );
                  }
                }
              },
              child: Text('Consultar'),
            ),
          ],
        ),
      ),
    );
  }
}
