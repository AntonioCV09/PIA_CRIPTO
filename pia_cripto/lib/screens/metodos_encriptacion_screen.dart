import 'package:flutter/material.dart';
import 'encriptacion_metodo_cesar_screen.dart';
import 'encriptacion_metodo_vigenere_screen.dart';
import 'encriptacion_metodo_transposicion.dart';
import 'encriptacion_metodo_RSA_screen.dart';

class MetodosEncriptacionScreen extends StatelessWidget {
  const MetodosEncriptacionScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Text('Métodos de Encriptación'),
      ),
      body: Center(  
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.count(
            shrinkWrap: true,  
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: [
              _buildMenuItem(context, Icons.lock_open, 'Método de Cesar', Colors.lightBlue, const EncriptacionMetodoCesarScreen()),
              _buildMenuItem(context, Icons.shield, 'Método de Vigenere', Colors.amber, const EncriptacionVigenereScreen()),
              _buildMenuItem(context, Icons.swap_horiz, 'Método de Transposición', Colors.deepOrange,  const MetodoTransposicionScreen()),
              _buildMenuItem(context, Icons.vpn_key, 'Método de RSA', Colors.deepPurple, const EncriptacionMetodoRSAScreen()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title, Color color, Widget screen) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
            Icon(icon, size: 50, color: color),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
