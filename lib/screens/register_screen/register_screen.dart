import 'package:flutter/material.dart';
import 'package:login_api/Users/user.dart';
import 'package:login_api/controllers/register_controller.dart';
import 'package:login_api/screens/common/dialog_exceptions.dart';
import 'package:login_api/screens/login_screen/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _cpfController = TextEditingController();
  final _numberController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
                  "Cadastro",
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
                          validator: (valueName) {
                            if (validatorControllers(valueName)) {
                              return "Campo obrigatório";
                            }
                            return null;
                          },
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: "Nome",
                            prefixIcon: Icon(Icons.person),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                        TextFormField(
                          validator: (valueCpf) {
                            if (validatorControllers(valueCpf)) {
                              return "Campo obrigatório";
                            } else if (valueCpf != null) {
                              if (valueCpf.length != 11) {
                                return "CPF inválido";
                              }
                            }
                            return null;
                          },
                          controller: _cpfController,
                          decoration: const InputDecoration(
                            labelText: "CPF",
                            prefixIcon: Icon(Icons.indeterminate_check_box),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        TextFormField(
                          validator: (valueNumber) {
                            if (validatorControllers(valueNumber)) {
                              return "Campo obrigatório";
                            }
                            return null;
                          },
                          controller: _numberController,
                          decoration: const InputDecoration(
                            labelText: "Celular",
                            prefixIcon: Icon(Icons.phone_iphone_outlined),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        TextFormField(
                          validator: (valueEmail) {
                            if (validatorControllers(valueEmail)) {
                              return "Campo obrigatório";
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
                              return "Campo obrigatório";
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
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: 70),
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
                                register(context);
                              }
                            },
                            child: const Text(
                              "Confirmar",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
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

  register(BuildContext context) async {
    RegisterController controller = RegisterController();

    User user = User(
        userName: _nameController.text,
        userCpf: int.parse(_cpfController.text),
        userNumber: int.parse(_numberController.text),
        email: _emailController.text,
        password: _passwordController.text);

    try {
      await controller.register(user).then(
        (valueRegister) {
          if (valueRegister) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Usuário cadastrado com sucesso!"),
              ),
            );
          }
        },
      );
    } on EmailAlreadyExistsException {
      showExceptionDialog(
          context, "Já existe uma conta com o e-mail informado");
    }
  }
}
