import 'package:flutter/material.dart';

class EncriptacionMetodoCesarScreen extends StatefulWidget {
  const EncriptacionMetodoCesarScreen({super.key});

  @override
  _MetodoCesarScreenState createState() => _MetodoCesarScreenState();
}

class _MetodoCesarScreenState extends State<EncriptacionMetodoCesarScreen> {
  final TextEditingController _mensajeController = TextEditingController();
  final TextEditingController _desplazamientoController = TextEditingController();
  String _resultado = '';

  String _encriptarCesar(String mensaje, int desplazamiento) {
  String resultado = ''; 
  const String alfabeto = 'ABCDEFGHIJKLMNÑOPQRSTUVWXYZabcdefghijklmnñopqrstuvwxyz'; 

  for (int i = 0; i < mensaje.length; i++) {
      String letra = mensaje[i];

      int index = alfabeto.indexOf(letra);

      if (index != -1) {
        int newIndex = (index + desplazamiento) % alfabeto.length; 
        resultado += alfabeto[newIndex]; 
      } else {
        resultado += letra;
      }
    }
    return resultado;
  }


  void _encriptarMensaje() {
    String mensaje = _mensajeController.text;
    int desplazamiento = int.tryParse(_desplazamientoController.text) ?? 0;
    _resultado = _encriptarCesar(mensaje, desplazamiento); 
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text('Método de César'),
        backgroundColor: Colors.blue,
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
                    color: Colors.blue,
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
                      color: Colors.blue,
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
                      prefixIcon: const Icon(Icons.message, color: Colors.blue),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _desplazamientoController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintText: 'Escribe el desplazamiento',
                      prefixIcon: const Icon(Icons.swap_horiz, color: Colors.blue),
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
                backgroundColor: Colors.blue,
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
                        color: Colors.blue,
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

