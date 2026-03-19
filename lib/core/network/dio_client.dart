import 'package:dio/dio.dart';

class DioClient {
  final Dio dio; //encapsulamos dio y centralizamos la configuraicon del API

  DioClient()
    //Aqui definimos como se comportan todas las peticiones
    : dio = Dio(
      BaseOptions(
        //establecemos la URL base
        baseUrl: "https://valorant-api.com/v1",
        //definimos cuanto espera para conectarse y cuanto espera una respuesta 
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        //Definimos que se envia y se recibe un JSON
        headers: {
          "Content-Type": "application/json",
        },
      ),
    ) {
      //Establecemos interceptors (middleware) para interceptar request, response, errors
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) { // Se ejecuta antes de la peticion
            print("${options.method} ${options.path}");
            return handler.next(options);
          },
          onResponse: (response, handler) { // Se ejecuta cuando llega la respuesta
            print("${response.statusCode}");
            return handler.next(response);
          },
          onError: (e, handler) { // Se ejecuta si falla algo
            print("${e.message}");
            return handler.next(e);
          }
          // handler.next() permite que la peticion continue, si no lo llamas se bloquea
        )
      );
    }
}