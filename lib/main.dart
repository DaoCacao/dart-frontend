import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(const App());
}

class Service {
  final _host = kReleaseMode ? "http://web.daocacao.me" : "http://0.0.0.0:8080";

  Future<String> signUp(String username, String password) async {
    final response = await post(
      Uri.parse("$_host/sign_up"),
      body: jsonEncode({
        "username": username,
        "password": password,
      }),
    );
    final body = jsonDecode(response.body) as Map;
    return body["token"];
  }

  Future<String> signIn(String username, String password) async {
    throw Exception("Not Implemented Yet");
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  final service = Service();

  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _usernameKey = GlobalKey<FormFieldState<String>>();
  final _passwordKey = GlobalKey<FormFieldState<String>>();

  String _token = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter"),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 256,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      key: _usernameKey,
                      controller: TextEditingController(),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Username",
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      key: _passwordKey,
                      controller: TextEditingController(),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Password",
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                child: const Text("Sign Up"),
                onPressed: () async {
                  final token = await widget.service.signUp(
                    _usernameKey.currentState?.value ?? "",
                    _passwordKey.currentState?.value ?? "",
                  );
                  setState(() {
                    _token = token;
                  });
                },
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                child: const Text("Sign In"),
                onPressed: () {},
              ),
              if (_token.isNotEmpty) ...[
                Text(_token),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
