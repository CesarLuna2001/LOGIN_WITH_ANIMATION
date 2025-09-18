import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Estado para mostrar u ocultar la contraseña
  bool _isPasswordVisible = false;

  //Cerebro de la logica de las animaciones 
  StateMachineController? controller;
  SMIBool? isChecking; //Activa el modo chismoso
  SMIBool? isHandsUp; //Se tapa los ojos
  SMITrigger? trigSuccess; //Animacion de exito (se emociona)
  SMITrigger? trigFail; //Animacion de fracaso (se pone sad)

  @override
  Widget build(BuildContext context) {
    //Consulta el tamaño de la pantalla 
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                width: size.width,
                height: 200,
                child: RiveAnimation.asset(
                  'assets/animated_login_character.riv',
                  stateMachines: ["Login Machine"],
                  //Al iniciarse
                  onInit: (artboard) {
                    controller = StateMachineController.fromArtboard(
                      artboard, "Login Machine",
                    );
                    //verificar que inicie bien 
                    if (controller == null) return;
                    artboard.addController(controller!);
                    isChecking = controller!.findSMI("isChecking");
                    isHandsUp = controller!.findSMI("isHandsUp");
                    trigSuccess = controller!.findSMI("trigSuccess");
                    trigFail = controller!.findSMI("trigFail");
                  },
                ),
              ),
              const SizedBox(height: 10),
              // Campo de texto del Email
              TextField(
                onChanged: (value) {
                  if (isHandsUp != null) {
                    //No tapar los ojos al escribir el email
                    isHandsUp!.change(false);
                  }
                  if (isChecking == null)  return;
                  //Activar el modo chismoso
                  isChecking!.change(true);
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Campo de texto de Password
              TextField(
                onChanged: (value) {
                  if (isChecking != null) {
                    //No activar el modo chismoso al escribir la contraseña
                    isChecking!.change(false);
                  }
                  if (isHandsUp == null)  return;
                  //Activar el modo taparse los ojos
                  isHandsUp!.change(true);
                },
                obscureText: !_isPasswordVisible, // Cambia según el estado
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  // Icono para mostrar/ocultar contraseña
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Texto de "Forgot Password?"
              SizedBox(
                width: size.width,
                child: const Text(
                  'Forgot Password?',
                  //Alinear a la derecha
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    decoration: TextDecoration.underline
                  )
                )
              ),
              //Botton de Login
              const SizedBox(height: 10),
              MaterialButton(onPressed: (){
                //TODO
              },
                minWidth: size.width,
                height: 50,
                color: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Text(
                  'Login', 
                  style: TextStyle(
                    color: Colors.white)
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account?'),
                    TextButton(
                      onPressed: (){}, 
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.black,
                          //Subrayado
                          fontWeight: FontWeight.bold,
                          //Negritas 
                          decoration: TextDecoration.underline
                        ),
                      )
                    )
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}