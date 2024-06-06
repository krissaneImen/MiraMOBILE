Mira Application Flutter

Aperçu
Mira est un nouveau projet Flutter conçu comme un système de gestion administrative pour les établissements d'enseignement supérieur. Ce fichier README vous guidera à travers les étapes nécessaires pour mettre l'application en marche sur votre machine locale.

 Prérequis
Pour construire et exécuter cette application, assurez-vous d'avoir les éléments suivants installés sur votre système :
- Flutter : Version 3.19.6
- Java : Version 17 (nécessaire pour le développement Android)

Installation

**Installation de Flutter**
1. Téléchargez et installez Flutter 3.19.6 depuis le [guide officiel d'installation de Flutter](https://docs.flutter.dev/get-started/install?_gl=1*1hcskrh*_up*MQ..&gclid=CjwKCAjwvIWzBhAlEiwAHHWgvfpcP7uIt-L3EccS-DB0Q4f6dxyMEd3noND_gnSc7rRql9jM88i9fxoCD08QAvD_BwE&gclsrc=aw.ds).
2. Assurez-vous que Flutter est correctement installé en exécutant :

   flutter --version
  

Installation de Java**
1. Téléchargez et installez Java 17 depuis le [site officiel d'Oracle](https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html) ou votre gestionnaire de paquets préféré.
2. Vérifiez l'installation en exécutant :


   java -version
  

**Configuration du projet**
1. Clonez le dépôt :


   git clone https://github.com/yourusername/mira.git
   cd mira


2. Installez les dépendances :

   
   flutter pub get
  

 Exécution de l'application

Android
1. Assurez-vous d'avoir un appareil Android connecté ou un émulateur en cours d'exécution.
2. Exécutez l'application :

   
   flutter run
   

iOS
1. Assurez-vous d'avoir installé et configuré Xcode.
2. Ouvrez le projet dans Xcode :

   
   open ios/Runner.xcworkspace
   

3. Compilez et exécutez l'application depuis Xcode.

Structure du projet


mira/
│
├── android/                # Code spécifique à Android
├── assets/                 # Ressources de l'application
├── ios/                    # Code spécifique à iOS
├── lib/                    # Code source Dart
├── test/                   # Tests unitaires et de widgets
├── pubspec.yaml            # Dépendances du projet
└── README.md               # Documentation du projet


Dépendances
Le projet utilise une variété de packages pour améliorer ses fonctionnalités :

- auto_size_text: ^3.0.0
- cached_network_image: ^3.2.1
- collection: ^1.17.2
- flutter_animate: 4.1.1+1
- flutter_cache_manager: ^3.3.0
- font_awesome_flutter: ^10.1.0
- from_css_color: ^2.0.0
- go_router: ^13.2.0
- google_fonts: ^4.0.3
- intl: ^0.18.1
- json_path: ^0.6.2
- page_transition: ^2.0.4
- path_provider: ^2.0.14
- path_provider_android: ^2.0.25
- path_provider_foundation: ^2.2.2
- path_provider_platform_interface: ^2.0.6
- provider: ^6.0.4
- timeago: ^3.1.0
- url_launcher: ^6.0.15
- url_launcher_android: ^6.0.27
- url_launcher_ios: ^6.1.4
- url_launcher_platform_interface: ^2.1.2
- cupertino_icons: ^1.0.2
- flutterflow_ui: ^0.2.0+1
- auth_manager: ^1.2.3
- http: ^0.13.6
- flutter_datetime_picker: ^1.5.1
- datetime_picker_formfield: ^2.0.1
- intl_phone_field: ^3.2.0
- country_icons: ^3.0.0
- flutter_launcher_icons: ^0.13.1
- animated_splash_screen: ^1.1.0-nullsafety.0
- libphonenumber_web: ^0.3.2
- libphonenumber_plugin: ^0.3.3
- intl_phone_number_input: ^0.7.4
- flutter_localization: ^0.2.0
- country_code_picker: ^3.0.0
- phone_form_field: ^9.1.0
- image_picker: ^1.0.7
- image_picker_android: ^0.8.8
- image_picker_for_web: ^3.0.1
- image_picker_ios: 0.8.8+2
- image_picker_platform_interface: ^2.9.1
- flutter_image_compress: ^2.2.0
- responsive_builder: ^0.4.3
- uuid: ^3.0.7
- intl_phone_field_localized: ^3.1.0
- file_picker: ^7.0.2
- badges: ^3.1.2

Développement et tests
- Pour exécuter les tests :

  
  flutter test
  

 Ressources supplémentaires
- [Documentation Flutter](https://docs.flutter.dev/)
- [Documentation Dart](https://dart.dev/guides)

Contribution
Si vous souhaitez contribuer à ce projet, veuillez forker le dépôt et soumettre une pull request. Assurez-vous que votre code respecte les normes de codage du projet et inclut des tests pour les nouvelles fonctionnalités.

---

Bon codage !
