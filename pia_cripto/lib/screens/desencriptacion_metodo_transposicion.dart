import 'package:flutter/material.dart';

class MetodoTransposicionDesencriptarScreen extends StatefulWidget {
  const MetodoTransposicionDesencriptarScreen({super.key});

  @override
  _MetodoTransposicionDesencriptarScreenState createState() => _MetodoTransposicionDesencriptarScreenState();
}

class _MetodoTransposicionDesencriptarScreenState extends State<MetodoTransposicionDesencriptarScreen> {
  final TextEditingController _mensajeController = TextEditingController();
  final TextEditingController _columnasController = TextEditingController();
  String _resultado = '';

  // Función para desencriptar el mensaje usando el método de transposición de columnas
  String _desencriptarTransposicion(String mensaje, int columnas) {
    // Limpiar el mensaje de espacios
    mensaje = mensaje.replaceAll(' ', '');
    int longitud = mensaje.length;
    int filas = (longitud / columnas).ceil();

    // Calcular cuántos caracteres faltan para completar la matriz
    int caracteresRelleno = (filas * columnas) - longitud;

    // Crear la matriz para la transposición inversa
    List<String> matriz = List.generate(filas, (index) => '');

    int mensajeIndex = 0;
    for (int i = 0; i < columnas; i++) {
      for (int j = 0; j < filas; j++) {
        // Evitar los caracteres de relleno en la última columna
        if (j == filas - 1 && i >= columnas - caracteresRelleno) continue;

        matriz[j] += mensaje[mensajeIndex];
        mensajeIndex++;
      }
    }

    // Combinar las filas para obtener el mensaje original
    return matriz.join();
  }

  void _desencriptarMensaje() {
    String mensaje = _mensajeController.text;
    int columnas = int.tryParse(_columnasController.text) ?? 3; // Número de columnas (por defecto 3)
    _resultado = _desencriptarTransposicion(mensaje, columnas); // Llamada a la función de desencriptación
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text('Desencriptar Transposición'),
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
                    'Ingresa el mensaje a desencriptar',
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
                      hintText: 'Escribe aquí el mensaje encriptado',
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
              onPressed: _desencriptarMensaje,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Desencriptar',
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
