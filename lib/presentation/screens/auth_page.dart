import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iconsax/iconsax.dart'; 
import '../../../application/auth_provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitForm(AuthProvider authProvider) {
    if (_formKey.currentState!.validate()) {
      if (authProvider.isSignUp) {
        authProvider.signUpWithEmail(emailController.text.trim(), passwordController.text.trim());
      } else {
        authProvider.signInWithEmail(emailController.text.trim(), passwordController.text.trim());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final isSignUp = authProvider.isSignUp;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.deepPurple.shade50,
                  child: const Icon(Iconsax.security_safe, size: 48, color: Colors.deepPurple),
                ),
                const SizedBox(height: 24),
                Text(
                  isSignUp ? 'Create Account' : 'Welcome Back',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  isSignUp ? 'Please sign up to continue' : 'Sign in to your account',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                const SizedBox(height: 32),
                
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(Iconsax.sms),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty || !value.contains('@')) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(Iconsax.lock),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.length < 6) {
                            return 'Password too short';
                          }
                          return null;
                        },
                      ),
                      if (isSignUp) ...[
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: confirmPasswordController,
                          decoration: const InputDecoration(
                            hintText: 'Confirm Password',
                            prefixIcon: Icon(Iconsax.lock),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value != passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                      ],
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: authProvider.isLoading ? null : () => _submitForm(authProvider),
                        child: authProvider.isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Text(isSignUp ? 'Sign Up' : 'Sign In'),
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton.icon(
                        onPressed: authProvider.isLoading ? null : () => authProvider.signInWithGoogle(),
                        icon: const Icon(Iconsax.home),
                        label: const Text('Continue with Google'),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            isSignUp ? 'Already have an account?' : 'No account?',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                          TextButton(
                            onPressed: () => authProvider.toggleAuthMode(),
                            child: Text(isSignUp ? 'Sign In' : 'Sign Up'),
                          ),
                        ],
                      ),
                    ],
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
