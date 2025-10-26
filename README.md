# 🐻 Animated Login Screen with Flutter & Rive 🐻
This project was developed as part of the Computer Graphics class. It showcases a fully animated login screen created using Flutter and Rive, combining interactive animations that respond to user behavior. The goal of this project is to demonstrate how graphical elements can interact dynamically through animation states and logic.

## 🚀 Features
The application includes several interactive and visual features that make it stand out:  
✨ Animated Character: A Rive character reacts in real-time as the user types, focuses on inputs, or submits the form.  
🔐 Password Visibility Toggle: The user can easily show or hide the password.  
📧 Input Validation: The app checks that the email format is valid and that the password meets security requirements (uppercase, lowercase, number, and special character).  
✅ Success and Failure Animations: The character performs different animations depending on whether the login attempt succeeds or fails.  
🕐 Typing Detection: A timer detects when the user stops typing and automatically resets the animation to a neutral state.

## 🎥 What is Rive?
Rive is a design and animation platform that allows the creation of real-time, interactive animations. Unlike traditional animation tools, Rive lets designers and developers build animations that can respond directly to user input, gestures, or app logic.
In Flutter, Rive provides a widget that makes it easy to embed and control vector animations. These animations can react to variables or triggers defined within a State Machine, making them ideal for interactive interfaces like login screens or loading screens.

## 🧠 What is a State Machine?
A State Machine in Rive controls how an animation behaves based on logic and user input. It defines multiple states (such as idle, checking, hands up, success, and fail) and transitions between them.
In this project, the State Machine used is called "Login Machine", and it includes the following logic elements:  
🔄 SMIBool → Boolean variables used to change states (e.g., isChecking, isHandsUp).  
👁️ SMINumber → Numerical input controlling the eye direction (numLook).  
🎯 SMITrigger → One-time triggers for specific animations (e.g., trigSuccess, trigFail).  
These elements allow the character to react dynamically as the user interacts with the login form.

## 🛠️ Technologies Used
The main technologies used in this project are:
🐦 Flutter – The main framework for building cross-platform applications with a single codebase.  
🎯 Dart – The programming language used to develop the entire logic and structure of the app.  
🎬 Rive – Used to implement real-time animations and state machine logic.  
💅 Material Design – Provides the visual structure and consistent design style for the interface.  
⏱️ Dart Timer – Handles typing detection to manage animation states after a delay.  
💻 Visual Studio Code – The main code editor used for development, debugging, and project management.

## 🗂️ Project Structure
The project is organized as follows:  
🖼️ assets/ – Stores the animation resources used in the project    
💻 lib/ – Main source folder that contains all the core app files   
📁 main.dart: Entry point of the app. Defines the MaterialApp and loads the LoginScreen.  
📁 screens/login_screen.dart: Main screen containing the login UI, validation logic, and Rive animation control.  
📄 pubspec.yaml: Contains project dependencies, including Rive, Flutter SDK, and asset configuration.  

## 🎥 Demo

![Login Animation Demo](assets/GIF_Graficacion.gif)

Rive animation used in this project: https://rive.app/marketplace/3645-7621-remix-of-login-machine/


## 💡 How It Works
The logic of the animation is directly connected to user interaction:
1.	💻 When the user focuses on the email field, the character looks forward with a neutral expression.
2.	👀 As the user types, the character’s eyes follow the text based on its length.
3.	🙈 When the password field is selected, the character covers its eyes to represent privacy.
4.	🔘 When the Login button is pressed, input validation is performed:
    - ✅ If both fields are valid, the success animation is triggered.
    - ❌ If any field is invalid, the failure animation plays.
This combination of logic and animation creates an engaging and visually appealing user experience.

## 🎓 Course Information
📚Subject: Grafication  
👨‍🏫Instructor: Rodrigo Fidel Gaxiola Sosa
