import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
//3.1 importar libreria timer
import 'dart:async';

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
  //2.1 Variable para el recorrido de la maquina 
  SMINumber? numLook; //Hacia donde mira


  // 1) FocusNode 
  final emailFocus = FocusNode();
  final passFocus = FocusNode();

  // 3.2 Crear una variable timer para detener la mirada al terminar de teclear
  Timer? _typingDebounce; 

  // 4.1 Declarar la variable controller 
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController(); 
  
  // 4.2 Errores para mostrar en la UI
  String? emailError;
  String? passError;

// 4.3 Validadores
  bool isValidEmail(String email) {
    final re = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    return re.hasMatch(email);
  }

  bool isValidPassword(String pass) {
    // mínimo 8, una mayúscula, una minúscula, un dígito y un especial
    final re = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z0-9]).{8,}$',
    );
    return re.hasMatch(pass);
  }

  // 4.4 Accion al boton
  void _onLogin(){
    final email = emailCtrl.text.trim();
    final pass = passCtrl.text;

    //Recalcular errores
    final eError = isValidEmail(email) ? null : 'Email invaldio';
    final pError = isValidPassword(pass) ? null : 'Minimo 8 caracteres, 1 mayuscula, 1 minuscula, 1 numero y 1 caracter especial'; 

    // 4.5 Para avisar que hubo un cambio
    setState(() {
      emailError = eError;
      passError = pError;
    });

    // 4.6 Cerrar el teclado y bajar
    FocusScope.of(context).unfocus();
    _typingDebounce?.cancel();
    isChecking?.change(false); 
    isHandsUp?.change(false); 
    numLook?.value = 50.0; //Mirada neutral 

    //4.7 Activar Triggers
    if (eError == null && pError == null) {
      trigSuccess?.fire();
    } else {
      trigFail?.fire(); 
    }
  }


  // 2) Listeners (Oyentes/Chismosos)
  @override
  void initState() {
    super.initState();
    emailFocus.addListener((){
      if (emailFocus.hasFocus){
        //Manos abajo en el email
        isHandsUp?.change(false);
        // 2.2 mirada neutral al enfocar el email 
        numLook?.value = 50.0;
        isHandsUp?.change(false);
      }
    });
    passFocus.addListener((){
      //manos arriba en el password
      isHandsUp?.change(passFocus.hasFocus);
    });
  }


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
                    // 2.3 Inicializar la variable de mirada
                    numLook = controller!.findSMI("numLook");
                  },
                ),
              ),
              const SizedBox(height: 10),
              // Campo de texto del Email
              TextField(
                // 3) Asignar el FocusNode
                // Llama a la familia chismosa
                focusNode: emailFocus,
                // 4.8 Enlazar controller al TextField
                controller: emailCtrl,
                onChanged: (value) {
                    // 2.4 implementando el numLook 
                    //No tapar los ojos al escribir el email
                    //isHandsUp!.change(false);
                    //Estoy escribiendo
                    isChecking!.change(true);

                    // ajustar el limite de 0 a 100
                    final look = (value.length / 160 * 100).clamp(0.0, 100.0);
                    numLook?.value = look;

                    // 3.3 Debounce si value al teclear, reinicia el contador 
                    _typingDebounce?.cancel(); //Cancelar cualquier timer existente
                    _typingDebounce = Timer(const Duration(seconds: 3), (){
                      if (!mounted){
                        return; // si la pantalla se cierra 
                      }
                      //Mirada neutra 
                      isChecking?.change(false);
                    });
                  
                  if (isChecking == null)  return;
                  //Activar el modo chismoso
                  isChecking!.change(true);
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  // 4.9 Mostrar el texto del error
                  errorText: emailError,
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
                // 3) Asignar el FocusNode
                // Llama a la familia chismosa
                focusNode: passFocus,
                // 4.8 Enlazar controller al TextField
                controller: passCtrl,
                onChanged: (value) {
                  if (isChecking != null) {
                    //No activar el modo chismoso al escribir la contraseña
                    //isChecking!.change(false);
                  }

                },
                obscureText: !_isPasswordVisible, // Cambia según el estado
                decoration: InputDecoration(
                  //4.9 Mostrar el texto del error
                  errorText: passError,
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
              MaterialButton(onPressed: _onLogin,
                minWidth: size.width,
                height: 50,
                color: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
                ),
                // 4.10 Llamar a la funcion de 
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
  // 4) Liberar recursos
  @override
  void dispose() {
    emailFocus.dispose();
    passFocus.dispose();
    _typingDebounce?.cancel();
    emailCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }
}