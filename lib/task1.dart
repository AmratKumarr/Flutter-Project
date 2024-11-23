import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FormScreen(),
    );
  }
}

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cnicController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _cnicController.dispose();
    _contactController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name cannot be empty';
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return 'Name should contain only alphabetic characters';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validateCNIC(String? value) {
    if (value == null || value.isEmpty) {
      return 'CNIC cannot be empty';
    }
    if (!RegExp(r'^\d{13}$').hasMatch(value)) {
      return 'CNIC must be exactly 13 digits';
    }
    return null;
  }

  String? _validateContact(String? value) {
    if (value == null || value.isEmpty) {
      return 'Contact number cannot be empty';
    }
    if (!RegExp(r'^\d{10,12}$').hasMatch(value)) {
      return 'Contact number should be 10-12 digits';
    }
    return null;
  }

  String? _validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Address cannot be empty';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
        .hasMatch(value)) {
      return 'Password must contain letters, numbers, and symbols';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mutliple TextField Example"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                inputFormatters: [
                  //  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-z]'))
                ],
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
                validator: _validateName,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                inputFormatters: [
                  //  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-z@.0-9]'))
                ],
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                validator: _validateEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                inputFormatters: [
                  //  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                  FilteringTextInputFormatter.digitsOnly
                ],
                controller: _cnicController,
                decoration: const InputDecoration(
                  labelText: "CNIC",
                  border: OutlineInputBorder(),
                ),
                validator: _validateCNIC,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                inputFormatters: [
                  //  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                  FilteringTextInputFormatter.digitsOnly
                ],
                controller: _contactController,
                decoration: const InputDecoration(
                  labelText: "Contact Number",
                  border: OutlineInputBorder(),
                ),
                validator: _validateContact,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                inputFormatters: [
                  //  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                  FilteringTextInputFormatter.allow(
                      RegExp(r'[a-zA-z0-9@#$%^*()]'))
                ],
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: "Address",
                  border: OutlineInputBorder(),
                ),
                validator: _validateAddress,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                inputFormatters: [
                  //  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                  FilteringTextInputFormatter.allow(
                      RegExp(r'[a-zA-z!@#$%^&*()_+}{":?><}0-9]'))
                ],
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                validator: _validatePassword,
                obscureText: true,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Form is valid')),
                    );
                  }
                },
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
