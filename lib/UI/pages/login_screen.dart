// lib/UI/pages/login_screen.dart - VERSIONE FINALE
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nomeController = TextEditingController();

  bool _isLogin = true;
  bool _isLoading = false;
  bool _passwordVisible = false;
  String? _messaggio;

  void _toggleModalita() {
    setState(() {
      _isLogin = !_isLogin;
      _messaggio = null;
      _formKey.currentState?.reset();
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _messaggio = null;
    });

    try {
      if (_isLogin) {
        // 🔐 LOGIN
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
        _messaggio = '✅ Accesso riuscito!';
      } else {
        // 📝 REGISTRAZIONE
        final userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );

        // Aggiorna nome se fornito
        if (_nomeController.text.trim().isNotEmpty) {
          await userCredential.user?.updateDisplayName(
              _nomeController.text.trim()
          );
        }

        _messaggio = '✅ Account creato! Benvenuto!';
      }

      // ✅ Successo - AppRouter mostrerà automaticamente Layout

    } on FirebaseAuthException catch (e) {
      // ❌ Gestione errori
      String messaggioErrore;
      switch (e.code) {
        case 'user-not-found':
          messaggioErrore = 'Utente non trovato';
          break;
        case 'wrong-password':
          messaggioErrore = 'Password errata';
          break;
        case 'email-already-in-use':
          messaggioErrore = 'Email già registrata';
          break;
        case 'weak-password':
          messaggioErrore = 'Password troppo debole (min. 6 caratteri)';
          break;
        case 'invalid-email':
          messaggioErrore = 'Email non valida';
          break;
        case 'user-disabled':
          messaggioErrore = 'Account disabilitato';
          break;
        case 'too-many-requests':
          messaggioErrore = 'Troppi tentativi. Riprova più tardi';
          break;
        default:
          messaggioErrore = 'Errore: ${e.message}';
      }

      setState(() {
        _messaggio = '❌ $messaggioErrore';
      });
    } catch (e) {
      setState(() {
        _messaggio = '❌ Errore: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _resetPassword() async {
    if (_emailController.text.isEmpty) {
      setState(() {
        _messaggio = '❌ Inserisci email per reset password';
      });
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );
      setState(() {
        _messaggio = '✅ Email di reset inviata! Controlla la posta';
      });
    } catch (e) {
      setState(() {
        _messaggio = '❌ Errore invio email: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),

                // 📚 LOGO
                const Icon(Icons.book, size: 80, color: Colors.pink),
                const SizedBox(height: 16),
                const Text(
                  'NovelArchitect',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _isLogin ? 'Accedi al tuo account' : 'Crea nuovo account',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 32),

                // 👤 NOME (solo registrazione)
                if (!_isLogin)
                  TextFormField(
                    controller: _nomeController,
                    decoration: const InputDecoration(
                      labelText: 'Nome (opzionale)',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                if (!_isLogin) const SizedBox(height: 16),

                // 📧 EMAIL
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Inserisci la email';
                    }
                    if (!value.contains('@')) {
                      return 'Email non valida';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // 🔐 PASSWORD
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Inserisci la password';
                    }
                    if (value.length < 6) {
                      return 'Minimo 6 caratteri';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),

                // 🔗 RESET PASSWORD (solo login)
                if (_isLogin)
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: _resetPassword,
                      child: const Text('Password dimenticata?'),
                    ),
                  ),

                const SizedBox(height: 24),

                // 🎯 BOTTONE
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      foregroundColor: Colors.white,
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(_isLogin ? 'Accedi' : 'Registrati'),
                  ),
                ),

                const SizedBox(height: 16),

                // 📝 MESSAGGIO
                if (_messaggio != null)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _messaggio!.startsWith('✅')
                          ? Colors.green.shade50
                          : Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _messaggio!.startsWith('✅')
                              ? Icons.check_circle
                              : Icons.error,
                          color: _messaggio!.startsWith('✅')
                              ? Colors.green
                              : Colors.red,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _messaggio!,
                            style: TextStyle(
                              color: _messaggio!.startsWith('✅')
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 24),

                // 🔄 CAMBIO MODALITÀ
                TextButton(
                  onPressed: _isLoading ? null : _toggleModalita,
                  child: Text(
                    _isLogin
                        ? 'Nuovo utente? Registrati'
                        : 'Hai già un account? Accedi',
                    style: const TextStyle(color: Colors.pink),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nomeController.dispose();
    super.dispose();
  }
}