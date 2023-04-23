# Star Wars App

StarWars App Portfolio Project.

## Iniciando

Este proyecto, es una aplicación móvil híbrida, se utilizó flutter para crear un proyecto solo para las plataformas android y ios, las tecnologías que se utilizaron son:

- Flutter versión 2.10.2
- Null Safety Activado

## Dependencias Utilizadas

### [flutter_cube](https://pub.dev/packages/flutter_cube)

Este paquete se utiliza para mostrar objetos en 3D. En este caso, el logo que se muestra en el AppBar de la aplicación.

Este paquete simplemente renderiza el objeto y permite al usuario interactuar con él.

**Nota:** Hay que tener en cuenta que este paquete no permitía la rotación del objeto con eventos de programación (solo con la interacción del usuario), por lo que cree mi propia versión de un widget que este paquete ofrece, para poder hacerlo. (Esto solo es una aclaración, al clonar el proyecto no se debe hacer nada, ya que la modificación es dentro del código de mi app, no de la librería.)

**Nota 2:** Este paquete no detecta el movimiento del teléfono por medio del sensor.

Esto lo hago sin ningún paquete, sino haciendo llamadas a código nativo, que yo mismo escribí. El sensor utilizado es el de rotación.

### [http](https://pub.dev/packages/http)

Este paquete es utilizando para poder comunicarnos con el api de [swapi.dev](https://swapi.dev)

### [provider](https://pub.dev/packages/provider)

Utilizado para el manejo de estado de la app.

### [shared_preferences](https://pub.dev/packages/shared_preferences)

Se utiliza para guardar datos. Por ejemplo el tema seleccionado por el usuario.


## Pruebas

Se puede hacer una prueba del manejo de estados y del tema en el archivo "test/widget_test.dart"

## Screenshots

![screenshot](http://jahyrm.com/files/starwars_1.gif)

![screenshot](http://jahyrm.com/files/starwars_2.gif)

## Descarga Apk

[http://jahyrm.com/files/app-release.apk](http://jahyrm.com/files/app-release.apk)

## Recursos Utilizados

### Modelos 3D

- [poly.pizza - Death Star 1 V1](https://poly.pizza/m/8MIVor30XoN)

### Imágenes

- [StarWars A Visual Guide](https://starwars-visualguide.com/#/)

### Fuentes

- [dafont.com - Star Jedi](https://www.dafont.com/es/star-jedi.font)
- [Google Fonts - Montserrat](https://fonts.google.com/specimen/Montserrat)
