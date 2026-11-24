
import 'package:flutter/material.dart';
import 'bloc/login_bloc.dart';
import 'bloc/logout_bloc.dart';
import 'helpers/user_info.dart';

void main() {
  runApp(const TestAuthApp());
}

class TestAuthApp extends StatelessWidget {
  const TestAuthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pengujian Login',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController(
    text: 'john@example.com',
  );

  final passwordController = TextEditingController(
    text: 'password123',
  );

  final LoginBloc loginBloc = LoginBloc();
  final LogoutBloc logoutBloc = LogoutBloc();
  final UserInfo userInfo = UserInfo();

  String? token;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    cekToken();
  }

  Future<void> cekToken() async {
    final savedToken = await userInfo.getToken();

    if (!mounted) return;

    setState(() {
      token = savedToken;
    });
  }

  Future<void> login() async {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email dan password wajib diisi')),
      );
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      await loginBloc.login({
        'email': emailController.text.trim(),
        'password': passwordController.text,
      });

      final savedToken = await userInfo.getToken();

      if (!mounted) return;

      setState(() {
        token = savedToken;
        loading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            savedToken != null
                ? 'Login berhasil dan token tersimpan'
                : 'Login berhasil, tetapi token tidak ditemukan',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        loading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login gagal: $e')),
      );
    }
  }

  Future<void> logout() async {
    setState(() {
      loading = true;
    });

    try {
      await logoutBloc.logout();

      if (!mounted) return;

      setState(() {
        token = null;
        loading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Logout berhasil, token telah dihapus'),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        loading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logout gagal: $e')),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengujian Login'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: SizedBox(
            width: 450,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.account_circle,
                  size: 80,
                  color: Colors.blue,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Login API',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: loading ? null : login,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: loading
                        ? const CircularProgressIndicator()
                        : const Text('Login'),
                  ),
                ),
                const SizedBox(height: 24),
                const Divider(),
                const Text(
                  'Status Shared Preferences',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  token != null
                      ? 'Token berhasil tersimpan'
                      : 'Belum ada token tersimpan',
                  style: TextStyle(
                    color: token != null ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                if (token != null)
                  SelectableText(
                    'Token: $token',
                    maxLines: 3,
                  ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: loading || token == null ? null : logout,
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout dan Hapus Token'),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: loading ? null : cekToken,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Periksa Token'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
