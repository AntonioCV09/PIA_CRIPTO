import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPersonalScreen extends StatelessWidget {
  const InfoPersonalScreen({super.key});

  // Enlace directo al archivo .zip
  final String urlArchivo = 'https://github.com/AntonioCV09/PIA_CRIPTO.git';

  // Método para abrir el enlace
  Future<void> _abrirEnlace(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo abrir el enlace: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Text('Mi Información'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: const Color.fromARGB(255, 255, 255, 255),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Información Personal',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Nombre: Abel Antonio Castillo Valle',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Matrícula: 1965990',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Carrera: Licenciatura en Ciencias Computacionales',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Métodos de Encriptación',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: const [
                  ListTile(
                    leading: Icon(Icons.lock_open, color: Colors.lightBlue),
                    title: Text(
                      'Método de César',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Un cifrado simple que desplaza cada letra un número fijo de posiciones.',
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.lock, color: Colors.amber),
                    title: Text(
                      'Método de Vigenere',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Un cifrado que utiliza una clave repetida para cifrar el texto, proporcionando mayor seguridad.',
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.swap_horiz, color: Colors.deepOrange),
                    title: Text(
                      'Método de Transposición',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Un método que reorganiza las posiciones de los caracteres en el texto sin cambiarlos.',
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.vpn_key, color: Colors.deepPurple),
                    title: Text(
                      'Método de RSA',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Un cifrado de clave pública que utiliza factores primos grandes para asegurar los datos.',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () => _abrirEnlace(urlArchivo),
                icon: const Icon(Icons.download, color: Colors.white),
                label: const Text(
                  'Descargar Código Fuente',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  shadowColor: Colors.greenAccent,
                  elevation: 5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
