import 'package:flutter/material.dart';
import 'package:frontend/service.dart';

class EnterScreen extends StatefulWidget {
  final Service service;

  const EnterScreen(this.service, {Key? key}) : super(key: key);

  @override
  State<EnterScreen> createState() => _EnterScreenState();
}

class _EnterScreenState extends State<EnterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  String _token = "";
  String _error = "";

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
          child: _token.isEmpty
              ? _unauthorizedState(context)
              : _authorizedState(context),
        ),
      ),
    );
  }

  Widget _unauthorizedState(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Username",
                ),
                validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return "Field required";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Password",
                ),
                validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return "Field required";
                  } else {
                    return null;
                  }
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        ElevatedButton(
          child: const Text("Sign Up"),
          onPressed: _onSignUpClick,
        ),
        const SizedBox(
          height: 16,
        ),
        ElevatedButton(
          child: const Text("Sign In"),
          onPressed: _onSignInClick,
        ),
        if (_error.isNotEmpty) ...[
          const SizedBox(
            height: 16,
          ),
          Text(
            _error,
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }

  Widget _authorizedState(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          _token,
          textAlign: TextAlign.center,
        ),
        ElevatedButton(
          child: const Text("Logout"),
          onPressed: _onLogoutClick,
        ),
      ],
    );
  }

  void _onSignUpClick() async {
    if (_formKey.currentState!.validate()) {
      try {
        final token = await widget.service.signUp(
          _usernameController.text,
          _passwordController.text,
        );

        _formKey.currentState!.reset();

        setState(() {
          _token = token;
          _error = "";
        });
      } catch (e) {
        setState(() {
          _error = e.toString();
        });
      }
    }
  }

  void _onSignInClick() async {
    if (_formKey.currentState!.validate()) {
      try {
        final token = await widget.service.signIn(
          _usernameController.text,
          _passwordController.text,
        );

        _formKey.currentState!.reset();

        setState(() {
          _token = token;
          _error = "";
        });
      } catch (e) {
        setState(() {
          _error = e.toString();
        });
      }
    }
  }

  void _onLogoutClick() async {
    setState(() {
      _token = "";
    });
  }
}
