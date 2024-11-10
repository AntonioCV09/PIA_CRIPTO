import 'package:flutter/material.dart';

class EncriptacionVigenereScreen extends StatefulWidget {
  const EncriptacionVigenereScreen({super.key});

  @override
  _EncriptacionVigenereScreenState createState() => _EncriptacionVigenereScreenState();
}

class _EncriptacionVigenereScreenState extends State<EncriptacionVigenereScreen> {
  final TextEditingController _mensajeController = TextEditingController();
  final TextEditingController _claveController = TextEditingController();
  String _resultado = '';

  String _encriptarVigenere(String mensaje, String clave) {
    const String alfabeto = 'ABCDEFGHIJKLMNÑOPQRSTUVWXYZ';
    mensaje = mensaje.toUpperCase();
    clave = clave.toUpperCase();
    String resultado = '';

    int claveIndex = 0;

    for (int i = 0; i < mensaje.length; i++) {
      String letraMensaje = mensaje[i];

      if (alfabeto.contains(letraMensaje)) {
        int posLetraMensaje = alfabeto.indexOf(letraMensaje);
        int posLetraClave = alfabeto.indexOf(clave[claveIndex % clave.length]);
        
        int nuevaPos = (posLetraMensaje + posLetraClave) % alfabeto.length;
        resultado += alfabeto[nuevaPos];

        claveIndex++;
      } else {
        resultado += letraMensaje;
      }
    }
    return resultado;
  }

  void _encriptarMensaje() {
    String mensaje = _mensajeController.text;
    String clave = _claveController.text;
    _resultado = _encriptarVigenere(mensaje, clave);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text('Método de Vigenère'),
        backgroundColor: Colors.amber,
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
                    color: Colors.amber,
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
                      color: Colors.amber,
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
                      prefixIcon: const Icon(Icons.message, color: Colors.amber),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _claveController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintText: 'Escribe la clave',
                      prefixIcon: const Icon(Icons.vpn_key, color: Colors.amber),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _encriptarMensaje,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
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
                        color: Colors.amber,
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
