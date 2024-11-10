import 'package:flutter/material.dart';

class MetodoTransposicionScreen extends StatefulWidget {
  const MetodoTransposicionScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MetodoTransposicionScreenState createState() => _MetodoTransposicionScreenState();
}

class _MetodoTransposicionScreenState extends State<MetodoTransposicionScreen> {
  final TextEditingController _mensajeController = TextEditingController();
  final TextEditingController _columnasController = TextEditingController();
  String _resultado = '';

  // Función para encriptar el mensaje usando el método de transposición de columnas
  String _encriptarTransposicion(String mensaje, int columnas) {
    // Limpiar el mensaje de espacios y asegurar que no esté vacío
    mensaje = mensaje.replaceAll(' ', '');
    int longitud = mensaje.length;

    // Rellenar la última fila si es necesario
    int filas = (longitud / columnas).ceil(); // Número de filas
    int restante = columnas - (longitud % columnas); // Espacios vacíos a rellenar

    // Rellenamos el mensaje con caracteres de relleno si es necesario
    mensaje = mensaje.padRight(longitud + restante, '_'); // Agrega '_' como relleno

    // Crear la matriz de transposición
    List<String> matriz = [];
    for (int i = 0; i < filas; i++) {
      matriz.add(mensaje.substring(i * columnas, (i + 1) * columnas));
    }

    // Leer columna por columna
    String resultado = '';
    for (int i = 0; i < columnas; i++) {
      for (int j = 0; j < filas; j++) {
        resultado += matriz[j][i];
      }
    }

    // Ahora, separar el resultado por columnas
    String resultadoSeparado = '';
    for (int i = 0; i < resultado.length; i += columnas) {
      resultadoSeparado += '${resultado.substring(i, i + columnas)}  ';
    }

    return resultadoSeparado.trim(); // Eliminar espacios innecesarios al final
  }

  void _encriptarMensaje() {
    String mensaje = _mensajeController.text;
    int columnas = int.tryParse(_columnasController.text) ?? 3; // Número de columnas (por defecto 3)
    _resultado = _encriptarTransposicion(mensaje, columnas); // Llamada a la función de encriptación
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text('Método de Transposición'),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.deepOrange,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Ingresa el mensaje a encriptar',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.deepOrange,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _mensajeController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintText: 'Escribe aquí el mensaje',
                      prefixIcon: const Icon(Icons.message, color: Colors.deepOrange),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _columnasController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintText: 'Escribe el número de columnas',
                      prefixIcon: const Icon(Icons.grid_on, color: Colors.deepOrange),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(fontSize: 16),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _encriptarMensaje,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Encriptar',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const SizedBox(height: 40),
            if (_resultado.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'Resultado',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.deepOrange,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _resultado,
                      style: const TextStyle(fontSize: 16, color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
