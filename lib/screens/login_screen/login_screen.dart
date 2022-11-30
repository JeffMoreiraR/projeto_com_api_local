import 'package:flutter/material.dart';
import 'package:login_api/screens/common/dialog_exceptions.dart';
import 'package:login_api/screens/home_screen/home_screen.dart';
import 'package:login_api/controllers/login_controller.dart';
import 'package:login_api/screens/register_screen/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  LoginController loginController = LoginController();

  bool validatorControllers(var value) {
    if (value != null && value == "") {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.deepPurple,
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                child: const Text(
                  "My App",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                margin: const EdgeInsets.only(top: 150),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          validator: (valueEmail) {
                            if (validatorControllers(valueEmail)) {
                              return "E-mail obrigatório";
                            }
                            return null;
                          },
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: "E-mail",
                            prefixIcon: Icon(Icons.email),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          validator: (valuePassword) {
                            if (validatorControllers(valuePassword)) {
                              return "Senha obrigatória";
                            }
                            return null;
                          },
                          obscureText: true,
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: "Senha",
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.remove_red_eye_sharp),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: () {},
                          child: const Text("Esqueceu a senha?",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 16,
                              )),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(10),
                              elevation: 10,
                              backgroundColor: Colors.deepPurple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                login(context);
                              }
                            },
                            child: const Text(
                              "Entrar",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "register");
                            },
                            child: const Text(
                              "Não possui uma conta? Registre-se",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  login(BuildContext context) async {
    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      await loginController.login(email, password).then(
        (loginResult) {
          if (loginResult) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(userEmail: email),
              ),
            );
          }
        },
      );
    } on UserNotFindException {
      showExceptionDialog(context, "Usuário não encontado, verifique os dados ou registre-se");
    } on IncorrecPasswordException {
      showExceptionDialog(
          context, "E-mail e/ou senha inválidos, tente novamente");
    }

    // ESSE BLOCO DE CÓDIGO NÃO FUNCIONA, NÃO ESTÁ TRATANDO A EXCEÇÃO
    // await loginController.login(email, password).then(
    //   (loginResult) {
    //     if (loginResult) {
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => HomeScreen(userEmail: email),
    //         ),
    //       );
    //     }
    //   },
    // ).catchError((error) {
    //   print("USUÁRIO NÃO CADASTRADO");
    // }, test: (error) => error is UserNotFindException);
  }
}
