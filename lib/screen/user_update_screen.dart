import 'package:flutter/material.dart';

import '../model/user_list_model.dart';
import '../service/api_service.dart';

class UpdateUserScreen extends StatefulWidget {
  final Users user;

  const UpdateUserScreen({super.key, required this.user});

  @override
  State<UpdateUserScreen> createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  final ApiService apiService = ApiService();

  final _formKey = GlobalKey<FormState>();

  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController usernameController;
  late TextEditingController emailController;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: widget.user.firstName ?? '');
    lastNameController = TextEditingController(text: widget.user.lastName ?? '');
    usernameController = TextEditingController(text: widget.user.username ?? '');
    emailController = TextEditingController(text: widget.user.email ?? '');
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> updateUser() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    try {
      final body = {
        'firstName': firstNameController.text.trim(),
        'lastName': lastNameController.text.trim(),
        'username': usernameController.text.trim(),
        'email': emailController.text.trim(),
      };
      final response = await apiService.updateUser(widget.user.id!, body);
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User ${response.id} updated successfully')),);
      Navigator.pop(context, response);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context,).showSnackBar(SnackBar(content: Text('Update failed: $e')));
    }
  }

  InputDecoration decoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      filled: true,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update User'), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Icon(Icons.edit, size: 20, color: Colors.blue),
                ),
                const SizedBox(height: 11),
                Center(
                  child: const Text(
                    'Update User',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 25),
                const Text(
                  'First Name',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: firstNameController,
                  decoration: decoration(
                    'Enter first name',
                    Icons.person_outline,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter first name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),
                const Text(
                  'Last Name',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: lastNameController,
                  decoration: decoration(
                    'Enter last name',
                    Icons.person_outline,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter last name';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 18),
                const Text(
                  'Username',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: usernameController,
                  decoration: decoration(
                    'Enter username',
                    Icons.account_circle_outlined,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter username';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),
                const Text(
                  'Email',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: decoration('Enter email', Icons.email_outlined),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter email';
                    }
                    if (!value.contains('@')) {
                      return 'Enter valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : updateUser,
                    child: isLoading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Update User',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
