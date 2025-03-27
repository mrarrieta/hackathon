# Iconos Font Awesome

Se está usando la librería [font_awesome_flutter](https://pub.dev/packages/font_awesome_flutter) para generar los archivos necesarios y así mostrar los iconos, pero no se está integrando la librería al *pubspect* del proyecto, solo se usan los archivos generados y la estructura de esta.
De momento el proyecto usa los iconos *regular* y *light* de Font Awesome Pro.
Para agregar otros iconos (*solid*, *brand*, *thin*) se debe de generar el archivo *font_awesome_flutter.dart* y reemplazarlo en el proyecto, además de agregar las fuentes de los nuevos iconos.

Para realizar ese proceso se deben seguir los siguientes pasos:

1. Clonar el repositorio de la librería [font_awesome_flutter](https://pub.dev/packages/font_awesome_flutter).

2. Reemplazar el archivo *icons.json** dentro del proyecto clonado.

3. Reemplazar los archivos de fuentes (.ttf) de los iconos que se quieren
   generar (ya sea regular, bold, brand, etc).

4. Ejecutar el script que se encuentra en la carpeta util, excluyendo los tipos de iconos que no se utilizarán:
   `./configurator.sh -e brands,solid,duotone,thin`
   (más información sobre este script se encuentra [en este apartado](https://pub.dev/packages/font_awesome_flutter#enable-pro-icons) dentro de la documentación de la librería.)

5. Reemplazar el archivo font_awesome_flutter.dart y agregar los archivos .ttf dentro del repositorio de App en este módulo.

>\* Nota: los archivos *icons.json* y las fuentes vienen en el .zip de Font Awesome Pro que proporciona el equipo de diseño.

# Uso

``` dart
    import 'package:font_awesome_flutter/font_awesome_flutter.dart';
    
    class MyWidget extends StatelessWidget {
	    Widget build(BuildContext context) {
		    return IconButton(
			      // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
			      icon: FaIcon(FontAwesomeIcons.gamepad), 
			      onPressed: () { print("Pressed"); }
		     );
	     }
	} 
```

### Nombre de iconos

Los nombres son los mismos que [Font Awesome](https://fontawesome.com/icons), pero escritos en camel case. Si hay un estilo disponible aparte del regular, el nombre del estilo será usado como prefijo, por ejemplo para el estilo light sería *"lightFaceSmile"* y para el estilo regular *"faceSmile"*. Si el nombre del icono inicia con número este se encontrará escrito debido a las restricciones en Dart.