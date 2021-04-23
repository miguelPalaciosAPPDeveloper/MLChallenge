# MLChallenge
MLChallenge es el nombre otorgado a este proyecto con la finalidad de demostrar toda la experencia que se tiene en el desarrollo de aplicaciones iOS usando el lenguaje swift.

# Caracteristicas
El repositorio es publico así que no hay problema con algún acceso.
El proyecto fue desarrollado en XCode 12.0 (12A7209).
La versión de iOS permitida es iOS 14.0 o superior.
La patron de diseño elegido fue MVVM y usando clases auxiliares como Factories y builders.
Se uso también programación orientada a protocolos la cual es la más común en el desarrollo iOS.
Como gestor de libraries se uso carthage por lo tanto una vez descargado el proyecto se debe correr el siguiente comando en la terminal.

```java
./wcarthage bootstrap --platform iOS --cache-builds
```
Esto bajara los frameworks utilizados en la aplicación.

# Frameworks
Para este proyecto se utilizaron 3:

- [CoreStore](http://https://github.com/c6357/CoreStore "CoreStore") -> 5.3.1
- [Lottie](http://https://github.com/airbnb/lottie-ios "Lottie")
- [MLChallengeAPI](https://github.com/miguelPalaciosAPPDeveloper/MLChallegueAPI) -> 1.1.4

## CoreStore
CoreStore es un framework para el manejo de base de datos en iOS usando CoreData, se utilizo en este proyecto por la facilidad de gestionar las bases de datos y por la experiencia en su uso.

## Lottie
Lottie es el framework creado por Airbnb para mostrar animaciones el cual he trabajado en muchos lados y es una forma de usar animaciones espectaculares con archivos Json. Lottie se uso en este proyecto para crear un loader sencillo y los items del onboarding que aparece al inicio.

## MLChallengeAPI
MLChallengeAPI es un framework creado para este proyecto, no utiliza ningun framework que no sea nativo esto quiere decir que las peticiones se hacen mediante URLSession y la decodificación de las respuestas se hace por modelos que implementan el protocolo Codable. En esta library se encuentran los servicios de Mercado Libre para este challenge, los servicios que se utlizaron son:

- Servicio para obtener los paises donde se encuentra Mercado Libre.
- Servicio para obtener las categorias de los productos.
- Servicio para obtener las subcategorias de una categoria de productos.
- Servicio para obtener products de una categoria.
- Servicio para obtener productos de una busqueda personalizada.

# Applicación
La aplicación esta programada en Swift 5, utiliza UIKit y para la parte de MVVM se usaron closures. La app cuenta con 6 modulos principales los cuales son:

- Splash
- Onboarding
- SiteSelector
- Home
- Products
- ProductDetail

## Splash
A pesar de ser una pantalla que solo muestra el logo al inicio, para esta aplicación se consume el servicio para obtener los paises lo que permite al usuario poder cambiar de pais y buscar productos de otras localidades, por ello splash cuenta con un viewModel para todo el manejo de estos datos.

## Onboarding
Esta pantalla muestra una pequeña descripción de la aplicación en 4 escenas animadas.

## SiteSelector
Esta vista sale después del onboarding pero puede accederse desde el home si se desea cambiar de sección. Esto es algo decidi agregar para darle un poco de dinamismo a la aplicación y que se tengan valores menos estaticos por ejemplo el siteId que es el dato principal para obtener los diferentes productos y categorias de productos.

## Home
Este modulo es el encargado de mostrar las categorias de los productos de acuerdo al pais además es el que guia a los diferentes flujos cuando se quieren obtener los productos ya sea por categoria o por busqueda personalizada, la barra de busqueda solo permite caracteres alfanúmericos y espacios.

## Prdoucts
Products muestra los productos que se buscaron y las subcategorias en el caso de que se haya hecho mediante una categoria, en las celdas se puede ver poca información pero si se selecciona un producto se puede un poco más de información. Esta vista se llama en dos ocaciones y no por que genere un memory leak si no que se vuelve a llamar porque si se elige una categoria que tiene subcategorias y depués se elige una de sus subcategorias la vista oculta esa sección y solo muestra los productos, esto se me hizo más practico a que crear una vista con la misma logica y que solo oculta una parte del UI.

## ProductDetail
Esta vista unicamente muestra los detalles de un producto seleccionado previamente y el unico servicio que se llama es el de descargar la imagen del producto en dado caso que no se haya almacenado en la apliación.
